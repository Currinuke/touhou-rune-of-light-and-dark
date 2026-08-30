local spell, super = Class(Spell, "lunatic_shot")

function spell:init()
    super.init(self)

    self.name = "LunaticShot"
    self.cast_name = nil

    self.effect = "Fatal"
    self.description = "Deals the fatal damage to\nall of the enemies."

    self.cost = 200

    self.target = "enemies"
    self.tags = {"ice", "lunatic", "fatal", "damage"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("lunatic_ocular") then
        cost = MathUtils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    local object = SnowGraveSpell(user)
    object.damage = self:getDamage(user, target)
    object.layer = BATTLE_LAYERS["above_ui"]
    Game.battle:addChild(object)

    return false
end

function spell:getDamage(user, target)
    -- return math.ceil((user.chara:getStat("magic") * 40) + 600)
    local attack = user.chara:getStat("attack")
    local magic = user.chara:getStat("magic")
    local damage = (attack + magic) * 66 + MathUtils.random(300)
    return math.ceil(math.max(damage, 0))
end

return spell
