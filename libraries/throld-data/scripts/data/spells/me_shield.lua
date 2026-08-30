local spell, super = Class(Spell, "me_shield")

function spell:init()
    super.init(self)

    self.name = "Me Shield"
    self.cast_name = self.name

    self.effect = "Take hit\nfor party"
    self.description = "Deals large Red-elemental damage to\none foe. Depends on Attack & Magic."

    self.cost = 8
    self.target = "party"
    self.tags = {}
end

function spell:getCastMessage(user, target)
    return Game:loc("spell_" .. self.id .. "_castMessage", {
        userName = user.chara:getName(),
        castName = self:getCastName()
    })
end

function spell:onCast(user, target)
    local base_heal = user.chara:getStat("magic") * (Game:getConfig("oldDualHealFormula") and 4 or 5.5)

    for _, battler in ipairs(target) do
        local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara, battler.chara)

        battler:heal(heal_amount)
    end
end

return spell