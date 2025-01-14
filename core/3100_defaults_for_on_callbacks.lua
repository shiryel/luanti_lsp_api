---@meta

--- L 6849
---------------------------------------------------------------------
---Defaults for the `on_place`, `on_drop`, `on_punch` and `on_dig` --
---------------------------------------------------------------------

--- * Place item as a node
--- * `param2` overrides `facedir` and wallmounted `param2`
--- * `prevent_after_place`: if set to `true`, `after_place_node` is not called
--- for the newly placed node to prevent a callback and placement loop
--- * returns `itemstack, position`
--- * `position`: the location the node was placed to. `nil` if nothing was placed.
---@param itemstack mt.Item
---@param placer mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@param param2 mt.NodeParam|nil Overrides `facedir` and wallmounted `param2`.
---@param prevent_after_place boolean|nil
---@return mt.ItemStack, mt.Vector|nil position
function core.item_place_node(itemstack, placer, pointed_thing, param2, prevent_after_place) end


--- * Place item as-is
--- * returns the leftover itemstack
--- * **Note**: This function is deprecated and will never be called.
---@param itemstack mt.Item
---@param placer mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@return mt.ItemStack leftover
---@deprecated
function core.item_place_object(itemstack, placer, pointed_thing) end


--- * Wrapper that calls `core.item_place_node` if appropriate
--- * Calls `on_rightclick` of `pointed_thing.under` if defined instead
--- * **Note**: is not called when wielded item overrides `on_place`
--- * `param2` overrides facedir and wallmounted `param2`
--- * returns `itemstack, position`
--- * `position`: the location the node was placed to. `nil` if nothing was placed.
---@param itemstack mt.Item
---@param placer mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@param param2 mt.NodeParam|nil Overrides facedir and wallmounted `param2`.
---@return mt.ItemStack, mt.Vector|nil position
function core.item_place(itemstack, placer, pointed_thing, param2) end


--- * Runs callbacks registered by `core.register_on_item_pickup` and adds
--- the item to the picker's `"main"` inventory list.
--- * Parameters are the same as in `on_pickup`.
--- * Returns the leftover itemstack.
---@param itemstack mt.ItemStack
---@param picker mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@param time_from_last_punch number
---@param ... any
---@return mt.ItemStack leftover
function core.item_pickup(itemstack, picker, pointed_thing, time_from_last_punch, ...) end


--- * Drop the item
--- * returns the leftover itemstack
---@param itemstack mt.Item
---@param dropper mt.ObjectRef|nil
---@param pos mt.Vector
---@return mt.ItemStack leftover
function core.item_drop(itemstack, dropper, pos) end


--- * Returns `function(itemstack, user, pointed_thing)` as a
--- function wrapper for `core.do_item_eat`.
--- * `replace_with_item` is the itemstring which is added to the inventory.
--- If the player is eating a stack and `replace_with_item` doesn't fit onto
--- the eaten stack, then the remainings go to a different spot, or are dropped.
---@param hp_change number
---@param replace_with_item mt.Item|nil
---@return fun(itemstack:mt.Item, user:mt.ObjectRef, pointed_thing:mt.PointedThing)
function core.item_eat(hp_change, replace_with_item) end


--- * Calls functions registered by `core.register_on_punchnode()`
---@param pos mt.Vector
---@param node mt.Node
---@param puncher mt.ObjectRef
---@param pointed_thing mt.PointedThing
function core.node_punch(pos, node, puncher, pointed_thing) end


--- * Checks if node can be dug, puts item into inventory, removes node
--- * Calls functions registered by `core.registered_on_dignodes()`
---@param pos mt.Vector
---@param node mt.Node
---@param digger mt.ObjectRef
function core.node_dig(pos, node, digger) end