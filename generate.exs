#!elixir

Mix.install([])

IO.puts("NOTE: This tool may give false positive warnings! (Sorry, I made it in just a day)")
IO.puts("")

defmodule ExtractDoc do
  @doc """
    %{
      arity: 5,
      function: "core.create_schematic(p1, p2, probability_list, filename, slice_prob_list)",
      description: ["\n",
       "    * Create a schematic from the volume of map specified by the box formed by\n",
       "      p1 and p2.\n", ...],
      expect_function?: false,
      expect_description?: false,
      fname: "core.create_schematic"
    }
  """
  def run(path) do
    File.stream!(path)
    |> Enum.reduce(
      [],
      fn
        # function definitions can end on other lines, so we process it in 2 steps
        "* `" <> rest, acc ->
          if String.contains?(rest, "core.") and String.contains?(rest, "(") do
            step_1(rest, acc)
          else
            acc
          end

        line, [%{function: prev_function, expect_function?: true} = prev_acc | rest_acc] ->
          step_2(line, prev_function, prev_acc, rest_acc)

        # after the function is done, we get its description, until the next function is found or a empty line
        line, [%{description: description, expect_description?: true} = prev_acc | rest_acc] ->
          if String.trim(line) == "" do
            [%{prev_acc | expect_description?: false} | rest_acc]
          else
            [%{prev_acc | description: description ++ [line]} | rest_acc]
          end

        # ignore everything else
        _line, acc ->
          acc
      end
    )
  end

  def step_1(rest, acc) do
    if String.contains?(rest, "`") do
      [function, description] = String.split(rest, "`", parts: 2, trim: true)

      state = %{
        function: function,
        description: [description],
        expect_function?: false,
        expect_description?: true
      }

      [state | acc]
    else
      state = %{
        function: rest,
        description: [],
        expect_function?: true,
        expect_description?: true
      }

      [state | acc]
    end
  end

  def step_2(line, prev_function, prev_acc, rest_acc) do
    if String.contains?(line, "`") do
      [function, description] = String.split(line, "`", parts: 2, trim: true)

      state = %{
        prev_acc
        | function: prev_function <> function,
          description: [description],
          expect_function?: false
      }

      [state | rest_acc]
    else
      state = %{
        prev_acc
        | function: prev_function <> line
      }

      [state | rest_acc]
    end
  end
end

# NOTE:
# --[[ comments are not supported!
defmodule ExtractTemplate do
  @init %{docs: [], params: [], next: [], function: nil}

  @doc """
    %{
      arity: 2,
      function: "function auth.create_auth(name, password) end\n",
      next: [],
      params: ["---@param name string\n", "---@param password string\n"],
      docs: ["-- * Create new auth data for player `name`.\n",
       "-- * Note that `password` is not plain-text but an arbitrary\n",
       "--   representation decided by the engine.\n"],
      fname: "auth.create_auth"
    },
  """
  def run(path) do
    File.stream!(path)
    |> Enum.reduce(
      [@init],
      fn
        "function " <> _ = line, [prev_acc | rest_acc] ->
          [@init, %{prev_acc | function: line}] ++ rest_acc

        # just to keep @meta on the start of the file
        "---@meta" <> _ = line, [%{docs: docs} = prev_acc | rest_acc] ->
          [%{prev_acc | docs: docs ++ [line]} | rest_acc]

        "---@" <> _ = line, [%{params: params} = prev_acc | rest_acc] ->
          [%{prev_acc | params: params ++ [line]} | rest_acc]

        "-" <> _ = line, [%{docs: docs} = prev_acc | rest_acc] ->
          [%{prev_acc | docs: docs ++ [line]} | rest_acc]

        line, [%{next: next} = prev_acc | rest_acc] = acc ->
          if String.trim(line) == "" do
            [@init | acc]
          else
            # for multi-line function definitions
            [%{prev_acc | next: next ++ [line]} | rest_acc]
          end
      end
    )
  end
end

defmodule Utils do
  def generate_files_for_path(extracted_docs, path) do
    File.ls!("./template/#{path}")
    |> Enum.filter(&String.ends_with?(&1, ".lua"))
    |> Enum.map(fn name ->
      ExtractTemplate.run("./template/#{path}/#{name}")
      |> Enum.reverse()
      |> Enum.map(&Utils.gen_function_metadata/1)
      |> generate_file(extracted_docs, "./results/#{path}/#{name}")
    end)
    |> List.flatten()
  end

  defp generate_file(template_data, extracted_docs, path) do
    Enum.map(template_data, fn
      %{fname: fname, arity: arity, docs: docs, params: params, function: function, next: next} ->
        extracted = Utils.find_function(extracted_docs, fname, arity)

        if extracted do
          {first, rest} =
            extracted.description
            |> Enum.map(&String.replace(&1, ~r|^:[\ ]*|, ""))
            |> Enum.reject(&(String.trim(&1) == ""))
            |> Enum.map(&String.trim/1)
            |> Enum.join("\n--- ")
            |> String.split_at(1)

          description_normalized = String.capitalize(first) <> rest

          """
          --- #{description_normalized}\n#{Enum.join(params, "")}#{function}#{Enum.join(next, "")}
          """
        else
          IO.puts("Template #{fname} /#{arity} not found on .md docs")

          """
          #{Enum.join(docs, "")}#{Enum.join(params, "")}#{function}#{Enum.join(next, "")}
          """
        end

      %{docs: docs, params: params, function: nil, next: next} ->
        """
        #{Enum.join(docs, "")}#{Enum.join(params, "")}#{Enum.join(next, "")}
        """
    end)
    |> Enum.join("")
    |> String.trim()
    |> then(&File.write!(path, &1))
  end

  def gen_function_metadata(%{function: nil} = map), do: map
  def gen_function_metadata(%{function: "function " <> function} = map), do: gen(map, function)
  def gen_function_metadata(%{function: function} = map), do: gen(map, function)

  defp gen(map, function) do
    if String.contains?(function, "(") do
      [name, args] = String.split(function, "(", parts: 2)
      mid_args = String.split(args, ")", parts: 2) |> List.first()

      # quick fix for when a function has a callback on the args
      # TODO: improve this to avoid false positives
      arity =
        if String.contains?(mid_args, "function") do
          1
        else
          String.split(mid_args, ",") |> length()
        end

      Map.put(map, :fname, name)
      |> Map.put(:arity, arity)
    else
      Map.put(map, :fname, function)
      |> Map.put(:arity, 0)
    end
  end

  def find_function(map_list, fname, arity) do
    Enum.find(map_list, fn map ->
      map[:fname] == fname and map[:arity] == arity
    end)
  end
end

IO.puts("Insert path to Luanti (e.g. '../minetest'):")
path = (IO.read(:stdio, :line) |> String.trim()) <> "/doc"

# TODO?: maybe search all .md paths on the future
# File.ls!(path)
# |> Enum.filter(&String.ends_with?(&1, ".md"))
extracted_docs =
  ["lua_api.md"]
  |> Enum.map(fn name ->
    IO.puts("Searching on: #{path}/#{name}")
    ExtractDoc.run("#{path}/#{name}")
  end)
  |> List.flatten()
  |> Enum.map(&Utils.gen_function_metadata/1)

#
# Generate ./results
#

IO.puts("---------------------")
IO.puts("Generating results...")
IO.puts("---------------------")

Utils.generate_files_for_path(extracted_docs, "core")
Utils.generate_files_for_path(extracted_docs, "classes")
Utils.generate_files_for_path(extracted_docs, "definitions")

#
# Check which docs are missing of the templates
#

IO.puts("-------------------------------------------")
IO.puts("Searching for functions not on templates...")
IO.puts("-------------------------------------------")

template_data =
  File.ls!("./template/core")
  |> Enum.filter(&String.ends_with?(&1, ".lua"))
  |> Enum.map(fn name ->
    ExtractTemplate.run("./template/core/#{name}")
    |> Enum.reverse()
    |> Enum.map(&Utils.gen_function_metadata/1)
  end)
  |> List.flatten()

Enum.map(extracted_docs, fn
  %{fname: fname, arity: arity} ->
    if !Utils.find_function(template_data, fname, arity) do
      IO.puts("Could not find #{fname} /#{arity}")
    end
end)
