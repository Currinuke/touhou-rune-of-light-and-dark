local Flandre, super = Class(Encounter)

function Flandre:init()
	super.init(self)
	self.text = Game:loc("encounter_flandre_start")
	self.music = "joker"
	self.background = false

	for _, value in ipairs({"B", "C", "D"}) do
		local enemy = self:addEnemy("flandre")
		enemy.name = Game:loc("enemy_flandre" .. value .. "_name")
		enemy.check = Game:loc("enemy_flandre" .. value .. "_check")
		enemy:setActor("flandre_" .. string.lower(value))
	end
	
	self.no_end_message = true
end

function Flandre:createSoul(x, y, color)
	return DoubleSoul(x, y, color)
end

return Flandre