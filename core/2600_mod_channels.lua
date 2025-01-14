---@meta

--- L 6641
------------------
--- Mod channels --
------------------

--- * Server joins channel `channel_name`, and creates it if necessary. You
--- should listen for incoming messages with
--- `core.register_on_modchannel_message`
---@param channel_name string
---@return mt.ModChannel
function core.mod_channel_join(channel_name) end