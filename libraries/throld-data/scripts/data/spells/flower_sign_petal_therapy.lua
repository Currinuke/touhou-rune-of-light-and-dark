local spell, super = Class(Spell, "flower_sign_petal_therapy")

function spell:init()
    super.init(self)

    self.name = "PetalTherapy"
    self.cast_name = "Flower Sign [Petal Therapy]"

    self.effect = "Heal\nally"
    self.description = "Heavenly light restores a little HP to\none party member. Depends on Magic."

    self.cost = 32
    self.target = "ally"
    self.tags = {"heal"}
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