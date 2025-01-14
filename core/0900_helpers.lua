---@meta
---Helper functions
-------------------
---@diagnostic disable: missing-return

--- Returns a string which makes `obj` human-readable.
---@param obj any
---@param dumped string|nil Default: `{}`.
---@return string
function dump(obj, dumped) end


--- Returns a string which makes `obj` human-readable, handles reference loops.
---@param obj any
---@param name string|nil Default: `"_"`.
---@param dumped string|nil Default: `{}`.
---@return string
function dump2(obj, name, dumped) end


--- Get the hypotenuse of a triangle with legs x and y. Useful for distance
--- calculation.
---@param x mt.Vector
---@param y mt.Vector
---@return number
function math.hypot(x, y) end


--- Get the sign of a number.
---
--- If the absolute value of `x` is within the `tolerance` or `x` is NaN, `0` is
--- returned.
---@param x number
---@param tolerance number|nil Default: `0`
---@return -1|0|1
function math.sign(x, tolerance) end


---@param x number
---@return  number
function math.factorial(x) end


--- `"a,b":split","` returns `{"a", "b"}`.
---@param str string
---@param separator string|nil Cannot be empty. Default: `","`.
---@param include_empty boolean|nil Default: `false`.
---@param max_splits number|nil If it's negative, splits aren't limited. Default: `-1`.
---@param sep_is_pattern boolean|nil Is separator a plain string or a pattern? Default: `false`.
---@return string[]
function string.split(str, separator, include_empty, max_splits, sep_is_pattern) end


--- Returns the string without whitespace pre- and suffixes.
--- - e.g. `"\n \t\tfoo bar\t ":trim()` returns `"foo bar"`
---@param str string
---@return string
function string.trim(str) end


--- Returns a string or table
--- * Adds newlines to the string to keep it within the specified character
--- limit
--- * Note that the returned lines may be longer than the limit since it only
--- splits at word borders.
--- * `limit`: number, maximal amount of characters in one line
--- * `as_table`: boolean, if set to true, a table of lines instead of a string
--- is returned, default: `false`
---@param str string
---@param limit number Maximal amount of characters in one line.
---@param as_table boolean|nil If `true`, a table of lines instead of a string is returned, default: `false`.
---@return string|table
function core.wrap_text(str, limit, as_table) end


--- Returns string `"(X,Y,Z)"`
--- * `pos`: table {x=X, y=Y, z=Z}
--- * Converts the position `pos` to a human-readable, printable string
--- * `decimal_places`: number, if specified, the x, y and z values of
--- the position are rounded to the given decimal place.
---@param pos mt.Vector
---@param decimal_places number|nil If specified, the x, y and z values of the position are rounded to the given decimal place.
---@return string
function core.pos_to_string(pos, decimal_places) end


--- Returns a position or `nil`
--- * Same but in reverse.
--- * If the string can't be parsed to a position, nothing is returned.
---@return mt.Vector|nil
function core.string_to_pos(string) end


--- Convert a string like `"(X1, Y1, Z1) (X2, Y2, Z2)"` to two vectors - box angles.
--- 
--- - `relative_to`: Optional. If set to a position, each coordinate can use the
---   tilde notation for relative positions.
--- - Tilde notation: `"~"`: Relative coordinate `"~<number>"`: Relative coordinate
---   plus `<number>`.
--- - Example: `core.string_to_area("(1,2,3) (~5,~-5,~)", {x=10,y=10,z=10})`
---   returns `{x=1,y=2,z=3}, {x=15,y=5,z=10}`.
---@param str string
---@param relative_to mt.Vector|nil
---@return mt.Vector, mt.Vector
function core.string_to_area(str, relative_to) end


--- Returns a string
--- * escapes the characters "[", "]", "\", "," and ";", which cannot be used
--- in formspecs.
---@param str string
---@return string
function core.formspec_escape(str) end


--- * returns true if passed 'y', 'yes', 'true' or a number that isn't zero.
---@param arg any
---@return boolean
function core.is_yes(arg) end


--- * returns true when the passed number represents NaN.
---@param arg any
---@return boolean
function core.is_nan(arg) end


--- * returns time with microsecond precision. May not return wall time.
--- * returns a deep copy of `table`
--- the value `val` in the table `list`. Non-numerical indices are ignored.
--- If `val` could not be found, `-1` is returned. `list` must not have
--- negative indices.
--- the value `val` in the table `table`. If multiple keys contain `val`,
--- it is unspecified which key will be returned.
--- If `val` could not be found, `nil` is returned.
--- * Appends all values in `other_table` to `table` - uses `#table + 1` to
--- find new indices.
--- * If multiple keys in `t` map to the same value, it is unspecified which
--- value maps to that key.
--- * Shuffles elements `from` to `to` in `table` in place
--- * `from` defaults to `1`
--- * `to` defaults to `#table`
--- * `random_func` defaults to `math.random`. This function receives two
--- integers as arguments and should return a random integer inclusively
--- between them.
---@return number
function core.get_us_time() end


--- Returns a deep copy of `t`.
---@generic T:table
---@param t T
---@return T
function table.copy(t) end


--- Returns the smallest numerical index containing
--- the value `val` in the table `list`. Non-numerical indexes are ignored. If
--- `val` could not be found, `-1` is returned. `list` must not have negative
--- indexes.
---@param list any[]
---@param val any
---@return integer
function table.indexof(list, val) end


--- Appends all values in `other_table` to `table` - uses `#table + 1` to find
--- new indexes.
---@param table table
---@param other_table table
function table.insert_all(table, other_table) end


--- Returns a table with keys and values swapped.
---
--- If multiple keys in `t` map to the same value, it is unspecified which value
--- maps to that key.
---@param t table
---@return table swapped
function table.key_value_swap(t) end


--- Shuffles elements `from` to `to` in `table` in place.
---@param table table
---@param from number|nil Default: `1`
---@param to number|nil Default: `#table`
---@param random_func nil|fun(number, number?):number Default: `math.random`
function table.shuffle(table, from, to, random_func) end


--- Returns a
--- position.
--- * returns the exact position on the surface of a pointed node
---@param placer mt.ObjectRef
---@param pointed_thing mt.PointedThing
---@return mt.Vector position
function core.pointed_thing_to_face_pos(placer, pointed_thing) end


--- * Simulates a tool being used once and returns the added wear,
--- such that, if only this function is used to calculate wear,
--- the tool will break exactly after `uses` times of uses
--- * `uses`: Number of times the tool can be used
--- * `initial_wear`: The initial wear the tool starts with (default: 0)
---@param uses number Number of times the tool can be used.
---@param initial_wear number|nil Initial wear the tool starts with (default: `0`).
---@return number
function core.get_tool_wear_after_use(uses, initial_wear) end


--- Simulates an item that digs a node.
--- Returns a table with the following fields:
--- * `diggable`: `true` if node can be dug, `false` otherwise.
--- * `time`: Time it would take to dig the node.
--- * `wear`: How much wear would be added to the tool (ignored for non-tools).
--- `time` and `wear` are meaningless if node's not diggable
--- Parameters:
--- * `groups`: Table of the node groups of the node that would be dug
--- * `tool_capabilities`: Tool capabilities table of the item
--- * `wear`: Amount of wear the tool starts with (default: 0)
---@param groups mt.ObjectGroups
---@param tool_capabilities mt.ToolCaps
---@param wear number|nil Amount of wear the tool starts with (default: `0`).
---@return mt.DigParams
function core.get_dig_params(groups, tool_capabilities, wear) end


--- How much wear would be added to the tool (ignored for non-tools).
---@class mt.DigParams
---@field diggable boolean `true` if node can be dug, `false` otherwise.
---@field time number|nil Time it would take to dig the node.
---@field wear number|nil

--- Groups are stored in a table, having the group names with keys and the group
--- ratings as values. Group ratings are integer values within the range [-32767,
--- 32767]. For example:
--- 
---     -- Default dirt
---     groups = {crumbly=3, soil=1}
--- 
---     -- A more special dirt-kind of thing
---     groups = {crumbly=2, soil=1, level=2, outerspace=1}
--- 
--- Groups always have a rating associated with them. If there is no useful meaning
--- for a rating for an enabled group, it shall be `1`.
--- 
--- When not defined, the rating of a group defaults to `0`. Thus when you read
--- groups, you must interpret `nil` and `0` as the same value, `0`.
--- 
--- You can read the rating of a group for an item or a node by using
--- 
---     core.get_item_group(itemname, groupname)
---@alias mt.ObjectGroups table<string, number>

--- Simulates an item that punches an object.
--- Returns a table with the following fields:
--- * `hp`: How much damage the punch would cause (between -65535 and 65535).
--- * `wear`: How much wear would be added to the tool (ignored for non-tools).
--- Parameters:
--- * `groups`: Damage groups of the object
--- * `tool_capabilities`: Tool capabilities table of the item
--- * `time_from_last_punch`: time in seconds since last punch action
--- * `wear`: Amount of wear the item starts with (default: 0)
---@param groups mt.ObjectGroups
---@param tool_caps mt.ToolCaps
---@param last_punch_time number|nil Time in seconds since last punch action.
---@param wear number|nil Amount of wear the item starts with (default: `0`).
---@return mt.HitParams
function core.get_hit_params(groups, tool_caps, last_punch_time, wear) end


---@class mt.HitParams
---@field hp number
---@field wear number