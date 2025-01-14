---@meta

---@class mt.StorageRef: mt.MetaDataRef
local StorageRef = {}

---Returns reference to mod private `StorageRef`.
---
---Must be called during mod load time.
---@return mt.StorageRef
function core.get_mod_storage() end
