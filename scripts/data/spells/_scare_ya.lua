-- This spell is only used for display in the POWER menu.

local spell, super = Class(Spell, "_scare_ya")

function spell:init()
    super.init(self)

    self.name = "Scare-ya"
    self.cast_name = self.name
    self.effect = "Tire a\nenemy"
    self.description = "Scare one enemy to make them TIRED.\nJust for making a living."
    self.cost = 32

    -- Target mode (ally, party, enemy, enemies, or none)
    self.target = "enemy"

    self.tags = {}
end

function spell:onCast(user, target)
    target:setTired(true)
end

return spell
