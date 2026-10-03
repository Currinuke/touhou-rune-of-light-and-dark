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

		if kogasa and seija and koakuma and remilia and rin then
			-- start cutscene
		else
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

		cutscene:text("{world_rm_manor_topbattle_cutscene_2}", "afraid", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_3}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_4}", "afraid_talk", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_5}", "afraid_talk", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_6}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_7}", "upset", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_8}", {functions = {turn = function()
			cutscene:setSprite(remilia, "walk/left")
		end}})

		cutscene:text("{world_rm_manor_topbattle_cutscene_9}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_10}", "afraid_talk", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_11}")

		Game.world.music:play("gallery")
		cutscene:setAnimation(koakuma, "scared")
		cutscene:text("{world_rm_manor_topbattle_cutscene_12}", "afraid_talk", "koakuma")

		cutscene:walkTo(kogasa, cx - 180, cy - 80, 1.5, "right")
		cutscene:walkTo(seija, cx - 200, cy - 20, 1.5, "right")
		cutscene:walkTo(rin, cx - 220, cy + 40, 1.5, "right")
		cutscene:wait(1)

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
		-- cutscene:setSprite(rin, "walk/right")
		cutscene:text("{world_rm_manor_topbattle_cutscene_18}", "angry", "rin")
		cutscene:text("{world_rm_manor_topbattle_cutscene_19}")
		
		cutscene:wait(0.5)
		cutscene:setSprite(seija, "battle/attackready")
		cutscene:text("{world_rm_manor_topbattle_cutscene_20}", "bangs/smile", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_21}", "bangs/smile", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_22}", "bangs/smile_mad", "seija")
		cutscene:playSound("laz_c", nil, 0.9)
		seija:setAnimation({"battle/attack", 1/15, false, duration = 1.5, next = "walk/right"})

		cutscene:wait(cutscene:walkTo(koakuma, koakuma.x - 480, koakuma.y, 1))
		seija:resetSprite()
		cutscene:text("{world_rm_manor_topbattle_cutscene_23}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_24}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_25}")

		Game.world.music:play("none")
		cutscene:wait(cutscene:setAnimation(remilia, "battle/intro"))
		cutscene:wait(cutscene:playSound("bolt"))
		cutscene:text("{world_rm_manor_topbattle_cutscene_26}", "bangs/laugh")
		remilia.sprite.alpha = 0
		cutscene:startEncounter("remilia", false, remilia, {on_start = function ()
			-- remilia:remove()
		end})
		-- remilia.sprite.alpha = 1 -- visible

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

		cutscene:alignFollowers()
		cutscene:attachFollowers()
		cutscene:attachCamera()
	end
}