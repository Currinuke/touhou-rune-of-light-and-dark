return {
	encounter = function(cutscene, event)
		-- Kristal.Console:push("event: " .. tostring(event:getFlag("used_once", false)))
		-- Kristal.Console:push("cutscene: " .. tostring(event:getFlag("used_once", false)))

		if Game:getFlag("encounter#remilia:done", false) then
			return
		end

		local kogasa = Game.world.player
		local seija = cutscene:getCharacter("seija")
		local rin = cutscene:getCharacter("rin")
		local koakuma = cutscene:getCharacter("koakuma")
		local remilia = cutscene:getCharacter("remilia")

		if not (kogasa and seija and koakuma and remilia and rin) then
			return
		end

		cutscene:look(kogasa, "right")
		cutscene:look(seija, "right")
		cutscene:look(rin, "right")

		cutscene:setSpeaker(remilia)
		cutscene:text("{world_rm_manor_topbattle_cutscene_1}", "smile", "rin")

		cutscene:setAnimation(koakuma, "poke")
		cutscene:detachCamera()
		cutscene:wait(cutscene:panTo("camera", 2))
		cutscene:wait(0.5)
		local cx, cy, data = cutscene:getMarker("camera")
		cutscene:detachFollowers()
		cutscene:walkTo(kogasa, cx - 360, cy - 20, 0.5, "right")
		cutscene:walkTo(seija, cx - 360, cy, 0.5, "right")
		cutscene:walkTo(rin, cx - 360, cy + 20, 0.5, "right")
		cutscene:wait(cutscene:walkTo(koakuma, koakuma.x + 240, koakuma.y, 2))

		local tx, ty = koakuma.x, koakuma.y

		local stepback = function()
			tx, ty = tx - 10, ty
			cutscene:walkTo(koakuma, tx, ty, 0.25)
		end

		local stepforward = function()
			tx, ty = tx + 15, ty
			cutscene:walkTo(koakuma, tx, ty, 0.25)
		end

		-- 这一段是为了控制“是否跳过入场前对话”
		-- 但是，判定方式很奇怪
		local skipping = Game.skip_dialogue[Game.world.map.id] or false
		Game.skip_dialogue[Game.world.map.id] = true

		if not skipping then

			cutscene:text("{world_rm_manor_topbattle_cutscene_2}", "afraid", "koakuma")
			cutscene:text("{world_rm_manor_topbattle_cutscene_3}", {functions = {stepback = stepback}})
			cutscene:text("{world_rm_manor_topbattle_cutscene_4}", "afraid_talk", "koakuma")
			cutscene:text("{world_rm_manor_topbattle_cutscene_5}", "afraid_talk", "koakuma")
			cutscene:text("{world_rm_manor_topbattle_cutscene_6}")
			cutscene:text("{world_rm_manor_topbattle_cutscene_7}", "upset", "koakuma")
			cutscene:text("{world_rm_manor_topbattle_cutscene_8}", {functions = {turn = function()
				cutscene:look(remilia, "left")
			end, stepback = stepback}})

			cutscene:text("{world_rm_manor_topbattle_cutscene_9}", {functions = {stepback = stepback}})
			cutscene:text("{world_rm_manor_topbattle_cutscene_10}", "afraid_talk", "koakuma", {functions = {stepback = stepback, stepforward = stepforward}})
			cutscene:text("{world_rm_manor_topbattle_cutscene_11}", {functions = {stepback = stepback}})

			local bats = {}
			for i = 0, 7 do
				local sin, cos = math.sin(math.pi * i / 4), math.cos(math.pi * i / 4)
				local x, y = koakuma.x - 20, koakuma.y - 20
				local bat = RemiliaBat(x + 320 * sin, y + 320 * cos, x + 80 * sin, y + 80 * cos, 0.6)
				Game.world:addChild(bat)
				table.insert(bats, bat)
			end

			Game.world.music:play("gallery")
			cutscene:setAnimation(koakuma, "scared")
			cutscene:text("{world_rm_manor_topbattle_cutscene_12}", "afraid_talk", "koakuma")

			cutscene:walkTo(kogasa, cx - 180, cy - 80, 1.5, "right")
			cutscene:walkTo(seija, cx - 200, cy - 20, 1.5, "right")
			cutscene:walkTo(rin, cx - 220, cy + 40, 1.5, "right")
			cutscene:wait(1.5)

			cutscene:text("{world_rm_manor_topbattle_cutscene_13}", "bangs/smile", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_14}", "bangs/smile", "seija")

			cutscene:wait(1)

			cutscene:text("{world_rm_manor_topbattle_cutscene_15}")
			cutscene:text("{world_rm_manor_topbattle_cutscene_16}", {functions = {hurt = function()
				cutscene:setSprite(rin, "battle/hurt")
				cutscene:shakeCharacter(rin, 4, 0, 2)
			end}})

			cutscene:text("{world_rm_manor_topbattle_cutscene_17}", "surprise", "rin")
			rin:resetSprite()
			cutscene:look(rin, "right")
			cutscene:text("{world_rm_manor_topbattle_cutscene_18}", "angry", "rin")
			cutscene:text("{world_rm_manor_topbattle_cutscene_19}")

			cutscene:wait(0.5)
			Assets.playSound("weaponpull_fast", 0.8)
			cutscene:setSprite(seija, "battle/attackready")
			cutscene:text("{world_rm_manor_topbattle_cutscene_20}", "bangs/smile", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_21}", "bangs/smile", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_22}", "bangs/smile_mad", "seija")
			cutscene:playSound("laz_c", nil, 0.9)
			cutscene:wait(cutscene:setAnimation(seija, "battle/attack"))
			local bomb = SeijaBomb(seija.x + 20, seija.y - 20, remilia.x - 100, remilia.y - 10)
			Game.world:addChild(bomb)

			for i = -1, 1 do
				for j = -1, 1 do
					local x, y = remilia.x - 60, remilia.y - 20
					local ox, oy = i, j
					if i == 0 and j == 0 then
						ox = 1
					end
					local bat = RemiliaBat(x + 640 * ox, y + 640 * oy, x + 30 * i, y + 40 * j + i * 20, 0.8)
					Game.world:addChild(bat)
					table.insert(bats, bat)
				end
			end

			cutscene:wait(2.4)
			Assets.playSound("defeatrun")
			bomb:remove()
			cutscene:wait(cutscene:walkTo(koakuma, koakuma.x - 480, koakuma.y, 1))
			
			for _, bat in pairs(bats) do
				bat:remove()
			end

			seija:resetSprite()
			cutscene:wait(0.5)
			cutscene:look(remilia, "down")
			cutscene:wait(1)
			cutscene:look(remilia, "left")
			cutscene:wait(0.5)

			cutscene:text("{world_rm_manor_topbattle_cutscene_23}")
			cutscene:text("{world_rm_manor_topbattle_cutscene_24}")
			cutscene:text("{world_rm_manor_topbattle_cutscene_25}")

			Game.world.music:play("none")
			cutscene:setAnimation(remilia, "battle/intro")
			Game.stage.timer:after(21 / 15, function()
				Game.world:addChild(RemiliaBolt(remilia.x - 60, remilia.y))
				Game.world:addChild(RemiliaBolt(remilia.x + 60, remilia.y))
				cutscene:playSound("bolt")
			end)

			cutscene:wait(21 / 15)
			cutscene:wait(25 / 30)
			cutscene:text("{world_rm_manor_topbattle_cutscene_26}", "bangs/laugh")
		else

			stepback = HookSystem.override(stepback, function(orig) orig() cutscene:wait(0.5) end)
			stepforward = HookSystem.override(stepforward, function(orig) orig() cutscene:wait(1) end)

			cutscene:wait(1)
			stepback()
			cutscene:look(remilia, "left")
			cutscene:wait(4 / 30)
			stepback()

			stepback()
			stepback()
			stepforward()
			stepforward()
			stepforward()
			stepback()

			local bats = {}
			for i = 0, 7 do
				local sin, cos = math.sin(math.pi * i / 4), math.cos(math.pi * i / 4)
				local x, y = koakuma.x - 20, koakuma.y - 20
				local bat = RemiliaBat(x + 320 * sin, y + 320 * cos, x + 80 * sin, y + 80 * cos, 0.6)
				Game.world:addChild(bat)
				table.insert(bats, bat)
			end

			Game.world.music:play("gallery")
			cutscene:setAnimation(koakuma, "scared")

			cutscene:walkTo(kogasa, cx - 180, cy - 80, 1.5, "right")
			cutscene:walkTo(seija, cx - 200, cy - 20, 1.5, "right")
			cutscene:walkTo(rin, cx - 220, cy + 40, 1.5, "right")
			cutscene:wait(1.5)

			cutscene:wait(1)

			cutscene:setSprite(rin, "battle/hurt")
			cutscene:shakeCharacter(rin, 4, 0, 2)
			cutscene:wait(1)

			rin:resetSprite()
			cutscene:look(rin, "right")

			cutscene:wait(0.5)
			Assets.playSound("weaponpull_fast", 0.8)
			cutscene:setSprite(seija, "battle/attackready")
			cutscene:wait(1)
			cutscene:playSound("laz_c", nil, 0.9)
			cutsceme:wait(cutscene:setAnimation(seija, "battle/attack"))
			local bomb = SeijaBomb(seija.x + 20, seija.y - 20, remilia.x - 100, remilia.y - 10)
			Game.world:addChild(bomb)

			for i = -1, 1 do
				for j = -1, 1 do
					local x, y = remilia.x - 60, remilia.y - 20
					local ox, oy = i, j
					if i == 0 and j == 0 then
						ox = 1
					end
					local bat = RemiliaBat(x + 640 * ox, y + 640 * oy, x + 30 * i, y + 40 * j + i * 20, 0.8)
					Game.world:addChild(bat)
					table.insert(bats, bat)
				end
			end

			cutscene:wait(2.4)
			Assets.playSound("defeatrun")
			bomb:remove()
			cutscene:wait(cutscene:walkTo(koakuma, koakuma.x - 480, koakuma.y, 1))

			for _, bat in pairs(bats) do
				bat:remove()
			end

			seija:resetSprite()
			cutscene:wait(0.5)
			cutscene:look(remilia, "down")
			cutscene:wait(1)
			cutscene:look(remilia, "left")
			cutscene:wait(0.5)

			Game.world.music:play("none")
			cutscene:setAnimation(remilia, "battle/intro")
			Game.stage.timer:after(21 / 15, function()
				Game.world:addChild(RemiliaBolt(remilia.x - 60, remilia.y))
				Game.world:addChild(RemiliaBolt(remilia.x + 60, remilia.y))
				cutscene:playSound("bolt")
			end)

			cutscene:wait(21 / 15)
			cutscene:wait(25 / 30)
		end
		remilia.sprite.visible = false
		cutscene:startEncounter("remilia", false, remilia)

		cutscene:text("{world_rm_manor_topbattle_cutscene_27}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_28}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_29}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_30}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_31}", "bangs/neutral_narrow", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_32}", "smile_left", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_33}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_34}", "bangs/smile_narrow", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_35}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_36}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_37}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_38}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_39}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_40}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_41}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_42}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_43}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_44}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_45}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_46}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_47}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_48}", "excited", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_49}", "excited_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_50}", "mad", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_51}", "surprise", "rin")
		cutscene:text("{world_rm_manor_topbattle_cutscene_52}", "excited_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_53}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_54}", "excited_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_55}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_56}", "excited_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_57}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_58}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_59}", "excited_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_60}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_61}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_62}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_63}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_64}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_65}", "bangs/neutral", "seija")
		
		cutscene:setSpeaker()
		cutscene:text("{world_rm_manor_topbattle_cutscene_66}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_67}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_68}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_69}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_70}")

		cutscene:text("{world_rm_manor_topbattle_cutscene_71}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_72}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_73}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_74}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_75}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_76}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_77}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_78}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_79}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_80}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_81}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_82}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_83}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_84}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_85}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_86}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_87}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_88}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_89}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_90}", "bangs/neutral", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_91}", "bangs/neutral", "seija")

		-- Game.skip_dialogue[Game.world.map.id] = false
		cutscene:alignFollowers()
		cutscene:attachFollowers()
		cutscene:attachCamera()
	end
}