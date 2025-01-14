---@meta
---Registration functions
-------------------------

--- 
---@param name string
---@param definition mt.NodeDef
function core.register_node(name, definition) end


--- 
---@param name string
---@param item mt.ItemDef
function core.register_craftitem(name, item) end


--- 
---@param name string
---@param item mt.ItemDef
function core.register_tool(name, item) end


--- * `redefinition` is a table of fields `[name] = new_value`,
--- overwriting fields of or adding fields to the existing definition.
--- * `del_fields` is a list of field names to be set
--- to `nil` ("deleted from") the original definition.
--- * Overrides fields of an item registered with register_node/tool/craftitem.
--- * Note: Item must already be defined, (opt)depend on the mod defining it.
--- * Example: `core.override_item("default:mese",
--- {light_source=core.LIGHT_MAX}, {"sounds"})`:
--- Overwrites the `light_source` field,
--- removes the sounds from the definition of the mese block.
---@param name string
---@param redefinition table
---@param del_fields string[]
function core.override_item(name, redefinition, del_fields) end


--- * Unregisters the item from the engine, and deletes the entry with key
--- `name` from `core.registered_items` and from the associated item table
--- according to its nature: `core.registered_nodes`, etc.
---@param name string
function core.unregister_item(name) end


--- 
---@param name string
---@param entity mt.EntityDef
function core.register_entity(name, entity) end


--- 
---@param abm mt.ABMDef
function core.register_abm(abm) end


--- 
---@param lbm mt.LBMDef
function core.register_lbm(lbm) end


--- * Also use this to set the 'mapgen aliases' needed in a game for the core
--- mapgens. See [Mapgen aliases] section above.
---@param alias string
---@param original_name string
function core.register_alias(alias, original_name) end


--- 
---@param alias string
---@param original_name string
function core.register_alias_force(alias, original_name) end


--- * Returns an integer object handle uniquely identifying the registered
--- ore on success.
--- * The order of ore registrations determines the order of ore generation.
---@param ore mt.OreDef
---@return integer handle Uniquely identifying the registered ore on success.
function core.register_ore(ore) end


--- * Returns an integer object handle uniquely identifying the registered
--- biome on success. To get the biome ID, use `core.get_biome_id`.
---@param biome mt.BiomeDef
---@return integer handle Uniquely identifying the registered biome on success.
function core.register_biome(biome) end


--- * Unregisters the biome from the engine, and deletes the entry with key
--- `name` from `core.registered_biomes`.
--- * Warning: This alters the biome to biome ID correspondences, so any
--- decorations or ores using the 'biomes' field must afterwards be cleared
--- and re-registered.
---@param name string
function core.unregister_biome(name) end


--- * Returns an integer object handle uniquely identifying the registered
--- decoration on success. To get the decoration ID, use
--- `core.get_decoration_id`.
--- * The order of decoration registrations determines the order of decoration
--- generation.
---@param decoration mt.DecorDef
---@return integer handle Uniquely identifying the registered biome on success.
function core.register_decoration(decoration) end


--- * Returns an integer object handle uniquely identifying the registered
--- schematic on success.
--- * If the schematic is loaded from a file, the `name` field is set to the
--- filename.
--- * If the function is called when loading the mod, and `name` is a relative
--- path, then the current mod path will be prepended to the schematic
--- filename.
---@param schematic mt.SchematicSpec
---@return integer handle Uniquely identifying the registered biome on success.
function core.register_schematic(schematic) end


--- * Clears all biomes currently registered.
--- * Warning: Clearing and re-registering biomes alters the biome to biome ID
--- correspondences, so any decorations or ores using the 'biomes' field must
--- afterwards be cleared and re-registered.
function core.clear_registered_biomes() end


--- * Clears all decorations currently registered.
function core.clear_registered_decorations() end


--- * Clears all ores currently registered.
function core.clear_registered_ores() end


--- * Clears all schematics currently registered.
function core.clear_registered_schematics() end


---### Gameplay

--- * Check recipe table syntax for different types below.
---@param recipe mt.CraftRecipe
function core.register_craft(recipe) end


--- * Will erase existing craft based either on output item or on input recipe.
--- * Specify either output or input only. If you specify both, input will be
--- ignored. For input use the same recipe table syntax as for
--- `core.register_craft(recipe)`. For output specify only the item,
--- without a quantity.
--- * Returns false if no erase candidate could be found, otherwise returns true.
--- * **Warning**! The type field ("shaped", "cooking" or any other) will be
--- ignored if the recipe contains output. Erasing is then done independently
--- from the crafting method.
---@param recipe mt.CraftRecipe
function core.clear_craft(recipe) end


--- 
---@param name string
---@param cmd mt.ChatCmdDef
function core.register_chatcommand(name, cmd) end


--- * Overrides fields of a chatcommand registered with `register_chatcommand`.
---@param name string
---@param cmd mt.ChatCmdDef
function core.override_chatcommand(name, cmd) end


--- * Unregisters a chatcommands registered with `register_chatcommand`.
---@param name string
function core.unregister_chatcommand(name) end


--- * `definition` can be a description or a definition table (see [Privilege
--- definition]).
--- * If it is a description, the priv will be granted to singleplayer and admin
--- by default.
--- * To allow players with `basic_privs` to grant, see the `basic_privs`
--- minetest.conf setting.
---@param name string
---@param priv unknown|mt.PrivDef
function core.register_privilege(name, priv) end


--- * Registers an auth handler that overrides the builtin one.
--- * This function can be called by a single mod once only.
---@param handler mt.AuthHandlerDef
function core.register_authentication_handler(handler) end