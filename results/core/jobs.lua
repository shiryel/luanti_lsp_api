---@meta
---Timing
---------

-- Returned by `core.after`.
---@class mt.Job
local job = {}

-- Cancels the job function from being called.
function job:cancel() end


--- Returns job table to use as below.
--- * Call the function `func` after `time` seconds, may be fractional
--- * Optional: Variable number of arguments that are passed to `func`
--- * Jobs set for earlier times are executed earlier. If multiple jobs expire
--- at exactly the same time, then they are executed in registration order.
--- * `time` is a lower bound. The job is executed in the first server-step that
--- started at least `time` seconds after the last time a server-step started,
--- measured with globalstep dtime.
--- * If `time` is `0`, the job is executed in the next step.
---@param time number
---@param func function
---@param ... unknown Arguments that will be passed to `func`.
---@return mt.Job
function core.after(time, func, ...) end


---Async environment
--------------------

--- * Queue the function `func` to be ran in an async environment.
--- Note that there are multiple persistent workers and any of them may
--- end up running a given job. The engine will scale the amount of
--- worker threads automatically.
--- * When `func` returns the callback is called (in the normal environment)
--- with all of the return values as arguments.
--- * Optional: Variable number of arguments that are passed to `func`
---@param func function
---@param callback fun(...: any): any
---@param ... unknown Variable number of arguments that are passed to `func`.
function core.handle_async(func, callback, ...) end


--- * Register a path to a Lua file to be imported when an async environment
--- is initialized. You can use this to preload code which you can then call
--- later using `core.handle_async()`.
---@param path string
function core.register_async_dofile(path) end