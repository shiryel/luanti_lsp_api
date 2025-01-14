---@meta

---
--- Node metadata contains two things:
--- 
--- - A key-value store
--- - An inventory
--- 
--- Some of the values in the key-value store are handled specially:
--- 
--- - `formspec`: Defines an inventory menu that is opened with the 'place/use' key.
---   Only works if no `on_rightclick` was defined for the node.
--- - `infotext`: Text shown on the screen when the node is pointed at. Line-breaks
---   will be applied automatically. If the infotext is very long, it will be
---   truncated.
--- 
--- Example:
--- 
--- ```lua
--- local meta = core.get_meta(pos)
--- meta:set_string("formspec",
---   "size[8,9]"..
---   "list[context;main;0,0;8,4;]"..
---   "list[current_player;main;0,5;8,4;]")
--- meta:set_string("infotext", "Chest");
--- local inv = meta:get_inventory()
--- inv:set_size("main", 8*4)
--- print(dump(meta:to_table()))
--- meta:from_table({
---   inventory = {
---     main = {[1] = "default:dirt", [2] = "", [3] = "", [4] = "",
---       [5] = "", [6] = "", [7] = "", [8] = "", [9] = "",
---       [10] = "", [11] = "", [12] = "", [13] = "",
---       [14] = "default:cobble", [15] = "", [16] = "", [17] = "",
---       [18] = "", [19] = "", [20] = "default:cobble", [21] = "",
---       [22] = "", [23] = "", [24] = "", [25] = "", [26] = "",
---       [27] = "", [28] = "", [29] = "", [30] = "", [31] = "",
---       [32] = ""}
---   },
---   fields = {
---     formspec = "size[8,9]list[context;main;0,0;8,4;]list[current_player;main;0,5;8,4;]",
---     infotext = "Chest"
---   }
--- })
--- ```
---
---@class mt.NodeMetaRef: mt.MetaDataRef
local NodeMetaRef = {}

--- * Returns `nil` or a table with keys:
--- * `fields`: key-value storage
--- * `inventory`: `{list1 = {}, ...}}`
---@return {fields: {[string]: any}, inventory: {[string]: {[integer]: string}}}?
function NodeMetaRef:to_table() end

---Any non-table value will clear the metadata.
---
--- * Returns `true` on success.
--- * `fields`: key-value storage
--- * `inventory`: `{list1 = {}, ...}}`
---@param table {fields: {[string]: any}, inventory: {[string]: {[integer]: string}}}?
---@return boolean
function NodeMetaRef:from_table(table) end

---@return mt.InvRef
function NodeMetaRef:get_inventory() end

---Mark specific vars as private.
---
---This will prevent them from being sent to the client.
---
---Note that the "private" status will only be remembered if an associated key-value pair exists, meaning it's best to call this when initializing all other meta (e.g. `on_construct`).
---@param name string|string[]
function NodeMetaRef:mark_as_private(name) end
