---@meta
---Sounds
---------

---@alias mt.SoundHandle unknown

---@param spec mt.SimpleSoundSpec
---@param parameters mt.SoundParameters A sound parameter table.
---@param ephemeral boolean|nil Ephemeral sounds will not return a handle and can't be stopped or faded. It is recommend to use this for short sounds that happen in response to player actions (e.g. door closing). (default: false)
---@return mt.SoundHandle handle
function core.sound_play(spec, parameters, ephemeral) end

---@param handle mt.SoundHandle
function core.sound_stop(handle) end

---@param handle mt.SoundHandle
---@param step number
---@param gain number
function core.sound_fade(handle, step, gain) end
