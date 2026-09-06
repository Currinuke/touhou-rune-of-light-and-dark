return {
    bridge = function(cutscene, event)
        local kogasa = Game.world.player
        local seija = cutscene:getCharacter("seija")
        local koakuma = cutscene:getCharacter("koakuma")
        local rumia = cutscene:getCharacter("rumia")
        local rin = cutscene:getCharacter("rin")

        if kogasa and seija and koakuma and rumia then
            cutscene:setSpeaker("koakuma")
            cutscene:text("{world_rm_lake_bridge_cutscene_1}", "smile_left")
        
            local x = event.x + event.width / 2 + 10
            local y = event.y + event.height * 0.75
            local cx, cy, data = cutscene:getMarker("camera")

            cutscene:detachFollowers()
            cutscene:detachCamera()
            cutscene:walkTo(kogasa, x + 80, y + 12, 1, "up")
            cutscene:walkTo(seija, x + 20, y + 12, 1, "up")
            cutscene:walkTo(rin, x - 40, y + 12, 1, "up")
            cutscene:wait(1.2)

            cutscene:text("{world_rm_lake_bridge_cutscene_2}", "smile_right")
            cutscene:text("{world_rm_lake_bridge_cutscene_3}", "smile_left")
            cutscene:text("{world_rm_lake_bridge_cutscene_4}", "angry", "rin")
            cutscene:text("{world_rm_lake_bridge_cutscene_5}", "smile_left")
            cutscene:text("{world_rm_lake_bridge_cutscene_6}", "smile_right")
            cutscene:text("{world_rm_lake_bridge_cutscene_7}", "neutral")
            cutscene:text("{world_rm_lake_bridge_cutscene_8}", "spr_face_seija_alt_13", "seija")

            cutscene:walkTo(kogasa, x + 280, y - 20, 2, "right")
            cutscene:walkTo(seija, x + 220, y - 20, 2, "right")
            cutscene:walkTo(rin, x + 160, y - 20, 2, "right")
            cutscene:panToSpeed(cx, cy)
            cutscene:wait(4)

            cutscene:text("{world_rm_lake_bridge_cutscene_9}", "smile", "rin")
            cutscene:text("{world_rm_lake_bridge_cutscene_10}", "spr_face_seija_alt_7", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_11}", "excited")
            cutscene:text("{world_rm_lake_bridge_cutscene_12}", "spr_face_seija_alt_10", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_13}", "spr_face_seija_alt_11", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_14}", "afraid")

            local rx = rumia.x
            cutscene:walkTo(rumia, rx - 80, rumia.y, 1)
            cutscene:wait(3)
            cutscene:setAnimation(rumia, "attack")

            cutscene:text("{world_rm_lake_bridge_cutscene_15}", "explain")

            cutscene:startEncounter("rumia", true, rumia, {on_start = function()
                rumia:setFlag("dont_load", true)
                rumia:remove()
            end})
        
            cutscene:text("{world_rm_lake_bridge_cutscene_16}", "surprise_b", "seija")

            cutscene:wait(cutscene:walkTo(koakuma, rx - 120, koakuma.y, 1))
            cutscene:text("{world_rm_lake_bridge_cutscene_17}", "smile_left")
            cutscene:text("{world_rm_lake_bridge_cutscene_18}", "smile_right")
            cutscene:text("{world_rm_lake_bridge_cutscene_19}", "smile_right")
            cutscene:text("{world_rm_lake_bridge_cutscene_20}", "smile", "seija")

            cutscene:setSpeaker("rin")
            cutscene:text("{world_rm_lake_bridge_cutscene_21}", "sad")

            cutscene:look(kogasa, "left")
            cutscene:look(seija, "left")

            cutscene:text("{world_rm_lake_bridge_cutscene_22}", "sad")
            cutscene:text("{world_rm_lake_bridge_cutscene_23}", "sad")
            cutscene:text("{world_rm_lake_bridge_cutscene_24}", "sad")
            cutscene:text("{world_rm_lake_bridge_cutscene_25}", "smile_b")
            cutscene:text("{world_rm_lake_bridge_cutscene_26}", "smile_b")
            cutscene:text("{world_rm_lake_bridge_cutscene_27}", "neutral", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_28}", "neutral", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_29}", "neutral", "seija")

            cutscene:look(rin, "down")
            cutscene:wait(1)
            cutscene:look(rin, "right")

            cutscene:text("{world_rm_lake_bridge_cutscene_30}", "suspicious")
            cutscene:text("{world_rm_lake_bridge_cutscene_31}", "spr_face_seija_alt_9", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_32}", "smile_left", "koakuma")
            
            cutscene:look(rin, "down")
            cutscene:wait(1)
            cutscene:look(rin, "right")

            cutscene:text("{world_rm_lake_bridge_cutscene_33}", "spr_face_rin_alt_fixed_20")

            cutscene:look(seija, "down")
            cutscene:wait(1)
            cutscene:look(seija, "left")

            cutscene:text("{world_rm_lake_bridge_cutscene_34}", "spr_face_seija_alt_8", "seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_35}", "nervous")
            cutscene:text("{world_rm_lake_bridge_cutscene_36}", "suspicious")
            cutscene:text("{world_rm_lake_bridge_cutscene_37}", "suspicious")
            cutscene:text("{world_rm_lake_bridge_cutscene_38}", "suspicious")
            cutscene:text("{world_rm_lake_bridge_cutscene_39}", "sad")

            cutscene:look(seija, "down")
            cutscene:wait(1)
            cutscene:look(seija, "left")
            cutscene:setSpeaker("seija")
            cutscene:text("{world_rm_lake_bridge_cutscene_40}", "spr_face_seija_alt_2")
            cutscene:text("{world_rm_lake_bridge_cutscene_41}", "neutral")
            cutscene:text("{world_rm_lake_bridge_cutscene_42}", "smile")

            local seija_y = seija.y + 20
            cutscene:walkTo(seija, seija.x, seija.y + 20, 1, "up", true)
            cutscene:text("{world_rm_lake_bridge_cutscene_43}", "smile")

            cutscene:look(kogasa, "down")
            cutscene:wait(function() return seija_y == seija.y end)
            cutscene:wait(cutscene:walkTo(seija, seija.x + 400, seija.y, 1, "left"))
            cutscene:look(kogasa, "right")

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
            Assets.playSound("board_mantle_laugh_mid")
            cutscene:wait(2)
            koakuma:setFlag("dont_load", true)
            koakuma:remove()
            Game:removePartyMember("seija")
            Game:removeFollower("seija")
            seija:remove()

            cutscene:wait(cutscene:walkTo(rin, rx - 280, rin.y, 2, "left"))
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
    end
}
