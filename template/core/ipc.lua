---@meta
---IPC
--- The engine provides a generalized mechanism to enable sharing data between the
--- different Lua environments (main, mapgen and async).
--- It is essentially a shared in-memory key-value store.
------------

--- Read a value from the shared data area.
--- `key`: string, should use the `"modname:thing"` convention to avoid conflicts.
--- returns an arbitrary Lua value, or `nil` if this key does not exist
---@param key string
function core.ipc_get(key) end

--- Write a value to the shared data area.
--- `key`: as above
--- `value`: an arbitrary Lua value, cannot be or contain userdata.
---@param key string
---@param value any
function core.ipc_set(key, value) end

--- Write a value to the shared data area, but only if the previous value
--- equals what was given.
--- This operation is called Compare-and-Swap and can be used to implement
--- synchronization between threads.
---@param key string
---@param old_value any
---@param new_value any
---@return boolean
function core.ipc_cas(key, old_value, new_value) end

--- Do a blocking wait until a value (other than `nil`) is present at the key.
---
--- **IMPORTANT**: You usually don't need this function. Use this as a last resort
--- if nothing else can satisfy your use case! None of the Lua environments the
--- engine has are safe to block for extended periods, especially on the main
--- thread any delays directly translate to lag felt by players.
---@param key string
---@param timeout number
---@return boolean
function core.ipc_poll(key, timeout) end
