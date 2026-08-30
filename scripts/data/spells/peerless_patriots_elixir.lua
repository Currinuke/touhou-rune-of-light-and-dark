local spell, super = Class(Spell, "peerless_patriots_elixir")

function spell:init()
    super.init(self)

    self.name = "P.P.Elixir"
    self.cast_name = "Peerless Patriot's Elixir"

    self.effect = "Heal\nally"
    self.description = "Heavenly light restores a little HP to\none party member. Depends on Magic."

    self.cost = 84
    self.target = "ally"
    self.tags = {"heal"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("lunatic_ocular") then
        cost = MathUtils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    local base_heal = user.chara:getStat("magic") * 5
    local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara)

    target:heal(heal_amount)
end

function spell:hasWorldUsage(chara)
    return true
end

function spell:onWorldCast(chara)
    Game.world:heal(chara, 100)
end

return spell