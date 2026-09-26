return {
	heal = function(cutscene, encounter, enemy)
		Assets.playSound("spellcast")
		Assets.playSound("magicsprinkle")

		cutscene:battlerText("rin", "{battle_rumia_heal_1}", {wait = false, auto = true, right = true})
		cutscene:setSprite("rin", "battle/hurt")
		cutscene:shakeCharacter("rin", 4, 0, 2)
		enemy:setAnimation("hurt")
		local darkeffectcount = 0
		Game.battle.timer:every(0.1, function()
			darkeffectcount = darkeffectcount + 1
			local randomangle = math.rad(MathUtils.random(0,360))
			local darkeffect = Game.battle:addChild(darkeffect(enemy.x - 150 + 80 * math.cos(randomangle), enemy.y - 120 + 80 * math.sin(randomangle)))
			darkeffect.alpha = 0
			Game.battle.timer:tween(1, darkeffect, {x = enemy.x - 150, y = enemy.y - 120, alpha = 1}, nil, function()
				Game.battle.timer:tween(0.5, darkeffect, {alpha = 0}, nil, function()
					darkeffect:remove()
				end)
			end)
			if darkeffectcount == 8 then
				return false
			end
		end)
		Game.battle.timer:after(2.5, function()
			enemy:heal(enemy.max_health - enemy.health)
			Game.battle.timer:after(0.5, function()
				enemy:setAnimation("battle/idle")
				enemy:shake(6,0,3)
			end)
		end)
		cutscene:text("{battle_rumia_heal_text_1}", nil, nil, {skip = false, auto = true})
		cutscene:text("{battle_rumia_heal_text_2}")
		cutscene:battlerText("rin", "{battle_rumia_heal_2}", {right = true})
		cutscene:battlerText("seija", "{battle_rumia_heal_3}", {right = true})
		cutscene:battlerText("seija", "{battle_rumia_heal_4}", {right = true})

		enemy.attack = enemy.attack + 1
		enemy.wave_override = "empty_wave"
	end,

	act_wind = function(cutscene, battler, enemy)
		cutscene:text("* Kogasa orders Rin to create\na strong wind.")
		cutscene:text("* Press [bind:confirm] to summon!")

		enemy:setTired(true)
		enemy:addMercy(50)
		enemy:addMercy(40)
	end
}