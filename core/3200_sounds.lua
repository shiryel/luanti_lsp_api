---@meta
---Sounds
---------

---@alias mt.SoundHandle unknown

--- Returns a handle
--- * `spec` is a `SimpleSoundSpec`
--- * `parameters` is a sound parameter table
--- * `ephemeral` is a boolean (default: false)
--- Ephemeral sounds will not return a handle and can't be stopped or faded.
--- It is recommend to use this for short sounds that happen in response to
--- player actions (e.g. door closing).
---@param spec mt.SimpleSoundSpec
---@param parameters mt.SoundParameters A sound parameter table.
---@param ephemeral boolean|nil Ephemeral sounds will not return a handle and can't be stopped or faded. It is recommend to use this for short sounds that happen in response to player actions (e.g. door closing). (default: false)
---@return mt.SoundHandle handle
function core.sound_play(spec, parameters, ephemeral) end


--- * `handle` is a handle returned by `core.sound_play`
---@param handle mt.SoundHandle
function core.sound_stop(handle) end


--- * `handle` is a handle returned by `core.sound_play`
--- * `step` determines how fast a sound will fade.
--- The gain will change by this much per second,
--- until it reaches the target gain.
--- Note: Older versions used a signed step. This is deprecated, but old
--- code will still work. (the client uses abs(step) to correct it)
--- * `gain` the target gain for the fade.
--- Fading to zero will delete the sound.
---@param handle mt.SoundHandle
---@param step number
---@param gain number
function core.sound_fade(handle, step, gain) end