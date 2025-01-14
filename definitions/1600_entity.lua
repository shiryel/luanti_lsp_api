---@meta

---Collision info passed to `on_step` (`moveresult` argument).
---@class mt.CollisionInfo
---@field touching_ground boolean
---@field collides boolean
---@field standing_on_object boolean
---@field collisions mt.Collisions

--- `mt.Collisions` does not contain data of unloaded mapblock collisions
--- or when the velocity changes are negligibly small.
---@class mt.Collisions
---@field type "node"|"object"
---@field axis "x"|"y"|"z"
---@field node_pos mt.Vector If type is "node".
---@field object mt.ObjectRef If type is "object".
---@field old_velocity mt.Vector
---@field new_velocity mt.Vector
