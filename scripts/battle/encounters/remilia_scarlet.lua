local RemiliaScarlet, super = Class(Encounter)

function RemiliaScarlet:init()
    super.init(self)

    self.text = "* The Scarlet Devil blocked your\nway!"
    self.music = "kingboss"
    self.background = false

    self:addEnemy("remilia_scarlet")
    
    self.no_end_message = true
end

--[[
function RemiliaScarlet:onMenuSelect(state_reason, item, can_select)
    if state_reason == "ACT" then
        if item.name == "W.F.[D.F.]" then
            Assets.playSound("ui_select")
            Game.battle:setState("PARTYSELECT", "SPELL")
            return true
        end
    end
end
--[[
function RemiliaScarlet:onPartySelect(state_reason, party_index)
    
end

function RemiliaScarlet:onPartyCancel(state_reason, party_index)

end]]

return RemiliaScarlet
