local ObjBase = require "ObjBase"
local ObjSpawnZone = Class.create("ObjSpawnZone", ObjBase)
local ModSpawner = require "modules.ModSpawner"
	
function ObjSpawnZone:create()
	self:addModule(ModSpawner)
	self:setObject({"EnSword","EnShooter","EnTorch"})
	-- lume.trace("Spawner created")
	self:setSpawnRate(4,20)
	self.modifiers = {
		{"ModDuplicator",0.02},
		{"ModFlaming",0.04},
		{"ModPlant",0.04},
		{"ModBomb",0.06},
		{"ModSuperHeavy",0.03},
		{"ModVampiric",0.03},
		{"ModNinja",0.01},
		{"ModDelicious",0.05},
		{"ModGlass",0.02},
		{"ModRadiant",0.02},
		{"ModEmitter",0.02}
	}
	--self:setActive(false)
	--ModFlaming
end

return ObjSpawnZone
