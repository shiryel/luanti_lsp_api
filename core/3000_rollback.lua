---@meta
---Rollback
-----------

--- Used in `core.rollback_get_node_actions`.
---@class mt.RollbackAction
---@field actor string `"player:<name>"`, also `"liquid"`.
---@field pos mt.Vector
---@field time number
---@field oldnode mt.Node
---@field newnode mt.Node

--- Returns `{{actor, pos, time, oldnode, newnode}, ...}`
--- * Find who has done something to a node, or near a node
--- * `actor`: `"player:<name>"`, also `"liquid"`.
---@param pos mt.Vector
---@param range integer
---@param seconds number
---@param limit integer Maximum number of actions to search.
---@return mt.RollbackAction[]
function core.rollback_get_node_actions(pos, range, seconds, limit) end


--- Returns
--- `boolean, log_messages`.
--- * Revert latest actions of someone
--- * `actor`: `"player:<name>"`, also `"liquid"`.
---@param actor string `"player:<name>"`, also `"liquid"`.
---@param seconds number
---@return boolean, string log_messages
function core.rollback_revert_actions_by(actor, seconds) end