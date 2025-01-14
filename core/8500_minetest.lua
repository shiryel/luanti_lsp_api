---@meta

---Minetest 5.10 [568f7a8](https://github.com/minetest/minetest/blob/568f7a8e8fb457c7b7bcfd3211c7f3f0481ed2e7/doc/lua_api.md) API
---
---* [Official site](https://www.luanti.org/)
---* [Developer Wiki](https://dev.luanti.org/)
---* [Unofficial Modding Book](https://rubenwardy.com/minetest_modding_book/)
---@class mt.Core
core = {
  CONTENT_AIR = 126,
  CONTENT_IGNORE = 127,
  CONTENT_UNKNOWN = 125,
  EMERGE_CANCELLED = 0,
  EMERGE_ERRORED = 1,
  EMERGE_FROM_DISK = 3,
  EMERGE_FROM_MEMORY = 2,
  EMERGE_GENERATED = 4,
  LIGHT_MAX = 14,
  MAP_BLOCKSIZE = 16,
  PLAYER_MAX_BREATH_DEFAULT = 10,
  PLAYER_MAX_HP_DEFAULT = 20,
  nodedef_default = {} ---@type mt.NodeDef
}