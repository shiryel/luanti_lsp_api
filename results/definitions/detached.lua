---@meta
---Detached inventory callbacks
-------------------------------

-- Used by `core.create_detached_inventory`.
---@class mt.DetachedInvDef
local did = {}

-- Called when a player wants to move items inside the inventory.
--
-- * Moving items in the inventory.
-- * The `allow_*` callbacks return how many items can be moved.
-- * This callback triggered `before` the action.
---@param inv mt.InvRef
---@param from_list string
---@param from_index number
---@param to_list string
---@param to_index number
---@param count number
---@param player mt.PlayerObjectRef
---@return number items_allowed_count
function did.allow_move(inv, from_list, from_index, to_list, to_index, count, player) end


-- Called after the actual action has happened, according to what was allowed.
--
-- * Moving items in the inventory.
-- * The `on_*` callbacks are called after the items have been placed in the inventories.
-- * This callback triggered `after` the action.
---@param inv mt.InvRef
---@param from_list string
---@param from_index number
---@param to_list string
---@param to_index number
---@param count number
---@param player mt.PlayerObjectRef
function did.on_move(inv, from_list, from_index, to_list, to_index, count, player) end


-- Called when a player wants to put something into the inventory.
--
-- * Putting items to the inventory.
-- * The `allow_*` callbacks return how many items can be moved.
-- * This callback triggered `before` the action.
-- If `-1`: Allow and don't modify item count in inventory.
---@param inv mt.InvRef
---@param listname string
---@param index integer
---@param stack mt.Item
---@param player mt.PlayerObjectRef
---@return number items_allowed_count
function did.allow_put(inv, listname, index, stack, player) end


-- Called after the actual action has happened, according to what was allowed.
--
-- * Putting items to the inventory.
-- * The `on_*` callbacks are called after the items have been placed in the inventories.
-- * This callback triggered `after` the action.
---@param inv mt.InvRef
---@param listname string
---@param index integer
---@param stack mt.Item
---@param player mt.PlayerObjectRef
function did.on_put(inv, listname, index, stack, player) end


-- Called when a player wants to take something out of the inventory.
--
-- * Taking items from the inventory.
-- * The `allow_*` callbacks return how many items can be moved.
-- * This callback triggered `before` the action.
-- If `-1`: Allow and don't modify item count in inventory.
---@param inv mt.InvRef
---@param listname string
---@param index integer
---@param stack mt.Item
---@param player mt.PlayerObjectRef
---@return number items_allowed_count
function did.allow_take(inv, listname, index, stack, player) end


-- Called after the actual action has happened, according to what was allowed.
--
-- * Taking items from the inventory.
-- * The `on_*` callbacks are called after the items have been placed in the inventories.
-- * This callback triggered `after` the action.
---@param inv mt.InvRef
---@param listname string
---@param index integer
---@param stack mt.Item
---@param player mt.PlayerObjectRef
function did.on_take(inv, listname, index, stack, player) end