local actor, super = Class(Actor, "bridge_chest")

function actor:init()
    super.init(self)
    self.name = "Chest"

    self.width = 20
    self.height = 20

    self.hitbox = {2, 12, 16, 16}

    self.path = "npcs/bridge_chest"
    self.default = "closed"

    self.offsets = {
        ["closed"] = {0, 10},
        ["empty"] = {0, 10}
    }
end

return actor
