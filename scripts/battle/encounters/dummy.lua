local MetalDummy, super = Class(Encounter)

function MetalDummy:init()
	super.init(self)

	self.text = Game:loc("encounter_metal_dummy_start")
	self.music = "battle"
	self.background = false

	self:addEnemy("dummy")
end

return MetalDummy