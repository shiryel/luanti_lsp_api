---@meta
---`ParticleSpawner` definition
-------------------------------

-- Used by `minetest.add_particlespawner`.
--
-- The particles' properties are random values between the min and max values.
-- Applies to: pos, velocity, acceleration, expirationtime, size.
-- If `node` is set, min and maxsize can be set to 0 to spawn
-- randomly-sized particles (just like actual node dig particles).
---@class mt.ParticleSpawnerDef
-- Number of particles spawned over the time period `time`.
---@field amount number
-- Lifespan of spawner in seconds.
-- If time is 0 spawner has infinite lifespan and spawns the `amount` on
-- a per-second basis.
---@field time number
---@field minpos mt.Vector
---@field maxpos mt.Vector
---@field minvel mt.Vector
---@field maxvel mt.Vector
---@field minacc mt.Vector
---@field maxacc mt.Vector
---@field minexptime number
---@field maxexptime number
---@field minsize number
---@field maxsize number
-- If true collide with `walkable` nodes and, depending on the
-- `object_collision` field, objects too.
---@field collisiondetection boolean
-- If true particles are removed when they collide.
-- Requires collisiondetection = true to have any effect.
---@field collision_removal boolean
-- If true particles collide with objects that are defined as
-- `physical = true,` and `collide_with_objects = true,`.
-- Requires collisiondetection = true to have any effect.
---@field object_collision boolean
-- If defined, particle positions, velocities and accelerations are
-- relative to this object's position and yaw.
---@field attached mt.ObjectRef
-- If true face player using y axis only.
---@field vertical boolean
-- The texture of the particle.
---@field texture string
-- Optional, if specified spawns particles only on the player's client.
---@field playername string|nil
-- Optional, specifies how to animate the particles' texture.
---@field animation mt.TileAnimDef|nil
-- * Optional, specify particle self-luminescence in darkness.
-- * Values: `0..14`.
---@field glow number|nil
-- Optional, if specified the particles will have the same appearance as
-- node dig particles for the given node.
-- `texture` and `animation` will be ignored if this is set.
---@field node mt.Node|nil
-- * Optional, only valid in combination with `node`.
-- * If set to a valid number 1-6, specifies the tile from which the
--   particle texture is picked.
-- * Otherwise, the default behavior is used (currently: any random tile).
---@field node_tile number|nil
