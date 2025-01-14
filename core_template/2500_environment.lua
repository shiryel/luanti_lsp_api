---@meta
---Environment access functions
-------------------------------

---Set node at position
---@param pos mt.Vector
---@param node mt.Node
---If param1 or param2 is omitted, it's set to `0`.
---e.g. `core.set_node({x=0, y=10, z=0}, {name="default:wood"})`
function core.set_node(pos, node) end

--- alias to `core.set_node`
---@param pos mt.Vector
---@param node mt.Node
function core.add_node(pos, node) end

---@param pos_list mt.Vector[]
---@param node mt.Node
function core.bulk_set_node(pos_list, node) end

---Set node on all positions set in the first argument.
---e.g. `core.bulk_set_node({{x=0, y=1, z=1}, {x=1, y=2, z=2}}, {name="default:stone"})`
---For node specification or position syntax see `core.set_node` call
---Faster than set_node due to single call, but still considerably slower
---than Lua Voxel Manipulators (LVM) for large numbers of nodes.
---Unlike LVMs, this will call node callbacks. It also allows setting nodes
---in spread out positions which would cause LVMs to waste memory.
---For setting a cube, this is 1.3x faster than set_node whereas LVM is 20
---times faster.
---@param positions mt.Vector[]
---@param node mt.Node
function core.bulk_set_node(positions, node) end

---Set node at position, but don't remove metadata
---@param pos mt.Vector
---@param node mt.Node
function core.swap_node(pos, node) end

---@param pos_list mt.Vector[]
---@param node mt.Node
function core.bulk_swap_node(pos_list, node) end

---By default it does the same as `core.set_node(pos, {name="air"})`
---@param pos mt.Vector
function core.remove_node(pos) end

---Returns the node at the given position as table in the format
---`{name="node_name", param1=0, param2=0}`,
---@param pos mt.Vector
---@return mt.Node {name: "ignore", param1: 0, param2: 0} for unloaded areas.
function core.get_node(pos) end

---Same as `get_node` but returns `nil` for unloaded areas.
---@param pos mt.Vector
---@return mt.Node?
function core.get_node_or_nil(pos) end

---Gets the light value at the given position. Note that the light value
---"inside" the node at the given position is returned, so you usually want
---to get the light value of a neighbor.
---`pos`: The position where to measure the light.
---`timeofday`: `nil` for current time, `0` for night, `0.5` for day
---Returns a number between `0` and `15` or `nil`
---`nil` is returned e.g. when the map isn't loaded at `pos`
---@param pos mt.Vector
---@param timeofday number?
---@return integer? # number between `0` and `15` or `nil`
function core.get_node_light(pos, timeofday) end

---Figures out the sunlight (or moonlight) value at pos at the given time of
---day.
---`pos`: The position of the node
---`timeofday`: `nil` for current time, `0` for night, `0.5` for day
---Returns a number between `0` and `15` or `nil`
---This function tests 203 nodes in the worst case, which happens very
---unlikely
---@param pos mt.Vector
---@param timeofday number?
function core.get_natural_light(pos, timeofday) end

---Calculates the artificial light (light from e.g. torches) value from the
---`param1` value.
---`param1`: The param1 value of a `paramtype = "light"` node.
---Currently it's the same as `math.floor(param1 / 16)`, except that it
---ensures compatibility.
---@param param1 integer number between `0` and `255`
---@return integer # number between `0` and `15`
function core.get_artificial_light(param1) end

---Place node with the same effects that a player would cause
---@param pos mt.Vector
---@param node mt.Node
---@param placer mt.ObjectRef|nil
function core.place_node(pos, node, placer) end

---Dig node with the same effects that a player would cause
---Returns `true` if successful, `false` on failure (e.g. protected location)
---@param pos mt.Vector
---@param digger mt.ObjectRef|nil
---@return boolean
function core.dig_node(pos, digger) end

---Punch node with the same effects that a player would cause
---@param pos mt.Vector
---@param puncher mt.ObjectRef|nil
function core.punch_node(pos, puncher) end

---Change node into falling node
---Returns `true` and the ObjectRef of the spawned entity if successful, `false` on failure
---@param pos mt.Vector
---@return boolean
function core.spawn_falling_node(pos) end

---Get a table of positions of nodes that have metadata within a region
---{pos1, pos2}.
---@param pos1 mt.Vector
---@param pos2 mt.Vector
---@return mt.Vector[]
function core.find_nodes_with_meta(pos1, pos2) end

---* Get a `NodeMetaRef` at that position
---@param pos mt.Vector
---@return mt.NodeMetaRef
function core.get_meta(pos) end

---Get `NodeTimerRef`
---@param pos mt.Vector
---@return mt.NodeTimerRef
function core.get_node_timer(pos) end

---Spawn Lua-defined entity at position.
---@param pos mt.Vector
---@param name string
---@param staticdata? string
---@return mt.ObjectRef? ref or `nil` if failed
function core.add_entity(pos, name, staticdata) end

---Spawn item
---@param pos mt.Vector
---@param item mt.Item
---@return mt.ObjectRef? ref or `nil` if failed
function core.add_item(pos, item) end

---Get an `ObjectRef` to a player
---@param name string player name
---@return mt.PlayerObjectRef player_ref
function core.get_player_by_name(name) end

---returns a list of ObjectRefs in a sphere
---@param pos mt.Vector
---@param radius number using a Euclidean metric
---@return mt.ObjectRef[] refs
function core.get_objects_inside_radius(pos, radius) end

---@param center mt.Vector
---@param radius number using a Euclidean metric
---@return function
function core.objects_inside_radius(center, radius) end

---returns a list of ObjectRefs between `pos1` and `pos2`
---(min and max positions of the area to search)
---@param min_pos mt.Vector
---@param max_pos mt.Vector
---@return mt.ObjectRef[] refs
function core.get_objects_in_area(min_pos, max_pos) end

---@param min_pos mt.Vector
---@param max_pos mt.Vector
---@return function
function core.objects_in_area(min_pos, max_pos) end

---@param val number between `0` and `1`; `0` for midnight, `0.5` for midday
function core.set_timeofday(val) end

---@return number timeofday between `0` and `1`; `0` for midnight, `0.5` for midday
function core.get_timeofday() end

---@return number | nil time the time, in seconds, since the world was created. The time is not available (`nil`) before the first server step.
function core.get_gametime() end

---@return number days number of days elapsed since world was created.
---accounts for time changes.
function core.get_day_count() end

---@param pos mt.Vector
---@param radius number using a maximum metric
---@param nodenames string[]|string e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
---@param search_center boolean? optional boolean (default: `false`). If true, `pos` is also checked for the nodes
---@return mt.Vector? pos
function core.find_node_near(pos, radius, nodenames, search_center) end

---@param pos1 mt.Vector min position of area to search
---@param pos2 mt.Vector max position of area to search
---@param nodenames string[]|string e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
---@param grouped boolean?
---@return { string: mt.Vector[] } | mt.Vector[]
---@return nil | { string: number }
---If `grouped` is `true` the return value is a table indexed by node name
---which contains lists of positions.
---If `grouped` is `false` or absent the return values are as follows:
---first value: Table with all node positions
---second value: Table with the count of each node with the node name
---as index
---Area volume is limited to 4,096,000 nodes
function core.find_nodes_in_area(pos1, pos2, nodenames, grouped) end

---@param nodenames string[]|string e.g. `{"ignore", "group:tree"}` or `"default:dirt"`
---@return mt.Vector[] # list of positions with a node air above
---Area volume is limited to 4,096,000 nodes
function core.find_nodes_in_area_under_air(pos1, pos2, nodenames) end

---Get world-specific perlin noise
---The actual seed used is the noiseparams seed plus the world seed.
---@param noiseparams mt.NoiseParams
---@return mt.PerlinNoise # world-specific perlin noise
function core.get_perlin(noiseparams) end

---Deprecated: use `core.get_perlin(noiseparams)` instead.
---Return world-specific perlin noise.
function core.get_perlin(seeddiff, octaves, persistence, spread) end

---Return voxel manipulator object.
---Loads the manipulator from the map if positions are passed.
---@param pos1 mt.Vector?
---@param pos2 mt.Vector?
---@return mt.VoxelManip
function core.get_voxel_manip(pos1, pos2) end

---Return voxel manipulator object.
---Loads the manipulator from the map if positions are passed.
---@param pos1 mt.Vector?
---@param pos2 mt.Vector?
---@return mt.VoxelManip
function VoxelManip(pos1, pos2) end

---@alias mt.DecorID string|number

---Set the types of on-generate notifications that should be collected.
---
---Available flags:
---* dungeon
---* temple
---* cave_begin
---* cave_end
---* large_cave_begin
---* large_cave_end
---* decoration
---@param flags {[string]: boolean}|nil
---@param deco_ids mt.DecorID[]|nil list of IDs of decorations which notification is requested for.
---@param custom_ids string[]|nil
function core.set_gen_notify(flags, deco_ids, custom_ids) end

---@return string flags
---@return mt.DecorID[] # `deco_id`'s.
function core.get_gen_notify() end

---@param decoration_name string
---@return mt.DecorID? # Decoration ID number for the provided decoration name string, or `nil` on failure.
function core.get_decoration_id(decoration_name) end

---@alias mt.VoxelManipName
---|"voxelmanip"
---|"heightmap"
---|"biomemap"
---|"heatmap"
---|"humiditymap"
---|"gennotify"

---@param objectname mt.VoxelManipName
---@return mt.MapgenObject? # requested mapgen object if available
function core.get_mapgen_object(objectname) end

---@param pos mt.Vector
---@return number? # heat at the position, or `nil` on failure.
function core.get_heat(pos) end

---@param pos mt.Vector
---@return number? # humidity at the position, or `nil` on failure.
function core.get_humidity(pos) end

---@class mt.BiomeData
---@field biome string
---@field heat number
---@field humidity number

---@param pos mt.Vector
---@return mt.BiomeData | nil
---Get table with biome data at position or `nil` on failure.
function core.get_biome_data(pos) end

---@param biome_name string
---@return string # biome id, as used in the biomemap Mapgen object and returned
---by `core.get_biome_data(pos)`, for a given biome_name string.
function core.get_biome_id(biome_name) end

---@param biome_id string
---@return string|nil # biome name string for the provided biome id, or `nil` on failure.
---If no biomes have been registered, such as in mgv6, returns `default`.
function core.get_biome_name(biome_id) end

---@class mt.MapgenParams
---@field mgname string
---@field seed number
---@field chunksize number
---@field water_level number
---@field flags string

---@deprecated
---Deprecated, use `core.get_mapgen_setting(name)` instead.
---@return mt.MapgenParams
function core.get_mapgen_params() end

---@deprecated
---Deprecated: use `core.set_mapgen_setting(name, value, override) instead.
---Set map generation parameters.
---Function cannot be called after the registration period.
---@param params mt.MapgenParams
--- * Leave field unset to leave that parameter unchanged.
--- * `flags` contains a comma-delimited string of flags to set, or if the
---   prefix `"no"` is attached, clears instead.
--- * `flags` is in the same format and has the same options as `mg_flags` in
---   `core.conf`.
function core.set_mapgen_params(params) end

---@return mt.Vector min minimum possible generated node position
---@return mt.Vector max maximum possible generated node position
---@param mapgen_limit? number optional limit
---If it is absent, its value is that of the *active* mapgen setting `"mapgen_limit"`.
---@param chunksize? number optional number.
---If it is absent, its value is that of the *active* mapgen setting `"chunksize"`.
function core.get_mapgen_edges(mapgen_limit, chunksize) end

---@param name string setting name
---@return string? # mapgen setting (or nil if none exists) in string format
---with the following order of precedence:
---1. Settings loaded from map_meta.txt or overrides set during mod execution.
---2. Settings set by mods without a metafile override
---3. Settings explicitly set in the user config file, core.conf
---4. Settings set as the user config default
function core.get_mapgen_setting(name) end

---@param name string setting name
---@return string|mt.NoiseParams
---Same as `core.get_mapgen_setting`, but returns the value as a NoiseParams table if the
---setting `name` exists and is a valid NoiseParams.
---@see core.get_mapgen_setting
---@see mt.NoiseParams
function core.get_mapgen_setting_noiseparams(name) end

---Sets a mapgen param to `value`, and will take effect if the corresponding
---mapgen setting is not already present in map_meta.txt.
---@param name string setting name
---@param value any value
---@param override_meta? boolean if true, overrides value in map metafile
---Note: to set the seed, use `"seed"`, not `"fixed_map_seed"`.
function core.set_mapgen_setting(name, value, override_meta) end

---Sets a mapgen noise param to `value`, and will take effect if the corresponding
---mapgen setting is not already present in map_meta.txt.
---@param name string
---@param value mt.NoiseParams
---@param override_meta? boolean if true, overrides value in map metafile
function core.set_mapgen_setting_noiseparams(name, value, override_meta) end

---Sets the noiseparams setting of `name` to the noiseparams table specified
---in `noiseparams`.
---@param name string
---@param noiseparams mt.NoiseParams
---@param set_default? boolean specifies whether the setting should be
---applied to the default config or current active config
function core.set_noiseparams(name, noiseparams, set_default) end

---@param name string
---@return table # table of the noiseparams for name.
function core.get_noiseparams(name) end

---Generate all registered ores within the VoxelManip `vm` and in the area
---from `pos1` to `pos2`.
---`pos1` and `pos2` are optional and default to mapchunk minp and maxp.
---@param vm mt.VoxelManip
---@param pos1 mt.Vector
---@param pos2 mt.Vector
function core.generate_ores(vm, pos1, pos2) end

---Generate all registered decorations within the VoxelManip `vm` and in the
---area from `pos1` to `pos2`.
---`pos1` and `pos2` are optional and default to mapchunk minp and maxp.
---@param vm mt.VoxelManip
---@param pos1 mt.Vector
---@param pos2 mt.Vector
function core.generate_decorations(vm, pos1, pos2) end

---Clear all objects in the environment
---@param options? {mode: "full"|"quick"}
---* mode = `"full"`: Load and go through every mapblock, clearing
---                   objects (default).
---* mode = `"quick"`: Clear objects immediately in loaded mapblocks,
---                   clear objects in unloaded mapblocks only when the
---                   mapblocks are next activated.
function core.clear_objects(options) end

---Load the mapblocks containing the area from `pos1` to `pos2`.
---@param pos1 mt.Vector
---@param pos2? mt.Vector defaults to `pos1` if not specified.
---This function does not trigger map generation.
function core.load_area(pos1, pos2) end

---@enum mt.EmergeAction
local EmergeAction = {
	EMERGE_CANCELLED = 0,
	EMERGE_ERRORED = 1,
	EMERGE_FROM_MEMORY = 2,
	EMERGE_FROM_DISK = 3,
	EMERGE_GENERATED = 4,
}

core.EMERGE_CANCELLED = EmergeAction.EMERGE_CANCELLED
core.EMERGE_ERRORED = EmergeAction.EMERGE_ERRORED
core.EMERGE_FROM_MEMORY = EmergeAction.EMERGE_FROM_MEMORY
core.EMERGE_FROM_DISK = EmergeAction.EMERGE_FROM_DISK
core.EMERGE_GENERATED = EmergeAction.EMERGE_GENERATED

---Queue all blocks in the area from `pos1` to `pos2`, inclusive, to be
---asynchronously fetched from memory, loaded from disk, or if inexistent,
---generates them.
---If `callback` is a valid Lua function, this will be called for each block
---emerged.
---@param pos1 mt.Vector
---@param pos2 mt.Vector
---@param callback? fun(blockpos: boolean, action: mt.EmergeAction, calls_remaining: integer, param: any)
---@param param any user-defined parameter passed to callback
function core.emerge_area(pos1, pos2, callback, param) end

---Delete all mapblocks in the area from pos1 to pos2, inclusive.
---@param pos1 mt.Vector
---@param pos2 mt.Vector
function core.delete_area(pos1, pos2) end

---Checks if there is anything other than air between pos1 and pos2.
---Returns false if something is blocking the sight.
---Returns the position of the blocking node when `false`
---@param pos1 mt.Vector First position
---@param pos2 mt.Vector Second position
---@return boolean # false if something is blocking the sight
---@return mt.Vector # the position of the blocking node when `false`
function core.line_of_sight(pos1, pos2) end

---Creates a `Raycast` object.
---@param pos1 mt.Vector start of the ray
---@param pos2 mt.Vector end of the ray
---@param objects boolean if false, only nodes will be returned. Default is `true`.
---@param liquids boolean if false, liquid nodes (`liquidtype ~= "none"`) won't be returned. Default is `false`.
---@return mt.Raycast
function core.raycast(pos1, pos2, objects, liquids) end

---returns table containing path that can be walked on
---@param pos1 mt.Vector start position
---@param pos2 mt.Vector end position
---@param searchdistance number maximum distance from the search positions to search in.
---In detail: Path must be completely inside a cuboid. The minimum
---`searchdistance` of 1 will confine search between `pos1` and `pos2`.
---Larger values will increase the size of this cuboid in all directions
---@param max_jump number maximum height difference to consider walkable
---@param max_drop number maximum height difference to consider droppable
---@param algorithm? "A*_noprefetch"|"A*"|"Dijkstra" algorithm
---`"A*_noprefetch"` is default
---Difference between `"A*"` and `"A*_noprefetch"` is that
---`"A*"` will pre-calculate the cost-data, the other will calculate it
---on-the-fly
---@return mt.Vector[]? # a table of 3D points representing a path from `pos1` to `pos2`
---or `nil` on failure.
---Reasons for failure:
--- * No path exists at all
--- * No path exists within `searchdistance` (see below)
--- * Start or end pos is buried in land
function core.find_path(pos1, pos2, searchdistance, max_jump, max_drop, algorithm) end

---Spawns L-system tree at given `pos` with definition in `treedef` table
---@param pos mt.Vector
---@param treedef mt.TreeDef
function core.spawn_tree(pos, treedef) end

---Add node to liquid flow update queue
---@param pos mt.Vector
function core.transforming_liquid_add(pos) end

---Get max available level for leveled node
---@param pos mt.Vector
---@return number level
function core.get_node_max_level(pos) end

---Get level of leveled node (water, snow)
---@param pos mt.Vector
---@return number level
function core.get_node_level(pos) end

---Set level of leveled node, default `level` equals `1`
---@param pos mt.Vector
---@param level number
---if `totallevel > maxlevel`, returns rest (`total-max`).
function core.set_node_level(pos, level) end

---increase level of leveled node by level, default `level` equals `1`
---@param pos mt.Vector
---@param level number
---if `totallevel > maxlevel`, returns rest (`total-max`)
---`level` must be between -127 and 127
function core.add_node_level(pos, level) end

---@param box_type mt.NodeBox|any
---@param pos mt.Vector
---@param nodes [table]
function core.get_node_boxes(box_type, pos, nodes) end

---Resets the light in a cuboid-shaped part of
---the map and removes lighting bugs.
---Loads the area if it is not loaded.
---@param pos1 mt.Vector is the corner of the cuboid with the least coordinates
---(in node coordinates), inclusive.
---@param pos2 mt.Vector is the opposite corner of the cuboid, inclusive.
---The actual updated cuboid might be larger than the specified one,
---because only whole map blocks can be updated.
---The actual updated area consists of those map blocks that intersect
---with the given cuboid.
---However, the neighborhood of the updated area might change
---as well, as light can spread out of the cuboid, also light
---might be removed.
---@return boolean # `false` if the area is not fully generated,
---`true` otherwise
function core.fix_light(pos1, pos2) end

---Causes an unsupported `group:falling_node` node to fall and causes an
---unattached `group:attached_node` node to fall.
---Does not spread these updates to neighbors.
---@param pos mt.Vector
function core.check_single_for_falling(pos) end

---Causes an unsupported `group:falling_node` node to fall and causes an
---unattached `group:attached_node` node to fall.
---Spread these updates to neighbors and can cause a cascade
---of nodes to fall.
---@param pos mt.Vector
function core.check_for_falling(pos) end

---Returns a player spawn y co-ordinate for the provided (x, z)
---co-ordinates, or `nil` for an unsuitable spawn point.
---For most mapgens a 'suitable spawn point' is one with y between
---`water_level` and `water_level + 16`, and in mgv7 well away from rivers,
---so `nil` will be returned for many (x, z) co-ordinates.
---The spawn level returned is for a player spawn in unmodified terrain.
---The spawn level is intentionally above terrain level to cope with
---full-node biome 'dust' nodes.
---@param x number
---@param z number
---@return mt.Vector
function core.get_spawn_level(x, z) end