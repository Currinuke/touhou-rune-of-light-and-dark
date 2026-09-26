local Rumia, super = Class(Encounter)

function Rumia:init()
	super.init(self)
	self.text = Game:loc("encounter_rumia_start")
	self.music = "checkers"
	self.hide_world = true
	self:addEnemy("rumia")
end

function Rumia:onActionsEnd()
	for _, enemy in ipairs(Game.battle.enemies) do
		if enemy.name == Game:locText("[name:rumia]") and enemy.health <= enemy.max_health / 5 then
			Game.battle:startCutscene("rumia", "heal", self, enemy)
			-- Game.battle:setState("DEFENDINGEND", "WAVEENDED")
			return true
		end
	end
end

function Rumia:getNextWaves()
	local waves=super.getNextWaves(self)
	if Game.battle.turn_count==1 then
		waves[1]='rumia/wave1'
	elseif Game.battle.turn_count==2 then
		waves[1]='rumia/wave2'
	end
	return waves
end

return Rumia