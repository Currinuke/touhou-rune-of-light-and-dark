local actor, super = Class(Actor, "rumia")

function actor:init()
    super.init(self)

    self.name = "Rumia"

    self.width = 40
    self.height = 49

    self.hitbox = {12, 34, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "enemies/rumia"
    self.default = "idle"

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"idle", 1/10, true},
        ["obtain_axe"] = {"obtain_axe", 1/10, false},

        ["battle/idle"] = {"battle/idle", 1/10, true},
        ["battle/attack"] = {"battle/attack", 1/10, true},
        ["battle/shock"] = {"battle/shock", 1/10, false}
    }

    self.offsets = {
        ["idle"] = {0, 0},
        ["battle/attack"] = {0, 0}
    }
end

return actor
