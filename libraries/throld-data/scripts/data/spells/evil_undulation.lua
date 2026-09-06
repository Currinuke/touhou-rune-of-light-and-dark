local spell, super = Class(Spell, "evil_undulation")

function spell:init()
    super.init(self)

    self.name = "EvilUndulation"
    self.cast_name = nil

    self.effect = "Heal\nally"
    self.description = "Heavenly light restores a little HP to\none party member. Depends on Magic."

    self.cost = 50
    self.target = "ally"
    self.tags = {}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("lunatic_ocular") then
        cost = MathUtils.round(cost / 2)
    end
    return cost
end

function spell:onCast(user, target)
    target.chara:addFlag("evilundulations_have", 1)
    local background = SnowglobeEffect(0, 0, false)
    local foreground = SnowglobeEffect(0, 0, true)
    target.sprite.parent:addChild(background)
    target.sprite.parent:addChild(foreground)
    background.layer = target.sprite.layer - 1
    foreground.layer = target.sprite.layer + 1
    background:setScale(0.5)
    foreground:setScale(0.5)
end

return spell