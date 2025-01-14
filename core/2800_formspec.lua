---@meta
---Formspec
-----------

--- * `playername`: name of player to show formspec
--- * `formname`: name passed to `on_player_receive_fields` callbacks.
--- It should follow the `"modname:<whatever>"` naming convention.
--- * `formname` must not be empty, unless you want to reshow
--- the inventory formspec without updating it for future opens.
--- * `formspec`: formspec to display
---@param playername string Name of player to show formspec.
---@param formname string Passed to `on_player_receive_fields` callbacks, should follow the `"modname:<whatever>"` naming convention.
---@param formspec string Formspec to display.
function core.show_formspec(playername, formname, formspec) end


--- * `playername`: name of player to close formspec
--- * `formname`: has to exactly match the one given in `show_formspec`, or the
--- formspec will not close.
--- * calling `show_formspec(playername, formname, "")` is equal to this
--- expression.
--- * to close a formspec regardless of the formname, call
--- `core.close_formspec(playername, "")`.
--- **USE THIS ONLY WHEN ABSOLUTELY NECESSARY!**
---@param playername string Name of player to close formspec
---@param formname string Has to exactly match the one given in `show_formspec`, or the formspec will not close
function core.close_formspec(playername, formname) end


--- Returns a string
--- * escapes the characters "[", "]", "\", "," and ";", which cannot be used
--- in formspecs.
---@param string string
---@return string
---@nodiscard
function core.formspec_escape(string) end


--- Returns a string
--- * escapes the characters "\", "<", and ">" to show text in a hypertext element.
--- * not safe for use with tag attributes.
---@param string string
---@return string
function core.hypertext_escape(string) end


--- Returns a table
--- * returns e.g. `{type="CHG", row=1, column=2}`
--- * `type` is one of:
--- * `"INV"`: no row selected
--- * `"CHG"`: selected
--- * `"DCL"`: double-click
---@param string string
---@return {type: '"INV"'|'"CHG"'|'"DCL"', row: integer, column: integer}
---@nodiscard
function core.explode_table_event(string) end


--- Returns a table
--- * returns e.g. `{type="CHG", index=1}`
--- * `type` is one of:
--- * `"INV"`: no row selected
--- * `"CHG"`: selected
--- * `"DCL"`: double-click
---@param string string
---@return {type: '"INV"'|'"CHG"'|'"DCL"', index: integer}
---@nodiscard
function core.explode_textlist_event(string) end


--- Returns a table
--- * returns e.g. `{type="CHG", value=500}`
--- * `type` is one of:
--- * `"INV"`: something failed
--- * `"CHG"`: has been changed
--- * `"VAL"`: not changed
---@param string string
---@return {type: '"INV"'|'"CHG"'|'"DCL"', value: integer}
---@nodiscard
function core.explode_scrollbar_event(string) end


--- * Called when the death screen should be shown.
--- * `player` is an ObjectRef, `reason` is a PlayerHPChangeReason table or nil.
--- * By default, this shows a simple formspec with the option to respawn.
--- Respawning is done via `ObjectRef:respawn`.
--- * You can override this to show a custom death screen.
--- * For general death handling, use `core.register_on_dieplayer` instead.
---@param player mt.ObjectRef
---@param reason mt.PlayerHPChangeReason|nil
function core.show_death_screen(player, reason) end