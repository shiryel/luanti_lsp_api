---@meta
---Global objects
-----------------

--- `EnvRef` of the server environment and world.
--- - Any function in the core namespace can be called using the syntax
---   `core.env:somefunction(somearguments)` instead of
---   `core.somefunction(somearguments)`
--- - Deprecated, but support is not to be dropped soon.
---@type mt.Core
core.env = nil

---Global callback registration functions
-----------------------------------------

--- * Called every server step, usually interval of 0.1s.
--- * `dtime` is the time since last execution in seconds.
---@param func fun(dtime: number)
function core.register_globalstep(func) end


---Map of registered globalsteps.
---@type fun(dtime: number)[]
core.registered_globalsteps = {}

--- * Called after mods have finished loading and before the media is cached or the
--- aliases handled.
---@param func fun()
function core.register_on_mods_loaded(func) end


---Map of registered on_mods_loaded.
---@type fun()[]
core.registered_on_mods_loaded = {}

--- * Called before server shutdown
--- * Players that were kicked by the shutdown procedure are still fully accessible
--- in `core.get_connected_players()`.
--- * **Warning**: If the server terminates abnormally (i.e. crashes), the
--- registered callbacks **will likely not be run**. Data should be saved at
--- semi-frequent intervals as well as on server shutdown.
---@param func fun()
function core.register_on_shutdown(func) end


--- Called always when a client receive a message.
---
--- * Return `true` to mark the message as handled,
--- which means that it will not be shown to chat.
---@param func fun(message:string):boolean?
function core.register_on_receiving_chat_message(func) end


--- Called always when a client sends a message from chat
---
--- * Return `true` to mark the message as handled,
--- which means that it will not be sent to server
---@param func fun(message:string):boolean?
function core.register_on_sending_chat_message(func) end


--- Called when the local player dies.
---@param func fun()
function core.register_on_death(func) end


--- Called when server modified player's HP.
---@param func fun(hp:number)
function core.register_on_hp_modification(func) end


--- Called when the local player take damages.
---@param func fun(hp:number)
function core.register_on_damage_taken(func) end


---Map of registered on_shutdown.
---@type fun()[]
core.registered_on_shutdown = {}

--- * Called when a node has been placed
--- * If return `true` no item is taken from `itemstack`
--- * `placer` may be any valid ObjectRef or nil.
--- * **Not recommended**; use `on_construct` or `after_place_node` in node
--- definition whenever possible.
---@param func fun(pos: mt.Vector, newnode: string, placer?: mt.ObjectRef, oldnode: string, itemstack: mt.Item, pointed_thing: mt.PointedThing): boolean|nil
function core.register_on_placenode(func) end


---Map of registered on_placenode.
---@type (fun(pos: mt.Vector, newnode: mt.Node, placer?: mt.ObjectRef, oldnode: mt.Node, itemstack: mt.Item, pointed_thing: mt.PointedThing): boolean|nil)[]
core.registered_on_placenodes = {}

--- * Called when a node has been dug.
--- * **Not recommended**; Use `on_destruct` or `after_dig_node` in node
--- definition whenever possible.
---@param func fun(pos: mt.Vector, oldnode: mt.Node|string, digger: mt.ObjectRef|nil)
function core.register_on_dignode(func) end


---Map of registered on_dignode.
---@type fun(pos: mt.Vector, oldnode: mt.Node|string, digger: mt.ObjectRef)[]
core.registered_on_dignodes = {}

--- * Called when a node is punched
---@param func fun(pos: mt.Vector, node: mt.Node, puncher: mt.ObjectRef, pointed_thing: mt.PointedThing)
function core.register_on_punchnode(func) end


---Map of registered on_punchnode.
---@type fun(pos: mt.Vector, node: mt.Node, puncher: mt.ObjectRef, pointed_thing: mt.PointedThing)[]
core.registered_on_punchnodes = {}

--- * Called after the engine mapgen finishes a chunk but before it is written to
--- the map.
--- * Chunk data resides in `vmanip`. Other parts of the map are not accessible.
--- The area of the chunk if comprised of `minp` and `maxp`, note that is smaller
--- than the emerged area of the VoxelManip.
--- Note: calling `read_from_map()` or `write_to_map()` on the VoxelManipulator object
--- is not necessary and is disallowed.
--- * `blockseed`: 64-bit seed number used for this chunk
---@param func fun(minp: integer, maxp: integer, blockseed: integer)
function core.register_on_generated(func) end


--- * Saves data for retrieval using the gennotify mechanism (see [Mapgen objects]).
--- * Data is bound to the chunk that is currently being processed, so this function
--- only makes sense inside the `on_generated` callback.
--- * `id`: user-defined ID (a string)
--- By convention these should be the mod name with an optional
--- colon and specifier added, e.g. `"default"` or `"default:dungeon_loot"`
--- * `data`: any Lua object (will be serialized, no userdata allowed)
--- * returns `true` if the data was remembered. That is if `core.set_gen_notify`
--- was called with the same user-defined ID before.
---@param id string
---@param data any
---@return boolean
function core.save_gen_notify(id, data) end


---Map of registered on_generated.
---@type fun(minp: integer, maxp: integer, blockseed: integer)[]
core.registered_on_generateds = {}

--- * Called when a new player enters the world for the first time
---@param func fun(player: mt.PlayerObjectRef)
function core.register_on_newplayer(func) end


---Map of registered on_newplayer.
---@type fun(player: mt.PlayerObjectRef)[]
core.registered_on_newplayers = {}

--- * Called when a player is punched
--- * Note: This callback is invoked even if the punched player is dead.
--- * `player`: ObjectRef - Player that was punched
--- * `hitter`: ObjectRef - Player that hit. Can be nil.
--- * `time_from_last_punch`: Meant for disallowing spamming of clicks
--- (can be nil).
--- * `tool_capabilities`: Capability table of used item (can be nil)
--- * `dir`: Unit vector of direction of punch. Always defined. Points from
--- the puncher to the punched.
--- * `damage`: Number that represents the damage calculated by the engine
--- * should return `true` to prevent the default damage mechanism
---@param func fun(player: mt.PlayerObjectRef, hitter: mt.ObjectRef, time_from_last_punch: number, tool_capabilities: mt.ToolCaps, dir: mt.Vector, damage: number): boolean|nil
function core.register_on_punchplayer(func) end


---Map of registered on_punchplayer.
---@type (fun(player: mt.PlayerObjectRef, hitter: mt.ObjectRef, time_from_last_punch: number, tool_capabilities: mt.ToolCaps, dir: mt.Vector, damage: number): boolean)[]
core.registered_on_punchplayers = {}

--- * Called when the 'place/use' key was used while pointing a player
--- (not necessarily an actual rightclick)
--- * `player`: ObjectRef - Player that is acted upon
--- * `clicker`: ObjectRef - Object that acted upon `player`, may or may not be a player
---@param func fun(player: mt.PlayerObjectRef, clicker: mt.ObjectRef)
function core.register_on_rightclickplayer(func) end


---Map of registered on_rightclickplayer.
---@type fun(player: mt.PlayerObjectRef, clicker: mt.ObjectRef)[]
core.registered_on_rightclickplayers = {}

---Register a function that will be called when a player is damaged or healed.
---Note: modifiers only get a temporary `hp_change` that can be modified by later modifiers.
---
---Modifiers can return true as a second argument to stop the execution of further functions.
---
---Non-modifiers receive the final HP change calculated by the modifiers.
---@param func fun(player: mt.PlayerObjectRef, hp_change: integer, reason: mt.PlayerHPChangeReason): integer?, boolean?
---@param modifier boolean|nil  When true, the function should return the actual `hp_change`.
function core.register_on_player_hpchange(func, modifier) end


--- A mod or the engine called `set_hp` without giving a type -
--- use this for custom damage types.
--- Was punched. `reason.object` will hold the puncher, or nil if none.
--- `damage_per_second` from a neighboring node.
--- When true, the function should return the actual `hp_change`.
---
--- Note: modifiers only get a temporary `hp_change` that can be modified by
--- later modifiers. Modifiers can return true as a second argument to stop the
--- execution of further functions. Non-modifiers receive the final HP change
--- calculated by the modifiers.
---@class mt.PlayerHPChangeReason
---@field type
---|"set_hp"
---|"punch"
---|"fall"
---|"node_damage"
---|"drown"
---|"respawn"
---@field object mt.ObjectRef|nil
---@field node string|nil Node name (when `type` is `"node"`).
---@field node_pos mt.Vector|nil Node position (when `type` is `"node"`).
---@field from
---|"mod"
---|"engine"
---@field modifier boolean

---Map of registered on_player_hpchange.
---@type {modifiers: (fun(player: mt.PlayerObjectRef, hp_change: integer, reason: mt.PlayerHPChangeReason): integer?, boolean?)[], loggers: (fun(player: mt.PlayerObjectRef, hp_change: integer, reason: mt.PlayerHPChangeReason): integer?, boolean?)[]}
core.registered_on_player_hpchanges = { modifiers = {}, loggers = {} }

--- * Called when a player dies
--- * `reason`: a PlayerHPChangeReason table, see register_on_player_hpchange
--- * For customizing the death screen, see `core.show_death_screen`.
---@param func fun(player: mt.PlayerObjectRef, reason: mt.PlayerHPChangeReason)
function core.register_on_dieplayer(func) end


---Map of registered on_dieplayers.
---@type fun(player: mt.PlayerObjectRef, reason: mt.PlayerHPChangeReason)[]
core.registered_on_dieplayers = {}

--- * Called when player is to be respawned
--- * Called _before_ repositioning of player occurs
--- * return true in func to disable regular player placement
---@param func fun(player: mt.PlayerObjectRef): boolean|nil
function core.register_on_respawnplayer(func) end


---Map of registered on_respawnplayer.
---@type (fun(player: mt.PlayerObjectRef): boolean|nil)[]
core.registered_on_respawnplayers = {}

--- * Called when a client connects to the server, prior to authentication
--- * If it returns a string, the client is disconnected with that string as
--- reason.
---@param func fun(name: string, ip: string): string
function core.register_on_prejoinplayer(func) end


---Map of registered on_prejoinplayer.
---@type (fun(name: string, ip: string): string)[]
core.registered_on_prejoinplayers = {}

--- * Called when a player joins the game
--- * `last_login`: The timestamp of the previous login, or nil if player is new
---@param func fun(player: mt.PlayerObjectRef, last_login?: integer)
function core.register_on_joinplayer(func) end


---Map of registered on_joinplayer.
---@type fun(player: mt.PlayerObjectRef, last_login?: integer)[]
core.registered_on_joinplayers = {}

--- * Called when a player leaves the game
--- * Does not get executed for connected players on shutdown.
--- * `timed_out`: True for timeout, false for other reasons.
---@param func fun(player: mt.PlayerObjectRef, timed_out: boolean|nil)
function core.register_on_leaveplayer(func) end


---Map of registered on_leaveplayer.
---@type fun(player: mt.PlayerObjectRef, timed_out: boolean|nil)[]
core.registered_on_leaveplayers = {}

--- * Called when a client attempts to log into an account.
--- * `name`: The name of the account being authenticated.
--- * `ip`: The IP address of the client
--- * `is_success`: Whether the client was successfully authenticated
--- * For newly registered accounts, `is_success` will always be true
---@param func fun(name: string, ip: string, is_success: boolean|nil)
function core.register_on_authplayer(func) end


---@type fun(name: string, ip: string, is_success: boolean|nil)[]
core.registered_on_authplayers = {}

--- * Deprecated: use `core.register_on_authplayer(name, ip, is_success)` instead.
---@deprecated
---@param func fun(name: string, ip: string)
function core.register_on_auth_fail(func) end


--- * Called when a player cheats
--- * `cheat`: `{type=<cheat_type>}`, where `<cheat_type>` is one of:
--- * `moved_too_fast`
--- * `interacted_too_far`
--- * `interacted_with_self`
--- * `interacted_while_dead`
--- * `finished_unknown_dig`
--- * `dug_unbreakable`
--- * `dug_too_fast`
---@param func fun(player: mt.PlayerObjectRef, cheat: {type: '"moved_too_fast"'|'"interacted_too_far"'|'"interacted_with_self"'|'"interacted_while_dead"'|'"finished_unknown_dig"'|'"dug_unbreakable"'|'"dug_too_fast"'})
function core.register_on_cheat(func) end


---Map of registered on_cheat.
---@type fun(player: mt.PlayerObjectRef, cheat: {type: '"moved_too_fast"'|'"interacted_too_far"'|'"interacted_with_self"'|'"interacted_while_dead"'|'"finished_unknown_dig"'|'"dug_unbreakable"'|'"dug_too_fast"'})[]
core.registered_on_cheats = {}

--- * Called always when a player says something
--- * Return `true` to mark the message as handled, which means that it will
--- not be sent to other players.
---@param func fun(name: string, message: string): boolean|nil
function core.register_on_chat_message(func) end


---Map of registered on_chat_message.
---@type (fun(name: string, message: string): boolean|nil)[]
core.registered_on_chat_messages = {}

--- * Called always when a chatcommand is triggered, before `core.registered_chatcommands`
--- is checked to see if the command exists, but after the input is parsed.
--- * Return `true` to mark the command as handled, which means that the default
--- handlers will be prevented.
---@param func fun(name: string, command: string, params: string)
function core.register_on_chatcommand(func) end


---Map of registered on_chatcommand.
---@type fun(name: string, command: string, params: string)[]
core.registered_on_chatcommands = {}

--- * Called when the server received input from `player`.
--- Specifically, this is called on any of the
--- following events:
--- * a button was pressed,
--- * Enter was pressed while the focus was on a text field
--- * a checkbox was toggled,
--- * something was selected in a dropdown list,
--- * a different tab was selected,
--- * selection was changed in a textlist or table,
--- * an entry was double-clicked in a textlist or table,
--- * a scrollbar was moved, or
--- * the form was actively closed by the player.
--- * `formname` is the name passed to `core.show_formspec`.
--- Special case: The empty string refers to the player inventory
--- (the formspec set by the `set_inventory_formspec` player method).
--- * Fields are sent for formspec elements which define a field. `fields`
--- is a table containing each formspecs element value (as string), with
--- the `name` parameter as index for each. The value depends on the
--- formspec element type:
--- * `animated_image`: Returns the index of the current frame.
--- * `button` and variants: If pressed, contains the user-facing button
--- text as value. If not pressed, is `nil`
--- * `field`, `textarea` and variants: Text in the field
--- * `dropdown`: Either the index or value, depending on the `index event`
--- dropdown argument.
--- * `tabheader`: Tab index, starting with `"1"` (only if tab changed)
--- * `checkbox`: `"true"` if checked, `"false"` if unchecked
--- * `textlist`: See `core.explode_textlist_event`
--- * `table`: See `core.explode_table_event`
--- * `scrollbar`: See `core.explode_scrollbar_event`
--- * Special case: `["quit"]="true"` is sent when the user actively
--- closed the form by mouse click, keypress or through a button_exit[]
--- element.
--- * Special case: `["key_enter"]="true"` is sent when the user pressed
--- the Enter key and the focus was either nowhere (causing the formspec
--- to be closed) or on a button. If the focus was on a text field,
--- additionally, the index `key_enter_field` contains the name of the
--- text field. See also: `field_close_on_enter`.
--- * Newest functions are called first
--- * If function returns `true`, remaining functions are not called
---@param func fun(player: mt.PlayerObjectRef, formname: string, fields: table<string, any>): boolean|nil
function core.register_on_player_receive_fields(func) end


---Map of registered on_player_receive_fields.
---@type (fun(player: mt.PlayerObjectRef, formname: string, fields: table<string, any>): boolean|nil)[]
core.registered_on_player_receive_fields = {}

--- * Called when `player` crafts something
--- * `itemstack` is the output
--- * `old_craft_grid` contains the recipe (Note: the one in the inventory is
--- cleared).
--- * `craft_inv` is the inventory with the crafting grid
--- * Return either an `ItemStack`, to replace the output, or `nil`, to not
--- modify it.
---@param func fun(itemstack: mt.ItemStack, player: mt.PlayerObjectRef, old_craft_grid: table, craft_inv: mt.InvRef): mt.ItemStack?
function core.register_on_craft(func) end


---Map of registered on_craft.
---@type (fun(itemstack: mt.Item, player: mt.PlayerObjectRef, old_craft_grid: table, craft_inv: mt.InvRef): mt.ItemStack?)[]
core.registered_on_crafts = {}

--- * The same as before, except that it is called before the player crafts, to
--- make craft prediction, and it should not change anything.
---@param func fun(itemstack: mt.Item, player: mt.PlayerObjectRef, old_craft_grid: table, craft_inv: mt.InvRef)
function core.register_craft_predict(func) end


---Map of registered craft_predicts.
---@type fun(itemstack: mt.Item, player: mt.PlayerObjectRef, old_craft_grid: table, craft_inv: mt.InvRef)[]
core.registered_craft_predicts = {}

---List of possible `action` (string) values and their `inventory_info` (table) contents:
---* `move`: `{from_list=string, to_list=string, from_index=number, to_index=number, count=number}`
---* `put`:  `{listname=string, index=number, stack=ItemStack}`
---* `take`: Same as `put`
---@alias mt.InvInfo {from_list: string, to_list: string, from_index: integer, to_index: integer, count: integer}|{listname: string, index: integer, stack: mt.Item}

--- * Determines how much of a stack may be taken, put or moved to a
--- player inventory.
--- * Function arguments: see `core.register_on_player_inventory_action`
--- * Return a numeric value to limit the amount of items to be taken, put or
--- moved. A value of `-1` for `take` will make the source stack infinite.
---@param func fun(player: mt.PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: mt.InvRef, inventory_info: mt.InvInfo): integer
function core.register_allow_player_inventory_action(func) end


---Map of registered allow_player_inventory_action.
---@type (fun(player: mt.PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: mt.InvRef, inventory_info: mt.InvInfo): integer)[]
core.registered_allow_player_inventory_action = {}

--- * Called after an item take, put or move event from/to/in a player inventory
--- * These inventory actions are recognized:
--- * move: Item was moved within the player inventory
--- * put: Item was put into player inventory from another inventory
--- * take: Item was taken from player inventory and put into another inventory
--- * `player` (type `ObjectRef`) is the player who modified the inventory
--- `inventory` (type `InvRef`).
--- * List of possible `action` (string) values and their
--- `inventory_info` (table) contents:
--- * `move`: `{from_list=string, to_list=string, from_index=number, to_index=number, count=number}`
--- * `put`:  `{listname=string, index=number, stack=ItemStack}`
--- * `take`: Same as `put`
--- * Does not accept or handle any return value.
---@param func fun(player: mt.PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: mt.InvRef, inventory_info: {from_list: string, to_list: string, from_index: integer, to_index: integer, count: integer}|{listname: string, index: integer, stack: mt.ItemStack})
function core.register_on_player_inventory_action(func) end


---Map of registered on_player_inventory_action.
---@type fun(player: mt.PlayerObjectRef, action: '"move"'|'"put"'|'"take"', inventory: mt.InvRef, inventory_info: mt.InvInfo)[]
core.registered_on_player_inventory_action = {}

--- * Called by `builtin` and mods when a player violates protection at a
--- position (eg, digs a node or punches a protected entity).
--- * The registered functions can be called using
--- `core.record_protection_violation`.
--- * The provided function should check that the position is protected by the
--- mod calling this function before it prints a message, if it does, to
--- allow for multiple protection mods.
---@param func fun(pos: mt.Vector, name: string)
function core.register_on_protection_violation(func) end


---Map of registered on_protection_violation.
---@type fun(pos: mt.Vector, name: string)[]
core.registered_on_protection_violation = {}

--- * Called when an item is eaten, by `core.item_eat`
--- * Return `itemstack` to cancel the default item eat response (i.e.: hp increase).
---@param func fun(hp_change: integer, replace_with_item, itemstack: mt.ItemStack, user: mt.ObjectRef, pointed_thing: mt.PointedThing): mt.ItemStack?
function core.register_on_item_eat(func) end


---Map of registered on_item_eat.
---@type (fun(hp_change: integer, replace_with_item, itemstack: mt.ItemStack, user: mt.ObjectRef, pointed_thing: mt.PointedThing): mt.ItemStack?)[]
core.registered_on_item_eat = {}

--- * Called by `core.item_pickup` before an item is picked up.
--- * Function is added to `core.registered_on_item_pickups`.
--- * Oldest functions are called first.
--- * Parameters are the same as in the `on_pickup` callback.
--- * Return an itemstack to cancel the default item pick-up response (i.e.: adding
--- the item into inventory).
---@param func fun(itemstack:mt.ItemStack, picker:mt.ObjectRef, pointed_thing:mt.PointedThing, time_from_last_punch:number, ...:any): mt.ItemStack?
function core.register_on_item_pickup(func) end


---Map of registered on_item_pickup
---@type (fun(itemstack:mt.ItemStack, picker:mt.ObjectRef, pointed_thing:mt.PointedThing, time_from_last_punch:number, ...:any): mt.ItemStack?)[]
core.registered_on_item_pickup = {}

--- Called when the local player uses an item.
---
--- * Newest functions are called first.
--- * If any function returns true, the item use is not sent to server.
---@param func fun(item:mt.ItemStack, pointed_thing:mt.PointedThing): boolean?
function core.register_on_item_use(func) end


---@type (fun(item:mt.ItemStack, pointed_thing:mt.PointedThing): boolean?)[]
core.registered_on_item_use = {}

--- * Called when `granter` grants the priv `priv` to `name`.
--- * Note that the callback will be called twice if it's done by a player,
--- once with granter being the player name, and again with granter being nil.
---@param func fun(name: string, granter?: string, priv: string)
function core.register_on_priv_grant(func) end


---Map of registered on_priv_grant.
---@type fun(name: string, granter?: string, priv: string)[]
core.registered_on_priv_grant = {}

--- * Called when `revoker` revokes the priv `priv` from `name`.
--- * Note that the callback will be called twice if it's done by a player,
--- once with revoker being the player name, and again with revoker being nil.
---@param func fun(name: string, revoker?: string, priv: string)
function core.register_on_priv_revoke(func) end


---Map of registered on_priv_revoke.
---@type fun(name: string, revoker?: string, priv: string)[]
core.registered_on_priv_revoke = {}

--- * Called when `name` user connects with `ip`.
--- * Return `true` to by pass the player limit
---@param func fun(name: string, ip: string): boolean|nil
function core.register_can_bypass_userlimit(func) end


---Map of registered can_bypass_userlimit.
---@type fun(name: string, ip: string)[]
core.registered_can_bypass_userlimit = {}

--- * Called when an incoming mod channel message is received
--- * You should have joined some channels to receive events.
--- * If message comes from a server mod, `sender` field is an empty string.
---@param func fun(channel_name: string, sender: string, message: string)
function core.register_on_modchannel_message(func) end


--- Called when a valid incoming mod channel signal is received.
---
--- * Signal id permit to react to server mod channel events.
--- * Possible values are:
---   0: join_ok
---   1: join_failed
---   2: leave_ok
---   3: leave_failed
---   4: event_on_not_joined_channel
---   5: state_changed
---@param func fun(channel_name: string, signal:unknown)
function core.register_on_modchannel_signal(func) end


--- Called when the local player open inventory.
---
--- * Newest functions are called first.
--- * If any function returns true, inventory doesn't open.
---@param func fun(inventory:mt.InvRef):boolean?
function core.register_on_inventory_open(func) end


---Map of registered on_modchannel_message.
---@type fun(channel_name: string, sender: string, message: string)[]
core.registered_on_modchannel_message = {}

--- * Called after liquid nodes (`liquidtype ~= "none"`) are modified by the
--- engine's liquid transformation process.
--- * `pos_list` is an array of all modified positions.
--- * `node_list` is an array of the old node that was previously at the position
--- with the corresponding index in pos_list.
---@param func fun(pos_list: mt.Vector[], node_list: mt.Node[])
function core.register_on_liquid_transformed(func) end


---Map of registered on_liquid_transformed.
---@type fun(pos_list: mt.Vector[], node_list: mt.Node[])[]
core.registered_on_liquid_transformed = {}

---@param func function
function core.register_on_mapgen_init(func) end


--- * Register a path to a Lua file to be imported when a mapgen environment
--- is initialized. Run in order of registration.
---@param path string
function core.register_mapgen_script(path) end


--- * Called soon after any nodes or node metadata have been modified. No
--- modifications will be missed, but there may be false positives.
--- * Will never be called more than once per server step.
--- * `modified_blocks` is the set of modified mapblock position hashes. These
--- are in the same format as those produced by `core.hash_node_position`,
--- and can be converted to positions with `core.get_position_from_hash`.
--- The set is a table where the keys are hashes and the values are `true`.
--- * `modified_block_count` is the number of entries in the set.
--- * Note: callbacks must be registered at mod load time.
---@param modified_blocks integer
---@param modified_block_count integer
function core.register_on_mapblocks_changed(

  modified_blocks,
  modified_block_count
)
end