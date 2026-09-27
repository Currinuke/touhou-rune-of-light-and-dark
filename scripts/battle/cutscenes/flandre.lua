return {
	umbrella_spin = function(cutscene, battler, enemy)
		Assets.playSound("pirouette")
		-- battler:setAnimation("battle/pirouette")
		enemy.encounter.tired_points = enemy.encounter.tired_points + 3

		cutscene:text("{act_flandre_umbrella_spin_text}")

		local turn = (Game.battle.turn_count + 8) % 9 + 1
		local party = Game.battle.party
		local enemies = Game.battle.enemies

		enemy.encounter.turn_effect = turn
		Assets.playSound("hypnosis")
		if turn == 1 then
			-- Turn1+9*X：芙兰本回合的攻击与防御降低50%
			for _, target in ipairs(enemies) do
				target.attack = math.floor(target.attack / 2)
				target.defense = math.floor(target.defense / 2)
			end
		elseif turn == 2 then
			-- Turn2+9*X：将多多良小伞的HP设为1,其他团队成员HP设为满
			for _, member in ipairs(party) do
        		member:flash()
				if member == battler then
					member.chara.health = 1
				else
					member.chara.health = member.chara:getStat("health")
				end
			end
		elseif turn == 3 then
			-- Turn3+9*X：本场战斗中芙兰的攻击间隔（？）与伤害降低33%且给予的无敌时间降低50%
			enemy.encounter.enemy_data["attack"] = enemy.encounter.enemy_data["attack"] * 2 / 3
			for _, target in ipairs(enemies) do
				target.attack = target.attack * 2 / 3
			end
		elseif turn == 4 then
			-- Turn4+9*X：召唤一朵雨云,随后立即被芙兰摧毁
		elseif turn == 5 then
			-- Turn5+9*X：本场战斗中芙兰受到的伤害翻倍,所有人的TP消耗翻倍（同回合行动、法术的TP消耗不变）
			enemy.encounter.turn_effects[5] = (enemy.encounter.turn_effects[5] or 0) + 1
			for _, member in ipairs(party) do
				local spells = member.chara:getSpells()
				for _, spell in pairs(spells) do
					spell.cost = spell:getTPCost(member.chara) * 2
				end
			end
		elseif turn == 6 then
			-- Turn6+9*X：治疗随机一位团队成员75HP
			party[math.random(1, #party)]:heal(75)
		elseif turn == 7 then
			-- Turn7+9*X：随机交换所有团队成员的最大生命值
		elseif turn == 8 then
			-- Turn8+9*X：芙兰本回合攻击伤害翻倍,给予的TP与无敌时间也翻倍
			for _, target in ipairs(enemies) do
				target.attack = target.attack * 2
			end
		elseif turn == 9 then
			-- Turn9+9*X：所有团队成员回复45HP
			for _, member in ipairs(party) do
				member:heal(45)
			end
		end

		cutscene:text("{act_flandre_umbrella_spin_" .. tostring(turn) .. "}")
	end
}