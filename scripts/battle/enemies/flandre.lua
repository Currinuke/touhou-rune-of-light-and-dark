local Flandre, super = Class(EnemyBattler)

function Flandre:init()
	super.init(self)

	self:applyLocalization()
	self:setActor("flandre_a")

	self.max_health = 3000
	self.health = 3000
	self.attack = 12
	self.defense = 5
	self.money = 0

	self.spare_points = 0
	self.disable_mercy = true
	self.waves = {}

	self.tired_percentage = 0
	self.low_health_percentage = 0.15

	self:registerAct(self.act_umbrella_spin, Game:loc("act_flandre_umbrella_spin_description"), nil, 20)
	self:registerAct(self.act_group_hypnosis, Game:loc("act_flandre_group_hypnosis_description"), {"seija", "rin"})
end

function Flandre:applyLocalization(update_acts)
	local old_check = self.act_check
	local old_umbrella_spin = self.act_umbrella_spin
	local old_group_hypnosis = self.act_group_hypnosis

	self.name = Game:locText("[name:flandre_scarlet]")
	self.dialogue = {}
	self.check = Game:loc("enemy_flandreA_check")

	self.text = {
		Game:loc("enemy_flandre_turn_1"),
		Game:loc("enemy_flandre_turn_2"),
		Game:loc("enemy_flandre_turn_3")
	}

	self.low_health_text = Game:loc("enemy_flandre_low_health")

	self.act_check = Game:loc("act_check")
	self.act_umbrella_spin = Game:loc("act_flandre_umbrella_spin")
	self.act_group_hypnosis = Game:loc("act_flandre_group_hypnosis")

	if self.acts and self.acts[1] then
		self.acts[1].name = self.act_check
	end

	if update_acts then
		for _, act in ipairs(self.acts or {}) do
			if act.name == old_check then
				act.name = self.act_check
			elseif act.name == old_umbrella_spin then
				act.name = self.act_umbrella_spin
			elseif act.name == old_group_hypnosis then
				act.name = self.act_group_hypnosis
			end
		end
	end
end

function Flandre:getGrazeTension()
	if self.encounter.spin_effect then
		if self.encounter.turn_effect == 8 then
			return self.graze_tension * 2
		end
	end
    return self.graze_tension
end

function Flandre:onActStart(battler, name)
	if name == self.act_umbrella_spin then
		battler:setAnimation("battle/pirouette")
	else
		super.onActStart(self, battler, name)
	end
end

function Flandre:onAct(battler, name)
	if name == self.act_check then
		return super.onAct(self, battler, "Check")
	elseif name == self.act_umbrella_spin then
		self.encounter.spin_effect = true
		Game.battle:startActCutscene("flandre", "umbrella_spin")
		return
	elseif name == self.act_group_hypnosis then
		Assets.playSound("hypnosis")
		self.encounter.tired_points = self.encounter.tired_points + 5
		return Game:loc("act_flandre_group_hypnosis_text")
	end

	return super.onAct(self, battler, name)
end

function Flandre:onTurnStart()
	local turn = MathUtils.clamp(Game.battle.turn_count, 1, 7)

	if turn > 1 then
		turn = "final"
	end

	turn = 1
	self.wave_override = "flandre/flandre_" .. tostring(turn)
	-- self.defense = self.defense - 1
end

function Flandre:hurt(amount, battler, on_defeat, color, show_status, attacked)
	local damage = amount * (2 ^ (self.encounter.turn_effects[5] or 0))
	super.hurt(self, damage, battler, on_defeat, color, show_status, attacked)
end

function Flandre:onHurt(damage, battler)
	-- 同步血量
	for _, enemy in ipairs(Game.battle.enemies) do
		if enemy ~= self then
			enemy.health = enemy.health - damage
		end
	end

	super.onHurt(self, damage, battler)
end

return Flandre