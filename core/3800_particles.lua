---@meta
---Particles
------------

--- * Deprecated: `core.add_particle(pos, velocity, acceleration,
--- expirationtime, size, collisiondetection, texture, playername)`
---@param particle mt.ParticleDef
function core.add_particle(particle) end


--- * Add a `ParticleSpawner`, an object that spawns an amount of particles
--- over `time` seconds.
--- * Returns an `id`, and -1 if adding didn't succeed
--- * Deprecated: `core.add_particlespawner(amount, time,
--- minpos, maxpos,
--- minvel, maxvel,
--- minacc, maxacc,
--- minexptime, maxexptime,
--- minsize, maxsize,
--- collisiondetection, texture, playername)`
---@param particlespawner mt.ParticleSpawnerDef
---@return number id
function core.add_particlespawner(particlespawner) end


--- * Delete `ParticleSpawner` with `id` (return value from
--- `core.add_particlespawner`).
--- * If playername is specified, only deletes on the player's client,
--- otherwise on all clients.
---@param id number
---@param playername string|nil
function core.delete_particlespawner(id, playername) end