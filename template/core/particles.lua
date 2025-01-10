---@meta
---Particles
------------

---@param particle mt.ParticleDef
function core.add_particle(particle) end

---@param particlespawner mt.ParticleSpawnerDef
---@return number id
function core.add_particlespawner(particlespawner) end

-- Delete `ParticleSpawner` with `id`
-- (return value from `core.add_particlespawner`).
--
-- If `playername` is specified, only deletes on the player's client,
-- otherwise on all clients.
---@param id number
---@param playername string|nil
function core.delete_particlespawner(id, playername) end
