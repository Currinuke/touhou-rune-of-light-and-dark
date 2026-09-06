-- This spell is only used for display in the POWER menu.

local spell, super = Class(Spell, "_scare_ya")

function spell:init()
    super.init(self)

    self.name = "Scare-ya"
    self.cast_name = self.name
    self.effect = "Tire a\nenemy"
    self.description = "Scare one enemy just for a living.\nAlso make them TIRED."
    self.cost = 32

    self.target = "enemy"
    self.tags = {"spare_tired"}
end

function spell:onCast(user, target)
    target:setTired(true)
end

return spell
