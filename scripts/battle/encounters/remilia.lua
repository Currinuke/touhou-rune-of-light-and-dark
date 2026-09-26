local Remilia, super = Class(Encounter)

function Remilia:init()
    super.init(self)

    self.text = Game:loc("encounter_remilia_start")
    self.music = "kingboss"
    self.background = false

    self:addEnemy("remilia"):setAnimation("battle/intro")
    
    self.no_end_message = true
end


function Remilia:onMenuSelect(state_reason, item, can_select)
    if state_reason == "ACT" then
        if item.name == "W.F.[D.F.]" then
            -- Assets.playSound("ui_select")
            Game.battle:setState("PARTYSELECT", "SPELL")
            return false
        end
    end
end

function Remilia:getNextWaves()
	local waves = super.getNextWaves(self)
	if Game.battle.turn_count == 1 then
		waves[1] = 'remilia/wave1'
	elseif Game.battle.turn_count == 2 then
		waves[1] = 'remilia/wave2'
	end
	return waves
end

--[[
function Remilia:onPartySelect(state_reason, party_index)
    
end

function Remilia:onPartyCancel(state_reason, party_index)

end--]]

return Remilia