---@meta

---@alias mt.DecorType
---Creates a 1 times `H` times 1 column of a specified node (or a random node from
---a list, if a decoration list is specified). Can specify a certain node it must
---spawn next to, such as water or lava, for example. Can also generate a
---decoration of random height between a specified lower and upper bound.
---This type of decoration is intended for placement of grass, flowers, cacti,
---papyri, waterlilies and so on.
---|"simple"
---Copies a box of `MapNodes` from a specified schematic file (or raw description).
---Can specify a probability of a node randomly appearing when placed.
---This decoration type is intended to be used for multi-node sized discrete
---structures, such as trees, cave spikes, rocks, and so on.
---|"schematic"
---Generates a L-system tree at the position where the decoration is placed.
---Uses the same L-system as `core.spawn_tree`, but is faster than using it manually.
---The `treedef` field in the decoration definition is used for the tree definition.
---|"lsystem"

--- Used by `core.register_decoration`.
---@alias mt.DecorDef mt.DecorDefSimple|mt.DecorDefSchematic|mt.DecorDefLSystem

---@class mt.DecorDefCommon
---@field deco_type mt.DecorType Type. "simple", "schematic" or "lsystem" supported
---@field place_on string|string[] Node (or list of nodes) that the decoration can be placed on
--- Size of the square (X / Z) divisions of the mapchunk being generated.
--- Determines the resolution of noise variation if used.
--- If the chunk size is not evenly divisible by sidelen, sidelen is made
--- equal to the chunk size.
---@field sidelen number
--- The value determines 'decorations per surface node'.
--- Used only if noise_params is not specified.
--- If >= 10.0 complete coverage is enabled and decoration placement uses
--- a different and much faster method.
---@field fill_ratio number?
--- NoiseParams structure describing the perlin noise used for decoration
--- distribution.
--- A noise value is calculated for each square division and determines
--- 'decorations per surface node' within each division.
--- If the noise value >= 10.0 complete coverage is enabled and
--- decoration placement uses a different and much faster method.
---@field noise_params mt.NoiseParams?
--- List of biomes in which this decoration occurs. Occurs in all biomes
--- if this is omitted, and ignored if the Mapgen being used does not
--- support biomes.
--- Can be a list of (or a single) biome names, IDs, or definitions.
---@field biomes string[]?
---@field y_min number Lower and upper limits for decoration (inclusive). These parameters refer to the Y coordinate of the 'place_on' node.
---@field y_max number Lower and upper limits for decoration (inclusive). These parameters refer to the Y coordinate of the 'place_on' node.
--- Node (or list of nodes) that the decoration only spawns next to.
--- Checks the 8 neighboring nodes on the same height,
--- and also the ones at the height plus the check_offset, excluding both center nodes.
---@field spawn_by string|string[]?
--- Specifies the offset that spawn_by should also check
--- The default value of -1 is useful to e.g check for water next to the base node.
--- 0 disables additional checks, valid values: {-1, 0, 1}
---@field check_offset number?
--- Number of spawn_by nodes that must be surrounding the decoration
--- position to occur.
--- If absent or -1, decorations occur next to any nodes.
---@field num_spawn_by number?
--- Flags for all decoration types.
--- "liquid_surface": Instead of placement on the highest solid surface
---   in a mapchunk column, placement is on the highest liquid surface.
---   Placement is disabled if solid nodes are found above the liquid
---   surface.
--- "force_placement": Nodes other than "air" and "ignore" are replaced
---   by the decoration.
--- "all_floors", "all_ceilings": Instead of placement on the highest
---   surface in a mapchunk the decoration is placed on all floor and/or
---   ceiling surfaces, for example in caves and dungeons.
---   Ceiling decorations act as an inversion of floor decorations so the
---   effect of 'place_offset_y' is inverted.
---   Y-slice probabilities do not function correctly for ceiling
---   schematic decorations as the behavior is unchanged.
---   If a single decoration registration has both flags the floor and
---   ceiling decorations will be aligned vertically.
---@field flags string?


---@class mt.DecorDefSimple:mt.DecorDefCommon
--- The node name used as the decoration.
--- If instead a list of strings, a randomly selected node from the list
--- is placed as the decoration.
---@field decoration string|string[]?
--- Decoration height in nodes.
--- If height_max is not 0, this is the lower limit of a randomly
--- selected height
---@field height number?
--- Upper limit of the randomly selected height.
--- If absent, the parameter 'height' is used as a constant.
---@field height_max number?
--- Param2 value of decoration nodes.
--- If param2_max is not 0, this is the lower limit of a randomly selected param2.
---@field param2 number?
--- Upper limit of the randomly selected param2.
--- If absent, the parameter 'param2' is used as a constant.
---@field param2_max number?
--- Y offset of the decoration base node relative to the standard base node position.
--- Can be positive or negative. Default is 0.
--- Effect is inverted for "all_ceilings" decorations.
--- Ignored by 'y_min', 'y_max' and 'spawn_by' checks, which always refer to the 'place_on' node.
---@field place_offset_y number?


---@class mt.DecorDefSchematic:mt.DecorDefCommon
--- If schematic is a string, it is the filepath relative to the current
--- working directory of the specified Luanti schematic file.
--- Could also be the ID of a previously registered schematic.
---@field schematic string|mt.SchematicSpec?
--- Map of node names to replace in the schematic after reading it.
---@field replacements table?
--- Rotation can be "0", "90", "180", "270", or "random"
---@field rotation string?
--- Y offset of the decoration base node relative to the standard base node position.
--- Can be positive or negative. Default is 0.
--- Effect is inverted for "all_ceilings" decorations.
--- Ignored by 'y_min', 'y_max' and 'spawn_by' checks, which always refer to the 'place_on' node.
---
--- If the flag 'place_center_y' is set this parameter is ignored.
---@field place_offset_y number?

---@class mt.DecorDefLSystem:mt.DecorDefCommon
--- Same as for `core.spawn_tree`.
--- See "L-system trees" for more details.
---@field treedef table?
