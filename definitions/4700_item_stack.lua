---@meta

--- Items are things that can be held by players, dropped in the map and
--- stored in inventories.
--- Items come in the form of item stacks, which are collections of equal
--- items that occupy a single inventory slot.
---
--- Item types
--- ----------
--- 
--- There are three kinds of items: nodes, tools and craftitems.
--- 
--- * Node: Placeable item form of a node in the world's voxel grid
--- * Tool: Has a changeable wear property but cannot be stacked
--- * Craftitem: Has no special properties
--- 
--- Every registered node (the voxel in the world) has a corresponding
--- item form (the thing in your inventory) that comes along with it.
--- This item form can be placed which will create a node in the
--- world (by default).
--- Both the 'actual' node and its item form share the same identifier.
--- For all practical purposes, you can treat the node and its item form
--- interchangeably. We usually just say 'node' to the item form of
--- the node as well.
--- 
--- Note the definition of tools is purely technical. The only really
--- unique thing about tools is their wear, and that's basically it.
--- Beyond that, you can't make any gameplay-relevant assumptions
--- about tools or non-tools. It is perfectly valid to register something
--- that acts as tool in a gameplay sense as a craftitem, and vice-versa.
--- 
--- Craftitems can be used for items that neither need to be a node
--- nor a tool.
---
--- Amount and wear
--- ---------------
--- 
--- All item stacks have an amount between 0 and 65535. It is 1 by
--- default. Tool item stacks cannot have an amount greater than 1.
--- 
--- Tools use a wear (damage) value ranging from 0 to 65535. The
--- value 0 is the default and is used for unworn tools. The values
--- 1 to 65535 are used for worn tools, where a higher value stands for
--- a higher wear. Non-tools technically also have a wear property,
--- but it is always 0. There is also a special 'toolrepair' crafting
--- recipe that is only available to tools.
--- Item formats
--- ------------
--- 
--- Items and item stacks can exist in three formats: Serializes (`ItemString`), 
--- table format (`ItemTable`) and `ItemStack`.
--- 
--- When an item must be passed to a function, it can usually be in any of
--- these formats.
---@alias mt.Item mt.ItemStack|mt.ItemString|mt.ItemTable|nil


--- Serialized Item
---
--- This is called "stackstring" or "itemstring". It is a simple string with
--- 1-4 components:
--- 
--- 1. Full item identifier ("item name")
--- 2. Optional amount
--- 3. Optional wear value
--- 4. Optional item metadata
--- 
--- Syntax:
--- 
---     <identifier> [<amount>[ <wear>[ <metadata>]]]
--- 
--- Examples:
--- 
--- * `"default:apple"`: 1 apple
--- * `"default:dirt 5"`: 5 dirt
--- * `"default:pick_stone"`: a new stone pickaxe
--- * `"default:pick_wood 1 21323"`: a wooden pickaxe, ca. 1/3 worn out
--- * `[[default:pick_wood 1 21323 "\u0001description\u0002My worn out pick\u0003"]]`:
---   * a wooden pickaxe from the `default` mod,
---   * amount must be 1 (pickaxe is a tool), ca. 1/3 worn out (it's a tool),
---   * with the `description` field set to `"My worn out pick"` in its metadata
--- * `[[default:dirt 5 0 "\u0001description\u0002Special dirt\u0003"]]`:
---   * analogous to the above example
---   * note how the wear is set to `0` as dirt is not a tool
--- 
--- You should ideally use the `ItemStack` format to build complex item strings
--- (especially if they use item metadata)
--- without relying on the serialization format. Example:
--- 
---     local stack = ItemStack("default:pick_wood")
---     stack:set_wear(21323)
---     stack:get_meta():set_string("description", "My worn out pick")
---     local itemstring = stack:to_string()
--- 
--- Additionally the methods `core.itemstring_with_palette(item, palette_index)`
--- and `core.itemstring_with_color(item, colorstring)` may be used to create
--- item strings encoding color information in their metadata.
---@alias mt.ItemString string


--- Item Table format
---
--- Examples:
--- 
--- 5 dirt nodes:
--- 
--- ```lua
--- {name="default:dirt", count=5, wear=0, metadata=""}
--- ```
--- 
--- A wooden pick about 1/3 worn out:
--- 
--- ```lua
--- {name="default:pick_wood", count=1, wear=21323, metadata=""}
--- ```
--- 
--- An apple:
--- 
--- ```lua
--- {name="default:apple", count=1, wear=0, metadata=""}
---@class mt.ItemTable
---@field name string
---@field count number
---@field wear number
---@field metadata string


--- An `ItemStack` is a stack of items.
--- 
--- A native C++ format with many helper methods. Useful for converting
--- between formats. See the [Class reference] section for details.
---
--- It can be created via `ItemStack(x)`, where x is an ItemStack,
--- an itemstring, a table or nil.
--- 
---  **Operators**
--- 
--- * `stack1 == stack2`:
--- * Returns whether `stack1` and `stack2` are identical.
--- * Note: `stack1:to_string() == stack2:to_string()` is not reliable,
---   as stack metadata can be serialized in arbitrary order.
--- * Note: if `stack2` is an itemstring or table representation of an
---   ItemStack, this will always return false, even if it is "equivalent".
---@class mt.ItemStack
local ItemStackObject = {}

---`ItemStack` constructor.
---@param x mt.Item
---@return mt.ItemStack
function ItemStack(x) end

---Returns `true` if stack is empty.
---@return boolean
function ItemStackObject:is_empty() end

---@return string name ie: "default:stone"
function ItemStackObject:get_name() end

---Returns a boolean indicating whether the item was cleared.
---@param item_name string
---@return boolean cleared
function ItemStackObject:set_name(item_name) end

---Returns number of items on the stack.
---@return number
function ItemStackObject:get_count() end

---Returns a boolean indicating whether the item was cleared.
---@param count integer Unsigned 16 bit.
---@return boolean cleared
function ItemStackObject:set_count(count) end

---Returns tool wear (`0`-`65535`), `0` for non-tools.
---@return number
function ItemStackObject:get_wear() end

---Returns boolean indicating whether item was cleared.
---@param wear integer Unsigned 16 bit.
---@return boolean cleared
function ItemStackObject:set_wear(wear) end

---**DEPRECATED** Returns metadata (a string attached to an item stack).
---If you need to access this to maintain backwards compatibility,
---use `stack:get_meta():get_string("")` instead.
---@return string
---@deprecated
function ItemStackObject:get_metadata() end

---**DEPRECATED**
---@param metadata string
---@return true
---@deprecated
---If you need to set this to maintain backwards compatibility,
---use `stack:get_meta():set_string("", metadata)` instead.
function ItemStackObject:set_metadata(metadata) end

---* Returns the description shown in inventory list tooltips.
---* The engine uses this when showing item descriptions in tooltips.
---* Fields for finding the description, in order:
---  * `description` in item metadata (See [Item Metadata]);
---  * `description` in item definition;
---  * item name.
---@return string
function ItemStackObject:get_description() end

---* Returns the short description or nil.
---* Unlike the description, this does not include new lines.
---* Fields for finding the short description, in order:
---  * `short_description` in item metadata (See [Item Metadata]);
---  * `short_description` in item definition;
---  * first line of the description (From item meta or def, see `get_description()`);
---  * Returns nil if none of the above are set.
---@return string|nil
function ItemStackObject:get_short_description() end

---Removes all items from the stack, making it empty.
function ItemStackObject:clear() end

---Replace the contents of this stack.
---@param item string|table
function ItemStackObject:replace(item) end

---Returns the stack in itemstring form.
---@return string
function ItemStackObject:to_string() end

---Returns the stack in Lua table form.
---@return table
function ItemStackObject:to_table() end

---Returns the maximum size of the stack (depends on the item).
---@return number
function ItemStackObject:get_stack_max() end

---Returns `get_stack_max() - get_count()`.
---@return number
function ItemStackObject:get_free_space() end

---Returns `true` if the item name refers to a defined item type.
---@return boolean
function ItemStackObject:is_known() end

---Returns the item definition table.
---@return mt.ItemDef
function ItemStackObject:get_definition() end

---Returns the digging properties of the item, or those of the hand if none are
---defined for this item type.
---@return mt.ToolCaps
function ItemStackObject:get_tool_capabilities() end

---Increases wear by `amount` if the item is a tool, otherwise does nothing
---@param amount integer 0..65536
function ItemStackObject:add_wear(amount) end

---* Increases wear in such a way that, if only this function is called,
---  the item breaks after `max_uses` times.
---* Does nothing if item is not a tool or if `max_uses` is 0.
---@param max_uses integer 0..65536
function ItemStackObject:add_wear_by_uses(max_uses) end

---Returns the wear bar parameters of the item,
---or nil if none are defined for this item type or in the stack's meta
function get_wear_bar_params() end

---* Returns leftover `ItemStack`.
---* Put some item or stack onto this stack.
---@param item mt.Item
---@return mt.ItemStack leftover
function ItemStackObject:add_item(item) end

---Returns `true` if item or stack can be fully added to this one.
---@param item mt.Item
---@return boolean
function ItemStackObject:item_fits(item) end

---* Returns taken `ItemStack`.
---* Take (and remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return mt.ItemStack taken
function ItemStackObject:take_item(n) end

---* Returns taken `ItemStack`.
---* Copy (don't remove) up to `n` items from this stack.
---@param n number|nil Default: `1`.
---@return mt.ItemStack taken
function ItemStackObject:peek_item(n) end

---* Returns `true` if this stack is identical to `other`.
---* Note: `stack1:to_string() == stack2:to_string()` is not reliable,
---  as stack metadata can be serialized in arbitrary order.
---* Note: if `other` is an itemstring or table representation of an
---  ItemStack, this will always return false, even if it is
---  "equivalent".
---@param other mt.Item
function ItemStackObject:equals(other) end

---Reference extra data and functionality stored in a stack.
---@return mt.ItemStackMetaRef
function ItemStackObject:get_meta() end
