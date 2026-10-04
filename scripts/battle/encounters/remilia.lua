local Remilia, super = Class(Encounter)

function Remilia:init()
	super.init(self)

	self.text = Game:loc("encounter_remilia_start")
	self.music = "kingboss"
	self.background = false
	self.remilia = self:addEnemy("remilia", 540, 220)
	self.remilia:setAnimation("battle/idle")
	self.no_end_message = true
	self:setFlag("meshield_used", nil)
	self:setFlag('pacifist', true)
end

function Remilia:onStateChange(old, new)
	if Game.battle.turn_count ~= 1 then
		if new == "ACTIONSELECT" then
			Game.battle.battle_ui.current_encounter_text = {text = self.remilia.text}
			Game.battle.battle_ui.encounter_text.text:setText(self.remilia.text)
		end
	end
end

function Remilia:onReturnToWorld(events)
	for _, enemy in ipairs(events) do
		enemy.sprite.alpha = 1
		for key, value in pairs(enemy) do
			-- Kristal.Console:push(tostring(key) .. ": " .. tostring(value))
		end
	end
end

function Remilia:getEncounterText()
	return Game:loc("enemy_remilia_turn_" .. tostring(MathUtils.clamp(Game.battle.turn_count - 1, 1, 11)))
end

function Remilia:getNextWaves()
	local waves = super.getNextWaves(self)
	--[[
	if Game.battle.turn_count == 1 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_2")
		--self.remilia.text = Game:loc("enemy_remilia_turn_1")
		--waves[1] = "remilia/wave1"
	elseif Game.battle.turn_count == 2 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_3")
		--self.remilia.text=Game:loc("enemy_remilia_turn_2")
		--waves[1] = "remilia/wave2"
	elseif Game.battle.turn_count == 3 then
		self.remilia.dialogue_override = Game:loc("enemy_remilia_dialogue_4")
		---self.remilia.text = Game:loc("enemy_remilia_turn_3")
		--waves[1] = "remilia/wave3"
	elseif Game.battle.turn_count == 4 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_5")
		--self.remilia.text=Game:loc("enemy_remilia_turn_4")
		--waves[1] = 'remilia/wave4'
	elseif Game.battle.turn_count==5 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_6")
		--self.remilia.text=Game:loc("enemy_remilia_turn_5")
		--waves[1] = 'remilia/wave5'
	elseif Game.battle.turn_count==6 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_7")
		--self.remilia.text=Game:loc("enemy_remilia_turn_6")
		--waves[1] = 'remilia/wave6'
	elseif Game.battle.turn_count==7 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_8")
		--self.remilia.text=Game:loc("enemy_remilia_turn_7")
		--waves[1] = 'remilia/wave7'
	elseif Game.battle.turn_count==8 then
		self.remilia.dialogue_override={Game:loc("enemy_remilia_dialogue_9_1"),Game:loc("enemy_remilia_dialogue_9_2")}
		--self.remilia.text=Game:loc("enemy_remilia_turn_8")
		--waves[1] = 'remilia/wave8'
	elseif Game.battle.turn_count==9 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_10")
		--self.remilia.text=Game:loc("enemy_remilia_turn_9")
		--waves[1] = 'remilia/wave9'
	elseif Game.battle.turn_count==10 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_11")
		--self.remilia.text=Game:loc("enemy_remilia_turn_10")
		--waves[1] = 'remilia/wave10'
	elseif Game.battle.turn_count==11 then
		self.remilia.dialogue_override=Game:loc("enemy_remilia_dialogue_12")
		--self.remilia.text=Game:loc("enemy_remilia_turn_11")
		--waves[1] = 'remilia/wave11'
	elseif Game.battle.turn_count==12 then
		--waves[1] = 'remilia/wave12'
		self.remilia.text=''
	end]]
	return waves
end

function Remilia:getPartyPosition(index)
	-- 这一堆东西可以阻止角色位置改变
	-- 其实是让角色移动到原地罢了
	-- 也就是就地作战
	local battler = Game.battle.party[index]
	local chara = Game.world:getCharacter(battler.chara.id)
	local cx, cy = Game.world.camera:getPosition()
	local x, y = chara.x - cx + 320, chara.y - cy + 240
    -- local ox, oy = battler.chara:getBattleOffset()
    -- x = x + (battler.actor:getWidth() / 2 + ox) * 2
    -- y = y + (battler.actor:getHeight() + oy) * 2
	-- x, y = x + ox, y + oy
	return x, y
end

function Remilia:beforeStateChange(old, new, reason)
	if Game.battle.turn_count >= 13 and new == "ACTIONSELECT" then
		Game.battle:setState("VICTORY")
	end
end

function Remilia:onStateChange(old, new, reason)
	if Game.battle.turn_count ~= 1 then
		if new == "ACTIONSELECT" then
			Game.battle.battle_ui.current_encounter_text = {text = self.remilia.text}
			Game.battle.battle_ui.encounter_text.text:setText(self.remilia.text)
		end
	end
	
	if self.remilia.health <= 800 then
		self:setFlag('pacifist', false)
	end

	if Game.battle.turn_count >= 13 and new == "ACTIONSELECT" then
		Game.battle.battle_ui.current_encounter_text = ""
		Game.battle.battle_ui.encounter_text.text:setText("")


		-- Game.battle:setState("VICTORY")
	end
end

return Remilia