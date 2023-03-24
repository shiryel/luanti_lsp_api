---@meta
---pointed_thing
----------------

---@class mt.PointedThing
---@field type "nothing"|"node"|"object"
---@field under mt.Vector|nil Refers to the node position behind the pointed face.
---@field above mt.Vector|nil Refers to the node position in front of the pointed face.
---@field ref mt.ObjectRef|nil
---The absolute world coordinates of the point on the selection box which is
---pointed at. May be in the selection box if the pointer is in the box too.
---@field intersection_point mt.Vector|nil
---The ID of the pointed selection box (counting starts from 1).
---@field box_id number|nil
---Unit vector, points outwards of the
---selected selection box. This specifies which face is pointed at.
---Is a null vector `vector.zero()` when the pointer is inside the selection box.
---For entities with rotated selection boxes, this will be rotated properly
---by the entity's rotation - it will always be in absolute world space.
---@field intersection_normal mt.Vector|nil