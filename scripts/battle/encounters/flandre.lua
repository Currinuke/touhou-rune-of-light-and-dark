local Flandre, super = Class(Encounter)

function Flandre:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* Let the game begin."

    -- Battle music ("battle" is rude buster)
    self.music = "joker"
    -- Enables the purple grid battle background
    self.background = false

    -- Add the dummy enemy to the encounter
    -- self:addEnemy("flandre_scarlet_a")
    self:addEnemy("flandre_scarlet_b")
    self:addEnemy("flandre_scarlet_c")
    self:addEnemy("flandre_scarlet_d")

    -- skip the YOU WON! text
    self.no_end_message = true
end

function Flandre:createSoul(x, y, color)
    return DoubleSoul(x, y, color)
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
