---@meta
---Logging functions
--------------------

---@alias mt.LogLevel
---|"none"
---|"error"
---|"warning"
---|"action"
---|"info"
---|"verbose"

--- * `level` is one of `"none"`, `"error"`, `"warning"`, `"action"`,
--- `"info"`, or `"verbose"`.  Default is `"none"`.
---@param level mt.LogLevel
---@param text string
function core.log(level, text) end


---Log level `"none"`.
---@param text string
function core.log(text) end


--- * Equivalent to `core.log(table.concat({...}, "\t"))`
---@see core.log
function core.debug(...) end