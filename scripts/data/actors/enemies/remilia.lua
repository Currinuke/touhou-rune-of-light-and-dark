local actor, super = Class(Actor, "remilia")

function actor:init(style)
    super.init(self)

    self.name = "Remilia Scarlet"

    self.width = 34
    self.height = 44

    self.hitbox = {3, 31, 19, 14}

    self.color = {1, 0, 1}

    self.path = "enemies/remilia"
    self.default = "battle/idle"

    self.voice = "remilia"
    self.portrait_path = "face/remilia"
    self.portrait_offset = {-22, -14}
    
    self.animations = {
        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 1/9, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},

        ["battle/transition"]   = {self.default.."/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/intro", 1/15, false, next = "battle/idle"},
        ["battle/transition_out"] = {"battle/transition_out", 1/15, false},
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Movement offsets
        ["walk/down"] = {0, 0},
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},

        -- Battle offsets
        ["battle/idle"] = {5, 4},
        ["battle/intro"] = {0, 0},

        ["battle/attack"] = {0, 0},
    }
end

return actor