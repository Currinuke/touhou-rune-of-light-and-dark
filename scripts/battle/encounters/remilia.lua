local Remilia, super = Class(Encounter)

function Remilia:init()
    super.init(self)

    self.text = "* The Scarlet Devil blocked your\nway!"
    self.music = "kingboss"
    self.background = false

    self:addEnemy("remilia")
    
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

--[[
function Remilia:onPartySelect(state_reason, party_index)
    
end

function Remilia:onPartyCancel(state_reason, party_index)

end--]]

return Remilia
