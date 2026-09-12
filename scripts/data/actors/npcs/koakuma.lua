local actor, super = Class(Actor, "koakuma")

function actor:init()
    super.init(self)

    self.name = "Koakuma"

    self.width = 35
    self.height = 44

    self.hitbox = {11, 30, 13, 14}

    self.color = {1, 0, 0}

    self.flip = nil

    self.path = "npcs/koakuma"
    self.default = "idle/right"

    self.voice = "koakuma"
    self.portrait_path = "face/koakuma"
    self.portrait_offset = {-22, -14}

    self.talk_sprites = {}

    self.animations = {
        ["idle/right"] = {"idle/right", 1/10, true},
        ["idle/left"] = {"idle/left", 1/10, true},

        ["poke"] = {"poke", 1/10, true},
        ["scared"] = {"scared", 1/10, false},
        ["tremble"] = {"tremble", 1/10, true}
    }

    self.offsets = {
        ["idle/right"] = {0, 0},
        ["idle/left"] = {0, 0},
        
        ["poke"] = {0, -1},
        ["scared"] = {-14, 0},
        ["tremble"] = {0, -12}
    }
end

return actor
