local Flandre, super = Class(Encounter)

function Flandre:init()
    super.init(self)
    self.text = "* Let the game begin."
    self.music = "joker"
    self.background = false

    for _, value in ipairs({"B","C","D"}) do
        local enemy = self:addEnemy("flandre")
        local div = " "
        enemy.name = enemy.name .. div .. value
        if value == "A" then
            enemy.selectable = false
        end
    end
    
    self.no_end_message = true
end

function Flandre:createSoul(x, y, color)
    return DoubleSoul(x, y, color)
end

function Encounter:onDialogueEnd()
    Game.battle:setState("DEFENDINGBEGIN")
end

--[[
function Flandre:getSoulSpawnLocation()
    local main_chara = Game:getSoulPartyMember()

    if main_chara and main_chara:getSoulPriority() >= 0 then
        local battler = Game.battle.party[Game.battle:getPartyIndex(main_chara.id)]

        if battler then
            if main_chara:getActor():getSoulOffset() then
                return battler:localToScreenPos(main_chara:getActor():getSoulOffset())
            else
                return battler:localToScreenPos((battler.sprite.width / 2) - 4.5 - 40, battler.sprite.height / 2)
            end
        end
    end
    return 0, 0
end]]

return Flandre
