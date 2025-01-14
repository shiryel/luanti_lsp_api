---@meta
---Registered definition tables
-------------------------------

---Map of registered items, indexed by name.
---@type table<string, mt.ItemDef|mt.NodeDef>
core.registered_items = {}

---Map of registered node definitions, indexed by name.
---@type table<string, mt.NodeDef>
core.registered_nodes = {}

---Map of registered craft item definitions, indexed by name.
---@type table<string, mt.ItemDef>
core.registered_craftitems = {}

---Map of registered tool definitions, indexed by name.
---@type table<string, mt.ItemDef>
core.registered_tools = {}

--- Map of registered entity prototypes, indexed by name.
---
--- * Values in this table may be modified directly.
--- * Note: changes to initial properties will only affect entities spawned afterwards,
---   as they are only read when spawning.
---@type table<string, mt.EntityDef>
core.registered_entities = {}

---@alias mt.ObjectID userdata

---Map of object references, indexed by active object id.
---@type table<mt.ObjectID, mt.ObjectRef>
core.object_refs = {}

---Map of Lua entities, indexed by active object id.
---@type table<mt.ObjectID, mt.LuaObjectRef>
core.luaentities = {}

---List of ABM definitions.
---@type mt.ABMDef[]
core.registered_abms = {}

---List of LBM definitions.
---@type mt.LBMDef[]
core.registered_lbms = {}

---Map of registered aliases, indexed by name.
---@type table<string, string>
core.registered_aliases = {}

--- * Map of registered ore definitions, indexed by the `name` field.
--- * If `name` is nil, the key is the object handle returned by
---   `core.register_ore`.
---@type table<string|number, mt.OreDef>
core.registered_ores = {}

--- * Map of registered biome definitions, indexed by the `name` field.
--- * If `name` is nil, the key is the object handle returned by
---   `core.register_biome`.
---@type table<string|number, mt.BiomeDef>
core.registered_biomes = {}

--- * Map of registered decoration definitions, indexed by the `name` field.
--- * If `name` is nil, the key is the object handle returned by
---   `core.register_decoration`.
---@type table<string|number, mt.DecorDef>
core.registered_decorations = {}

--- * Map of registered schematic definitions, indexed by the `name` field.
--- * If `name` is nil, the key is the object handle returned by
---   `core.register_schematic`.
---@type table<string|number, mt.SchematicSpec>
core.registered_schematics = {}

--- Map of registered chat command definitions, indexed by name.
---@type table<string, mt.ChatCmdDef>
core.registered_chatcommands = {}

--- * Map of registered privilege definitions, indexed by name.
--- * Registered privileges can be modified directly in this table.
---@type table<string, mt.PrivDef>
core.registered_privileges = {}