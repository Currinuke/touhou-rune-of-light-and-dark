local Rumia, super = Class(EnemyBattler)

function Rumia:init()
	super.init(self)

	self:applyLocalization()

	self:setActor("rumia")
	self:setAnimation("battle/idle", 1/10, true)

	self.max_health = 320
	self.health = 320

	self.attack = 9
	self.defense = 2
	self.money = 0

	self.spare_points = 0

	self.waves = {
		'rumia/wave1',
		'rumia/wave2'
	}

	self.dialogue_offset = {45, 35}

	-- self.exit_on_defeat = false
	self.tired_percentage = -math.huge
	self.low_health_percentage = 0

	self:registerAct(self.act_scare_ya, Game:loc("act_rumia_scare_ya_description"), nil, 32)
	self:registerAct(self.act_strong_wind, Game:loc("act_rumia_strong_wind_description"), {"rin"}, 50)
	self:registerAct(self.act_seijas_idea, Game:loc("act_rumia_seijas_idea_description"), {"seija", "rin"}, 102)
end

function Rumia:applyLocalization(update_acts)
	local old_check = self.act_check
	local old_scare_ya = self.act_scare_ya
	local old_strong_wind = self.act_strong_wind
	local old_seijas_idea = self.act_seijas_idea

	self.name = Game:locText("[name:rumia]")
	self.dialogue = {
		Game:loc("enemy_rumia_dialogue")
	}

	self.check = {
		Game:loc("enemy_rumia_check_1"),
		Game:loc("enemy_rumia_check_2")
	}

	self.text = {
		Game:loc("enemy_rumia_turn_1"),
		Game:loc("enemy_rumia_turn_2", {mercy = self:getMercyDisplay()}),
		Game:loc("enemy_rumia_turn_3"),
	}

	self.act_check = Game:loc("act_check")
	self.act_scare_ya = Game:loc("act_rumia_scare_ya")
	self.act_strong_wind = Game:loc("act_rumia_strong_wind")
	self.act_seijas_idea = Game:loc("act_rumia_seijas_idea")

	if self.acts and self.acts[1] then
		self.acts[1].name = self.act_check
	end

	if update_acts then
		for _, act in ipairs(self.acts or {}) do
			if act.name == old_check then
				act.name = self.act_check
			elseif act.name == old_scare_ya then
				act.name = self.act_scare_ya
			elseif act.name == old_strong_wind then
				act.name = self.act_strong_wind
			elseif act.name == old_seijas_idea then
				act.name = self.act_seijas_idea
			end
		end
	end
end

function Rumia:onAct(battler, name)
	if name == self.act_check then
		if self.checked then
			self.check = Game:loc("enemy_rumia_check_3")
		else
			self.checked = true
		end
		return super.onAct(self, battler, "Check")
	elseif name == self.act_scare_ya then
		self:addMercy(40)
		return Game:loc("act_rumia_scare_ya_text")
	elseif name == self.act_strong_wind then
		return Game.battle:startActCutscene("rumia", "act_wind")
	elseif name == self.act_seijas_idea then -- cheater's choice
		return error("Yeah i just wanna crash the battle :)")
	end

	return super.onAct(self, battler, name)
end

--[[
function Rumia:onHurt(damage, battler)
	self:toggleOverlay(true)
	if not self:getActiveSprite():setAnimation("hurt") then
		self:toggleOverlay(false)
	end
	self:getActiveSprite():shake(9, 0, 0.5, 2 / 30)
end--]]


function Rumia:onTurnEnd()
	self.text[2] = Game:loc("enemy_rumia_turn_2", {mercy = self:getMercyDisplay()})
end

function Rumia:onDefeat(damage, battler)
	if self.exit_on_defeat then
		-- self:onDefeatRun(damage, battler)
	elseif self.sprite then
		-- self.sprite:setAnimation("defeat")
	end
end

return Rumia