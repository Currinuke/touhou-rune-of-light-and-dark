local Remilia, super = Class(EnemyBattler)

function Remilia:init()
	super.init(self)

	self:applyLocalization()
	
	self:setActor("remilia")

	self.max_health = 3000
	self.health = 3000
	self.attack = 10
	self.defense = 0
	self.money = 0

	self.spare_points = 0
	self.disable_mercy = true

	self.waves = {}

	self.exit_on_defeat = true

	self.tired_percentage = 0
	self.low_health_percentage = 0.1

	self:registerIndexAct(self.act_talk, 2)
	self:registerIndexAct(self.act_seija_talk, 3, nil, {"seija"})
	self:registerIndexAct(self.act_rin_talk, 4, nil, {"rin"})
end

function Remilia:applyLocalization(update_acts)
	local old_check = self.act_check
	local old_talk = self.act_talk
	local old_seija_talk = self.act_seija_talk
	local old_rin_talk = self.act_rin_talk
	local old_me_shield = self.act_me_shield
	local old_scare_burster = self.act_scare_burster
	local old_data_falsifier = self.act_data_falsifier

	self.name = Game:locText("[name:remilia_scarlet]")

	self.dialogue = {
		Game:loc("enemy_remilia_dialogue_1")
	}

	self.check = {
		Game:loc("enemy_remilia_check_1"),
		Game:loc("enemy_remilia_check_2")
	}

	self.text = {
		Game:loc("enemy_remilia_turn_1"),
		Game:loc("enemy_remilia_turn_2"),
		Game:loc("enemy_remilia_turn_3"),
		Game:loc("enemy_remilia_turn_4"),
		Game:loc("enemy_remilia_turn_5"),
		Game:loc("enemy_remilia_turn_6")
	}

	self.low_health_text = Game:loc("enemy_remilia_low_health")

	self.act_check = Game:loc("act_check")
	self.act_talk = Game:loc("act_remilia_talk")
	self.act_seija_talk = Game:loc("act_remilia_seija_talk")
	self.act_rin_talk = Game:loc("act_remilia_rin_talk")
	self.act_me_shield = Game:loc("act_remilia_me_shield")
	self.act_scare_burster = Game:loc("act_remilia_scare_burster")
	self.act_data_falsifier = Game:loc("act_remildata_falsifierier")

	if self.acts and self.acts[1] then
		self.acts[1].name = self.act_check
	end

	if update_acts then
		for _, act in ipairs(self.acts or {}) do
			if act.name == old_check then
				act.name = self.act_check
			elseif act.name == old_talk then
				act.name = self.act_talk
			elseif act.name == old_seija_talk then
				act.name = self.act_seija_talk
            elseif act.name == old_rin_talk then
				act.name = self.act_rin_talk
			elseif act.name == old_me_shield then
				act.name = self.act_me_shield
			elseif act.name == old_scare_burster then
				act.name = self.act_scare_burster
			elseif act.name == old_data_falsifier then
				act.name = self.act_data_falsifier
			end
		end
	end
end

function Remilia:onAct(battler, name, index)
	if name == self.act_talk or name == self.act_seija_talk or name == self.act_rin_talk then
		if index == 2 then
			self:registerIndexAct(self.act_me_shield, 2, Game:loc("spell_me_shield_effect"), nil, 8)
			Game.battle:startActCutscene("remilia", "kogasa_talk")
		elseif index == 3 then
			self:registerIndexAct(self.act_scare_burster, 3, Game:loc("spell_scare_burster_effect"), {"seija"}, 60)
			Game.battle:startActCutscene("remilia", "seija_talk")
		elseif index == 4 then
			self:registerIndexAct(self.act_data_falsifier, 4, Game:loc("spell_wind_flower_data_falsifier_effect"), {"rin"}, 50)
			Game.battle:startActCutscene("remilia", "rin_talk")
		end
		return
	elseif name == self.act_me_shield then
		return Game.battle:powerAct("me_shield", battler, "kogasa", Game.battle.party)
	elseif name == self.act_scare_burster then
		return Game.battle:powerAct("scare_burster", battler, "seija", self)
	elseif name == self.act_data_falsifier then
		return Game.battle:powerAct("wind_flower_data_falsifier", battler, "rin", Game.battle.party)
	end

	return super.onAct(self, battler, name, index)
end

function Remilia:onTurnStart()
	local turn = MathUtils.clamp(Game.battle.turn_count, 1, 12)

	if turn > 1 then
		turn = 7
	end

	-- self.wave_override = "remilia_" .. tostring(turn)
	-- self.defense = self.defense - 1
end

return Remilia