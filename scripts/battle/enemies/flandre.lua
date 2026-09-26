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

	self:registerAct(self.act_umbrella_spin, Game:loc("act_flandre_umbrella_spin_description"))
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
		Game:loc("enemy_flandre_a_turn_1"),
		Game:loc("enemy_flandre_a_turn_2"),
		Game:loc("enemy_flandre_a_turn_3"),
		Game:loc("enemy_flandre_a_turn_4"),
		Game:loc("enemy_flandre_a_turn_5"),
		Game:loc("enemy_flandre_a_turn_6")
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
		Assets.playSound("pirouette")
		local function occur()
			local turn = Game.battle.turn_count
			if turn > 9 then
				turn = turn % 9
				if turn == 0 then
					turn = 9
				end
			end
			local party = Game.battle.party
			if turn == 1 then
				-- Turn1+9*X：芙兰本回合的攻击与防御降低50%
				self.attack = math.floor(self.attack / 2)
				self.defense = math.floor(self.defense / 2)
			elseif turn==2 then
				-- Turn2+9*X：将多多良小伞的HP设为1,其他团队成员HP设为满
				for _, member in ipairs(party) do
					if member == battler then
						member.chara.health = 1
					else
						member.chara.health = member.chara:getStat("health")
					end
				end
			elseif turn==3 then
				-- Turn3+9*X：本场战斗中芙兰的攻击间隔与伤害降低33%且给予的无敌时间降低50%
			elseif turn==4 then
				-- Turn4+9*X：召唤一朵雨云,随后立即被芙兰摧毁
			elseif turn==5 then
				-- Turn5+9*X：本场战斗中芙兰受到的伤害翻倍,所有人的TP消耗翻倍
			elseif turn==6 then
				-- Turn6+9*X：治疗随机一位团队成员75HP
				party[math.random(1, #party)]:heal(75)
			elseif turn==7 then
				-- Turn7+9*X：随机交换所有团队成员的最大生命值
			elseif turn==8 then
				-- Turn8+9*X：芙兰本回合攻击伤害翻倍,给予的TP与无敌时间也翻倍
				self.attack = self.attack * 2
			elseif turn==9 then
				-- Turn9+9*X：所有团队成员回复45HP
				for _, member in ipairs(party) do
					member:heal(45)
				end
			end
		end
		
		occur()
		return {
			Game:loc("act_flandre_umbrella_spin_text"),
			"[func:occur]Something occurred!"
		}
	elseif name == self.act_group_hypnosis then
		for _, enemy in ipairs(Game.battle.enemies) do
			-- enemy:setTired(true)
		end
		return Game:loc("act_flandre_group_hypnosis_text")
	end

	return super.onAct(self, battler, name)
end

function Flandre:onTurnStart()
	local turn = MathUtils.clamp(Game.battle.turn_count, 1, 7)

	if turn > 1 then
		turn = "final"
	end

	self.wave_override = "flandre/flandre_" .. tostring(turn)
	-- self.defense = self.defense - 1
end

function Flandre:onHurt(damage, battler)
	for _, enemy in ipairs(Game.battle.enemies) do
		if enemy ~= self then
			enemy.health = enemy.health - damage
		end
	end

	super.onHurt(self, damage, battler)
end

return Flandre