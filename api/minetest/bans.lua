---@meta
---Bans
-------

---Returns a list of all bans formatted as string.
---@return string
function core.get_ban_list() end

---Returns list of bans matching IP address or name formatted as string.
---@param ip_or_name string
---@return string
function core.get_ban_description(ip_or_name) end

---Ban the IP of a currently connected player.
---
---Returns boolean indicating success.
---@param name string
---@return boolean
function core.ban_player(name) end

---Remove ban record matching IP address or name.
---@param ip_or_name string
function core.unban_player_or_ip(ip_or_name) end

---Disconnect a player with an optional reason.
---
---Returns boolean indicating success (false if player nonexistant).
---@param name string
---@param reason string|nil
---@return boolean
function core.kick_player(name, reason) end

---Disconnect a player with an optional reason,
---this will not prefix with `Kicked:` like `kick_player`.
---
---If no reason is given, it will default to `Disconnected`.
---
---Returns boolean indicating success (false if player nonexistant).
---@param name string
---@param reason? string
---@return boolean
function core.disconnect_player(name, reason) end
