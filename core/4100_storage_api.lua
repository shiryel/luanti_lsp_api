---@meta

---Storage API
--------------

--- * returns reference to mod private `StorageRef`
--- * must be called during mod load time
---@return mt.StorageRef
function core.get_mod_storage() end