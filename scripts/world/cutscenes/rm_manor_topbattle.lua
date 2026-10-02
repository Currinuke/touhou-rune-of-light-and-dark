return {
	before = function(cutscene, event)
		-- event.TRIGGERED_ONCE = true

		if Game:getFlag("encounter#remilia:done", false) then
			return
		end

		local kogasa = Game.world.player
		local seija = cutscene:getCharacter("seija")
		local rin = cutscene:getCharacter("rin")
		local koakuma = cutscene:getCharacter("koakuma")
		local remilia = cutscene:getCharacter("remilia")

		cutscene:setSpeaker("remilia")
		cutscene:text("{world_rm_manor_topbattle_cutscene_1}", "angry", "rin")

		cutscene:setAnimation(koakuma, "poke")
		cutscene:detachCamera()
		cutscene:wait(cutscene:panToSpeed("camera", 6))

		cutscene:wait(cutscene:walkTo(koakuma, koakuma.x + 200, koakuma.y, 2))

		cutscene:text("{world_rm_manor_topbattle_cutscene_2}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_3}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_4}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_5}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_6}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_7}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_8}")

		remilia:setSprite("walk/left")
		-- cutscene:look(remilia, "left")
		local cx, cy, data = cutscene:getMarker("camera")

		cutscene:detachFollowers()
		cutscene:walkTo(kogasa, cx - 180, cy - 60, 2, "right")
		cutscene:walkTo(seija, cx - 200, cy, 2, "right")
		cutscene:walkTo(rin, cx - 220, cy + 60, 2, "right")

		cutscene:text("{world_rm_manor_topbattle_cutscene_9}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_10}", "bangs/spr_face_seija_alt_7", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_11}")

		Game.world.music:play("gallery")
		cutscene:text("{world_rm_manor_topbattle_cutscene_12}", "bangs/spr_face_seija_alt_10", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_13}", "bangs/spr_face_seija_alt_11", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_14}", "smile_right", "koakuma")

		cutscene:wait(1)

		cutscene:text("{world_rm_manor_topbattle_cutscene_15}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_16}")

		cutscene:wait(cutscene:walkTo(koakuma, koakuma.x - 480, koakuma.y, 3))

		cutscene:text("{world_rm_manor_topbattle_cutscene_17}", "smile_left", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_18}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_19}")
		
		cutscene:wait(0.5)
		cutscene:text("{world_rm_manor_topbattle_cutscene_20}", "bangs/smile", "seija")

		cutscene:text("{world_rm_manor_topbattle_cutscene_21}", "sad", "koakuma")

		cutscene:text("{world_rm_manor_topbattle_cutscene_22}", "sad", "koakuma")


		cutscene:text("{world_rm_manor_topbattle_cutscene_23}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_24}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_25}")

		Game.world.music:play("none")
		cutscene:wait(cutscene:setAnimation(remilia, "battle/intro"))
		cutscene:text("{world_rm_manor_topbattle_cutscene_26}", "bangs/laugh")
		cutscene:startEncounter("remilia", true, remilia, {on_start = function ()
			-- remilia:remove()
		end})




			cutscene:text("{world_rm_manor_topbattle_cutscene_27}", "bangs/neutral", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_28}", "bangs/neutral", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_29}", "bangs/neutral", "seija")

			cutscene:look(rin, "down")
			cutscene:wait(1)
			cutscene:look(rin, "left")

			cutscene:text("{world_rm_manor_topbattle_cutscene_30}", "suspicious")
			cutscene:text("{world_rm_manor_topbattle_cutscene_31}", "bangs/spr_face_seija_alt_9", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_32}", "smile_left", "koakuma")
			
			cutscene:look(rin, "down")
			cutscene:wait(1)
			cutscene:look(rin, "left")

			cutscene:text("{world_rm_manor_topbattle_cutscene_33}", "spr_face_rin_alt_fixed_20")

			cutscene:look(seija, "down")
			cutscene:wait(1)
			cutscene:look(seija, "right")

			cutscene:text("{world_rm_manor_topbattle_cutscene_34}", "bangs/spr_face_seija_alt_8", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_35}", "nervous")
			cutscene:text("{world_rm_manor_topbattle_cutscene_36}", "suspicious")
			cutscene:text("{world_rm_manor_topbattle_cutscene_37}", "suspicious")
			cutscene:text("{world_rm_manor_topbattle_cutscene_38}", "suspicious")
			cutscene:text("{world_rm_manor_topbattle_cutscene_39}", "sad")

			cutscene:look(seija, "down")
			cutscene:wait(1)
			cutscene:look(seija, "right")
			cutscene:setSpeaker("seija")
			cutscene:text("{world_rm_lake_bridge_cutscene_40}", "spr_face_seija_alt_2")
			cutscene:text("{world_rm_lake_bridge_cutscene_41}", "neutral")
			cutscene:text("{world_rm_lake_bridge_cutscene_42}", "smile")

			Game.world.timer:after(0.2, function()
				cutscene:look(rin, "down")
			end)
			local seija_y = seija.y + 20
			cutscene:walkTo(seija, seija.x, seija.y + 20, 1, "up", true)
			cutscene:text("{world_rm_lake_bridge_cutscene_43}", "smile")
			cutscene:wait(function() return seija_y == seija.y end)
			Game.world.timer:after(0.2, function()
				cutscene:look(rin, "right")
					cutscene:look(kogasa, "down")
				Game.world.timer:after(0.2, function()
					cutscene:look(kogasa, "right")
				end)
			end)
			cutscene:wait(cutscene:walkTo(seija, seija.x + 460, seija.y, 1.8, "left"))
			--cutscene:look(kogasa, "right")
			--cutscene:look(rin, "right")

			cutscene:text("{world_rm_lake_bridge_cutscene_44}", "spr_face_seija_alt_11")
			cutscene:text("{world_rm_lake_bridge_cutscene_45}", "spr_face_seija_alt_11")
			cutscene:text("{world_rm_lake_bridge_cutscene_46}", "spr_face_seija_alt_11")
			cutscene:text("{world_rm_lake_bridge_cutscene_47}", "spr_face_seija_alt_11")
			cutscene:text("{world_rm_lake_bridge_cutscene_48}", "excited", "koakuma")
			cutscene:text("{world_rm_lake_bridge_cutscene_49}", "excited_right", "koakuma")
			cutscene:text("{world_rm_lake_bridge_cutscene_50}", "spr_face_seija_alt_5")
			cutscene:text("{world_rm_lake_bridge_cutscene_51}", "surprise", "rin")
			cutscene:text("{world_rm_lake_bridge_cutscene_52}", "excited_right", "koakuma")
			cutscene:text("{world_rm_lake_bridge_cutscene_53}", "spr_face_seija_alt_5")
			cutscene:text("{world_rm_lake_bridge_cutscene_54}", "excited_right", "koakuma")
			cutscene:text("{world_rm_lake_bridge_cutscene_55}", "spr_face_seija_alt_5")
			cutscene:text("{world_rm_lake_bridge_cutscene_56}", "excited_right", "koakuma")
			cutscene:text("{world_rm_lake_bridge_cutscene_57}", "spr_face_seija_alt_8")
			cutscene:text("{world_rm_lake_bridge_cutscene_58}", "spr_face_seija_alt_11")
			cutscene:text("{world_rm_lake_bridge_cutscene_59}", "excited_right", "koakuma")

			cutscene:walkTo(koakuma, koakuma.x + 300, koakuma.y, 1)
			cutscene:walkTo(seija, seija.x + 300, seija.y, 1)
			cutscene:wait(2)
			koakuma:setFlag("dont_load", true)
			koakuma:remove()

			cutscene:wait(cutscene:walkTo(rin, remilia.x - 280, rin.y, 1.8, "left"))
			cutscene:setSpeaker("rin")
			cutscene:text("{world_rm_lake_bridge_cutscene_60}", "sad_cry")
			cutscene:text("{world_rm_lake_bridge_cutscene_61}", "fixed_20_cry")
			cutscene:text("{world_rm_lake_bridge_cutscene_62}", "sad_cry")
			cutscene:text("{world_rm_lake_bridge_cutscene_63}", "fixed_20_cry")
			cutscene:text("{world_rm_lake_bridge_cutscene_64}", "spr_face_rin_alt_fixed_24")
			cutscene:text("{world_rm_lake_bridge_cutscene_65}", "spr_face_rin_alt_fixed_23")
			cutscene:text("{world_rm_lake_bridge_cutscene_66}", "fixed_23_notear")

			cutscene:alignFollowers()
			cutscene:attachFollowers()
			cutscene:attachCamera(1.6)
	end
}