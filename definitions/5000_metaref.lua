---@meta

---Base class used by `StorageRef`, `NodeMetaRef`, `ItemStackMetaRef` and `PlayerMetaRef`.
---@class mt.MetaDataRef
local MetaDataRef = {}

---Returns `true` if key present, otherwise `false`.
---
---Returns `nil` when the MetaData is inexistent.
---@param key string
---@return boolean?
function MetaDataRef:contains(key) end

---Returns `nil` if key not present, else the stored string.
---@param key string
---@return string?
function MetaDataRef:get(key) end

---Value of `""` will delete the key.
---@param key string
---@param value string|nil
function MetaDataRef:set_string(key, value) end

---Returns `""` if key not present.
---@param key string
---@return string
function MetaDataRef:get_string(key) end

--- The range for the value is system-dependent (usually 32 bits).
--- The value will be converted into a string when stored
---@param key string
---@param value integer
function MetaDataRef:set_int(key, value) end

---Returns `0` if key not present.
---@param key string
---@return integer
function MetaDataRef:get_int(key) end

--- The range for the value is system-dependent (usually 32 bits).
--- The value will be converted into a string when stored.
---@param key string
---@param value number
function MetaDataRef:set_float(key, value) end

---Returns `0` if key not present.
---@param key string
---@return number
function MetaDataRef:get_float(key) end

---Returns a metadata table or `nil` on failure.
---@return {fields: {[string]: any}}?
function MetaDataRef:to_table() end

---* Imports metadata from a metadata table
---* If `data` is a metadata table (see below), the metadata it represents
--- will replace all metadata of this MetaDataRef object
---* Any non-table value for `data` will clear all metadata
---* Item table values the `inventory` field may also be itemstrings
---* Returns `true` on success
---@param table {fields: {[string]: any}}?
---@return boolean
function MetaDataRef:from_table(table) end

---Returns `true` if this metadata has the same key-value pairs as `other`.
---@param other mt.MetaDataRef
---@return boolean
function MetaDataRef:equals(other) end

