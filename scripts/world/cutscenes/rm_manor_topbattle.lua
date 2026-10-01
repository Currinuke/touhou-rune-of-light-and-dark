return {
	before = function(cutscene, event)
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
		
		local x = event.x + event.width / 2 + 10
		local y = event.y + event.height * 0.75

		cutscene:setAnimation(koakuma, "poke")
		cutscene:detachCamera()
		cutscene:wait(cutscene:panToSpeed("camera", 6))
			
		cutscene:wait(cutscene:walkTo(koakuma, koakuma.x + 200, koakuma.y, 2))
		cutscene:walkTo(rin, x + 20, y + 12, 1, "up")
		cutscene:walkTo(seija, x - 40, y + 12, 1, "up")
		-- cutscene:wait(1.2)

		cutscene:text("{world_rm_manor_topbattle_cutscene_2}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_3}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_4}", "smile_right", "koakuma")
		cutscene:text("{world_rm_manor_topbattle_cutscene_5}", "smile_left")
		cutscene:text("{world_rm_manor_topbattle_cutscene_6}", "smile_right")
		cutscene:text("{world_rm_manor_topbattle_cutscene_7}", "neutral")
		cutscene:text("{world_rm_manor_topbattle_cutscene_8}")

		local cx, cy, data = cutscene:getMarker("camera")

		cutscene:detachFollowers()
		cutscene:walkTo(kogasa, cx - 180, cy - 60, 2, "right")
		cutscene:walkTo(seija, cx - 200, cy, 2, "right")
		cutscene:walkTo(rin, cx - 220, cy + 60, 2, "right")

		cutscene:text("{world_rm_manor_topbattle_cutscene_9}")
		cutscene:text("{world_rm_manor_topbattle_cutscene_10}", "spr_face_seija_alt_7", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_11}", "excited")

		Game.world.music:play("gallery")
		cutscene:text("{world_rm_manor_topbattle_cutscene_12}", "spr_face_seija_alt_10", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_13}", "spr_face_seija_alt_11", "seija")
		cutscene:text("{world_rm_manor_topbattle_cutscene_14}", "afraid")

		cutscene:walkTo(koakuma, koakuma.x - 960, koakuma.y, 2)
		cutscene:wait(0.5)
		cutscene:text("{world_rm_manor_topbattle_cutscene_15}", "explain")

		cutscene:text("{world_rm_manor_topbattle_cutscene_16}", "surprise_b", "seija")

		cutscene:wait(cutscene:walkTo(koakuma, remilia.x - 120, koakuma.y, 1))

		cutscene:text("{world_rm_manor_topbattle_cutscene_17}", "smile_left")
		cutscene:text("{world_rm_manor_topbattle_cutscene_18}", "smile_right")
		cutscene:text("{world_rm_manor_topbattle_cutscene_19}", "smile_right")
		cutscene:text("{world_rm_manor_topbattle_cutscene_20}", "smile", "seija")

		cutscene:text("{world_rm_manor_topbattle_cutscene_21}", "sad")

		cutscene:text("{world_rm_manor_topbattle_cutscene_22}", "sad")
		cutscene:text("{world_rm_manor_topbattle_cutscene_23}", "sad")
		cutscene:text("{world_rm_manor_topbattle_cutscene_24}", "sad")
		cutscene:text("{world_rm_manor_topbattle_cutscene_25}", "smile_b")

		Game.world.music:play("none")
		cutscene:wait(cutscene:setAnimation(remilia, "battle/intro"))
		cutscene:text("{world_rm_manor_topbattle_cutscene_26}", "smile_b")
		cutscene:startEncounter("remilia", true, remilia)

			cutscene:text("{world_rm_manor_topbattle_cutscene_27}", "neutral", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_28}", "neutral", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_29}", "neutral", "seija")

			cutscene:look(rin, "down")
			cutscene:wait(1)
			cutscene:look(rin, "left")

			cutscene:text("{world_rm_manor_topbattle_cutscene_30}", "suspicious")
			cutscene:text("{world_rm_manor_topbattle_cutscene_31}", "spr_face_seija_alt_9", "seija")
			cutscene:text("{world_rm_manor_topbattle_cutscene_32}", "smile_left", "koakuma")
			
			cutscene:look(rin, "down")
			cutscene:wait(1)
			cutscene:look(rin, "left")

			cutscene:text("{world_rm_manor_topbattle_cutscene_33}", "spr_face_rin_alt_fixed_20")

			cutscene:look(seija, "down")
			cutscene:wait(1)
			cutscene:look(seija, "right")

			cutscene:text("{world_rm_manor_topbattle_cutscene_34}", "spr_face_seija_alt_8", "seija")
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