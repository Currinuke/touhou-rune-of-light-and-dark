local spell, super = Class(Spell, "fuuka_data_alter")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "Fuuka [D. Alter]"
    -- Name displayed when cast (optional)
    self.cast_name = "Fuuka [Data Alter]"

    -- Battle description
    self.effect = "Change HP\ndata"
    -- Menu description
    self.description = "Heavenly light restores a little HP to\nall party members. Depends on Magic."

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "party"

    -- Tags that apply to this spell
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    local base_heal = user.chara:getStat("magic") * (Game:getConfig("oldDualHealFormula") and 4 or 5.5)

    for _, battler in ipairs(target) do
        local heal_amount = Game.battle:applyHealBonuses(base_heal, user.chara, battler.chara)

        battler:heal(heal_amount)
    end
end

return spell
