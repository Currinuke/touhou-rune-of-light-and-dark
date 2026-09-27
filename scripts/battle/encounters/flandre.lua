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

function Flandre:onBattleInit()
	self.tired_points = 0
	self.spin_effect = false
	self.turn_effect = 0
	self.turn_effects = {}
	self.enemy_data = {
		["attack"] = Game.battle.enemies[1].attack,
		["defense"] = Game.battle.enemies[1].defense
	}
	self.member_data = {}
	for _, member in ipairs(Game.battle.party) do
		self.member_data[member.chara.id] = {}
		local spells = member.chara:getSpells()
		for index, spell in ipairs(spells) do
			self.member_data[member.chara.id][index] = spell:getTPCost(member.chara)
		end
	end
end

function Flandre:onTurnEnd()
	self.tired_points = self.tired_points + 1

	if self.spin_effect then
		-- 回退行动效果
		local turn = self.turn_effect
		local enemies = Game.battle.enemies
		self.turn_effects[turn] = self.turn_effects[turn] or 0
		local effects = self.turn_effects[turn] or 0

		if turn == 1 then
			if effects == 2 then
				for _, enemy in ipairs(enemies) do
					enemy.attack = self.enemy_data["attack"]
				end
				self.turn_effects[1] = 1
			end
		elseif turn == 7 then
		elseif turn == 8 then
			for _, enemy in ipairs(enemies) do
				enemy.attack = self.enemy_data["attack"]
			end
			self.turn_effects[8] = 0
		end
		self.spin_effect = false
	end
end

function Flandre:onActionsEnd()
	local enemies = Game.battle.enemies

	for turn, effect in ipairs(self.turn_effects) do
		-- 上回合遗留的效果
		if turn == 1 then
			if effect == 1 then
				for _, enemy in ipairs(enemies) do
					enemy.defense = self.enemy_data["defense"]
				end
				self.turn_effects[1] = 0
			end
		end
	end

	if self.spin_effect then
		-- 使用行动效果
		local turn = self.turn_effect

		if turn == 1 then
			self.turn_effects[1] = 2
		elseif turn == 3 then
			self.turn_effects[3] = (self.turn_effects[3] or 0) + 1
		elseif turn == 7 then
			self.turn_effects[7] = (self.turn_effects[7] or 0) + 1
		elseif turn == 8 then
			self.turn_effects[8] = 1
		end
	end
end

function Flandre:createSoul(x, y, color)
	return DoubleSoul(x, y, color)
end

return Flandre