---@meta
---Schematics
-------------

-- A schematic specifier identifies a schematic by either a filename to a
-- Minetest Schematic file (`.mts`) or through raw data supplied through Lua,
-- in the form of a table.
-- 3D vector containing the dimensions of the provided schematic. (required field)
-- A flat table of MapNode tables making up the schematic,
-- in the order of `[z [y [x]]]`. (required field)
-- A table of {ypos, prob} slice tables. A slice table
-- sets the probability of a particular horizontal slice of the schematic being
-- placed. (optional field)
---@class mt.SchematicSpecTable
---@field size mt.Vector
---@field data mt.MapNode[]
---@field yslice_prob {ypos:number, prob:number}[]?

---@alias mt.SchematicSpec mt.SchematicSpecTable|string

---|"place_center_x" Placement of this decoration is centered along the X axis.
---|"place_center_y" Placement of this decoration is centered along the Y axis.
---|"place_center_z" Placement of this decoration is centered along the Z axis.
---|"force_placement" Schematic nodes other than "ignore" will replace existing nodes.
---@alias mt.SchematicAttr

-- Used in `core.create_schematic`.
--
-- - If there are two or more entries with the same `pos` value, the last entry
--   is used.
-- - If `pos` is not inside the box formed by `p1` and `p2`, it is ignored.
-- - If `probability_list` equals `nil`, no probabilities are applied.
-- From `0` to `255` that encodes probability and per-node force-place.
-- Probability has levels 0-127, then 128 may be added
-- to encode per-node force-place. For probability stated as 0-255,
-- divide by 2 and round down to get values 0-127, then add 128 to apply
-- per-node force-place.
---@class mt.SchematicProbability
---@field pos mt.Vector Absolute coordinates of the node being modified.
---@field prob integer

-- Used in `core.create_schematic`.
--
-- - If slice probability list equals `nil`, no slice probabilities are applied.
-- Indicates the y position of the slice with a probability applied,
-- the lowest slice being `ypos = 0`.
-- From `0` to `255` that encodes probability and per-node force-place.
-- Probability has levels 0-127, then 128 may be added
-- to encode per-node force-place. For probability stated as 0-255,
-- divide by 2 and round down to get values 0-127, then add 128 to apply
-- per-node force-place.
---@class mt.SchematicSliceProbability
---@field ypos number
---@field prob integer

---|"mts" A string containing the binary MTS data used in the MTS file format.
---|"lua" A string containing Lua code representing the schematic in table format.
---@alias mt.SchematicFormat

-- Used in `core.serialize_schematic`.
-- If `lua_use_comments` is true and `format` is "lua", the Lua code
-- generated will have (X, Z) position comments for every X row generated in
-- the schematic data for easier reading.
-- If `lua_num_indent_spaces` is a nonzero number and `format` is "lua", the
-- Lua code generated will use that number of spaces as indentation instead
-- of a tab character.
---@class mt.SchematicSerializeOptions
---@field lua_use_comments boolean
---@field lua_num_indent_spaces number

-- Used in `core.read_schematic`.
-- - `none`: no `write_yslice_prob` table is inserted,
-- - `low`: only probabilities that are not 254 or 255 are written in the
--   `write_ylisce_prob` table,
-- - `all`: write all probabilities to the `write_yslice_prob` table.
-- - The default for this option is `all`.
-- - Any invalid value will be interpreted as `all`.
---@class mt.SchematicReadOptions
---@field write_yslice_prob "none"|"low"|"all"