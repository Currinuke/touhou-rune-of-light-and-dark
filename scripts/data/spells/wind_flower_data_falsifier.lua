local spell, super = Class(Spell, "wind_flower_data_falsifier")

function spell:init()
    super.init(self)

    -- Display name
    self.name = "W.F.[D.F.]"
    -- Name displayed when cast (optional)
    self.cast_name = "Wind Flower [Data Falsifier]"

    -- Battle description
    self.effect = "Change HP\ndata"
    -- Menu description
    self.description = ""

    -- TP cost
    self.cost = 50

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "party"

    self.tags = {"heal"}
end

function spell:onCast(user, target)
    --local battler = target[MathUtils.randomInt(1, 1 + #target)]
    --battler.chara:setHealth( * 2)
    -- Assets.stopAndPlaySound("smile")
    for _, battler in ipairs(target) do
        battler:heal(math.floor(battler.chara:getStat("health")))
    end
    return false
end

return spell
