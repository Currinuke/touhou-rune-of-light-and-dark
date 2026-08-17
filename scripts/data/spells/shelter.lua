local spell, super = Class(Spell, "shelter")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Shelter"
    -- Name displayed when cast (optional)
    self.cast_name = "Shelter"

    self.effect = ""
    -- Menu description
    self.description = "Deals large Red-elemental damage to\none foe. Depends on Attack & Magic."

    -- TP cost
    self.cost = 8

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "party"

    -- Tags that apply to this spell
    self.tags = {}
end
--[[
function spell:getCastMessage(user, target)
    return "* "..user.chara:getName().." used "..self:getCastName().."!"
end]]

function spell:onCast(user, target)
    --local base_heal = user.chara:getStat("magic") * (Game:getConfig("oldDualHealFormula") and 4 or 5.5)

    --for _, battler in ipairs(target) do
    --    local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara, battler.chara)

    --    battler:heal(heal_amount)
    --end
end

return spell