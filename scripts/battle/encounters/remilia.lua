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
		enemy.sprite.visible = true
	end
end

function Remilia:getEncounterText()
	return Game:loc("enemy_remilia_turn_" .. tostring(MathUtils.clamp(Game.battle.turn_count - 1, 1, 11)))
end

function Remilia:getPartyPosition(index)
	-- 这一堆东西可以阻止角色位置改变
	-- 其实是让角色移动到原地罢了
	-- 也就是就地作战
	-- 注：建议搭配取消战前入场使用，免得小伞原地快跑
	return Game.battle.party[index]:getScreenPos()
end
--[[
function Remilia:beforeStateChange(old, new, reason)
	if Game.battle.turn_count >= 13 and new == "ACTIONSELECT" then
		-- Game.battle:setState("VICTORY")"TRANSITIONOUT"
		-- Game.battle:setState("TRANSITIONOUT")
	end
end--]]

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