local actor, super = Class(Actor, "koakuma")

function actor:init()
    super.init(self)

    self.name = "Koakuma"

    self.width = 44
    self.height = 49

    self.hitbox = {12, 34, 19, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "enemies/rumia"
    self.default = "idle"

    self.voice = "koakuma"
    self.portrait_path = "face/koakuma"
    self.portrait_offset = {-22, -14}

    self.talk_sprites = {}

    self.animations = {
        ["idle"] = {"idle", 1/10, true},
        ["attack"] = {"attack", 1/10, true}
    }

    self.offsets = {
        ["idle"] = {0, 0},
        ["attack"] = {0, 0}
    }
end

return actor
