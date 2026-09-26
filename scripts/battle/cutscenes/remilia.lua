return {
	kogasa_talk = function(cutscene, battler, enemy)
		cutscene:text("{battle_remilia_kogasa_talk_attempt}")

		battler:setAnimation("battle/act_end")

		cutscene:text("{battle_remilia_kogasa_talk_1}", "neutral", "kogasa")
		cutscene:text("{battle_remilia_kogasa_talk_2}", "bangs/neutral", "remilia")
		cutscene:text("{battle_remilia_kogasa_talk_3}", "bangs/laugh", "remilia")
		cutscene:text("{battle_remilia_kogasa_talk_4}", "bangs/sad", "kogasa")
		cutscene:text("{battle_remilia_kogasa_talk_5}", "sad", "rin")
		cutscene:text("{battle_remilia_kogasa_talk_6}", "bangs/sad_cry", "kogasa")
		cutscene:text("{battle_remilia_kogasa_talk_change}")
	end,
	seija_talk = function(cutscene, battler, enemy)
		cutscene:text("{battle_remilia_seija_talk_attempt}")

		battler:setAnimation("battle/act_end")
		local action = Game.battle:getCurrentAction()
		if action.party then
			for _, party_id in ipairs(action.party) do
				Game.battle:getPartyBattler(party_id):setAnimation("battle/act_end")
			end
		end

		cutscene:setAnimation("seija", "battle/act_end")
		cutscene:text("{battle_remilia_seija_talk_1}", "neutral", "kogasa")
		cutscene:text("{battle_remilia_seija_talk_2}", "bangs/neutral", "remilia")
		cutscene:text("{battle_remilia_seija_talk_3}", "bangs/laugh", "remilia")
		cutscene:text("{battle_remilia_seija_talk_4}", "sad", "rin")
		cutscene:text("{battle_remilia_seija_talk_5}", "bangs/sad_cry", "kogasa")
		cutscene:text("{battle_remilia_seija_talk_change}")
	end,
	rin_talk = function(cutscene, battler, enemy)
		cutscene:text("{battle_remilia_rin_talk_attempt}")

		battler:setAnimation("battle/act_end")
		local action = Game.battle:getCurrentAction()
		if action.party then
			for _, party_id in ipairs(action.party) do
				Game.battle:getPartyBattler(party_id):setAnimation("battle/act_end")
			end
		end

		cutscene:text("{battle_remilia_rin_talk_1}", "neutral", "kogasa")
		cutscene:text("{battle_remilia_rin_talk_2}", "bangs/neutral", "remilia")
		cutscene:text("{battle_remilia_rin_talk_3}", "bangs/laugh", "remilia")
		cutscene:text("{battle_remilia_rin_talk_4}", "bangs/sad", "kogasa")
		cutscene:text("{battle_remilia_rin_talk_5}", "sad", "rin")
		cutscene:text("{battle_remilia_rin_talk_6}", "bangs/sad_cry", "kogasa")
		cutscene:text("{battle_remilia_rin_talk_change}")
	end
}