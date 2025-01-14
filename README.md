# Minetest 5.10 LSP API

These API-headers are made for [lua-language-server].

Configure your `.luarc.json` as follow:

```json
{
  "runtime.version": "LuaJIT",
  "workspace.ignoreSubmodules": false,
  "workspace.library": [
    "./luanti_lsp_api/core",
    "./luanti_lsp_api/definitions",
  ],
  "workspace.ignoreDir": [
    "./luanti_lsp_api/core_template"
  ]
}
```

For lua-language-server configuration, see [LuaLS Wiki on configuring libraries].

## Contributing

Use `lua_api_gen.exs` to generate a `lua_api_gen.md`, use delta or diff to check what needs to be updated on the `./definitions`, e.g.:
```bash
delta lua_api.md lua_api_gen.md
```
> Note: you can omit text from the generated `lua_api_gen.md` by using `--` instead of `---`, useful for when needing to re-order some text from the original docs

[lua-language-server]: https://github.com/LuaLS/lua-language-server
[LuaLS Wiki on configuring libraries]: https://github.com/LuaLS/lua-language-server/wiki/Libraries#custom
