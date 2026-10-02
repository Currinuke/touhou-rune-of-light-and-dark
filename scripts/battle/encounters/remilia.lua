local Remilia, super = Class(Encounter)

function Remilia:init()
	super.init(self)

	self.text = Game:loc("encounter_remilia_start")
	self.music = "kingboss"
	self.background = false
	self.remilia = self:addEnemy("remilia")
	self.remilia:setAnimation("battle/idle")
	self.no_end_message = true
end

function Remilia:onStateChange(old, new)
	if Game.battle.turn_count ~= 1 then
		if new == "ACTIONSELECT" then
			Game.battle.battle_ui.current_encounter_text = {text = self.remilia.text}
			Game.battle.battle_ui.encounter_text.text:setText(self.remilia.text)
		end
	end
end

function Remilia:onReturnToWorld(events)
end

function Remilia:getNextWaves()
	local waves = super.getNextWaves(self)
	if Game.battle.turn_count == 1 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_2")
		self.remilia.text = Game:loc("enemy_remilia_turn_1")
		waves[1] = "remilia/wave1"
	elseif Game.battle.turn_count == 2 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_3")
		self.remilia.text=Game:loc("enemy_remilia_turn_2")
		waves[1] = "remilia/wave2"
	elseif Game.battle.turn_count == 3 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_4")
		self.remilia.text = Game:loc("enemy_remilia_turn_3")
		waves[1] = "remilia/wave3"
	elseif Game.battle.turn_count == 4 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_5")
		self.remilia.text=Game:loc("enemy_remilia_turn_4")
		waves[1] = 'remilia/wave4'
	elseif Game.battle.turn_count==5 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_6")
		self.remilia.text=Game:loc("enemy_remilia_turn_5")
		waves[1] = 'remilia/wave5'
	elseif Game.battle.turn_count==6 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_7")
		self.remilia.text=Game:loc("enemy_remilia_turn_6")
		waves[1] = 'remilia/wave6'
	elseif Game.battle.turn_count==7 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_8")
		self.remilia.text=Game:loc("enemy_remilia_turn_7")
		waves[1] = 'remilia/wave7'
	elseif Game.battle.turn_count==8 then
		self.remilia.dialogue_override={Game:loc("enemy_remilia_dialogue_9_1"),Game:loc("enemy_remilia_dialogue_9_2")}
		self.remilia.text=Game:loc("enemy_remilia_turn_8")
		waves[1] = 'remilia/wave8'
	elseif Game.battle.turn_count==9 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_10")
		self.remilia.text=Game:loc("enemy_remilia_turn_9")
		waves[1] = 'remilia/wave9'
	else
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_11")
		self.remilia.text=Game:loc("enemy_remilia_turn_10")
		waves[1] = 'remilia/wave9'
	end
	return waves
end

function Remilia:onWavesDone()
	if Game.battle.turn_count >= 9 then
		Game.battle:startCutscene("remilia", "battle_end", self, self.remilia)
	else
		super.onWavesDone(self)
	end
end

return Remilia