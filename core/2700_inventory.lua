---@meta
---Inventory
------------
---@diagnostic disable: missing-return

---@class mt.InvLocation
---@field type "player"|"node"|"detached"|"undefined"
---@field name string|nil
---@field pos mt.Vector|nil

---@param location mt.InvLocation
---@return mt.InvRef
function core.get_inventory(location) end


--- Returns
--- an `InvRef`.
--- * `callbacks`: See [Detached inventory callbacks]
--- * `player_name`: Make detached inventory available to one player
--- exclusively, by default they will be sent to every player (even if not
--- used).
--- Note that this parameter is mostly just a workaround and will be removed
--- in future releases.
--- * Creates a detached inventory. If it already exists, it is cleared.
---@param name string
---@param callbacks mt.DetachedInvDef
---@param player_name string|nil
---@return mt.InvRef
function core.create_detached_inventory(name, callbacks, player_name) end


--- * Returns a `boolean` indicating whether the removal succeeded.
---@param name string
---@return boolean success
function core.remove_detached_inventory(name) end


--- Returns leftover ItemStack or nil to indicate no inventory change
--- * See `core.item_eat` and `core.register_on_item_eat`
---@param hp_change integer
---@param replace_with_item mt.Item
---@param itemstack mt.Item
---@param user mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@return mt.ItemStack leftover
function core.do_item_eat(hp_change, replace_with_item, itemstack, user, pointed_thing) end