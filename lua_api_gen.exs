#!elixir

Mix.install([])

# NOTE:
# --[[ comments are not supported!
defmodule Extract do
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
    if String.ends_with?(path, ".md") do
      %{docs: File.read!(path)}
    else
      File.stream!(path)
      |> Enum.reduce(
        [@init],
        fn
          "---@" <> _ = _line, acc ->
            acc

          "---|" <> _ = _line, acc ->
            acc

          "---" <> line, [%{docs: docs} = prev_acc | rest_acc] ->
            [%{prev_acc | docs: docs ++ [line]} | rest_acc]

          _line, acc ->
            acc
        end
      )
      |> Enum.reverse()
    end
  end
end

core =
  File.ls!("./core/")
  |> Enum.map(fn name ->
    [number, new_name] = String.split(name, "_", parts: 2)
    number = String.to_integer(number)

    {:core, number, new_name}
  end)

definitions =
  File.ls!("./definitions/")
  |> Enum.map(fn name ->
    [number, new_name] = String.split(name, "_", parts: 2)
    number = String.to_integer(number)

    {:definitions, number, new_name}
  end)

(core ++ definitions)
|> Enum.sort_by(fn {_t, number, _name} -> number end)
|> Enum.map(fn {t, number, name} ->
  {t, Integer.to_string(number) |> String.pad_leading(4, "0"), name}
end)
|> Enum.map(fn
  {:definitions, number, name} ->
    Extract.run("./definitions/#{number}_#{name}")

  {:core, number, name} ->
    Extract.run("./core/#{number}_#{name}")
end)
|> List.flatten()
|> Enum.map(fn
  %{docs: docs} ->
    docs
end)
|> List.flatten()
|> Enum.join("")
|> then(&File.write!("lua_api_gen.md", &1))
