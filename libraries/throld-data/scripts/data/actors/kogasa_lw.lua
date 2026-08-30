local actor, super = Class(Actor, "kogasa_lw")

function actor:init()
    super.init(self)

    self.name = "Kogasa"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 37

    self.hitbox = {0, 25, 19, 14}
    self.soul_offset = {10, 24}

    self.color = {0, 1, 1}

    self.path = "party/kogasa/light"
    self.default = "walk"

    self.voice = nil
    self.portrait_path = "face/kogasa"
    self.portrait_offset = {-12, -10}

    self.can_blush = false

    -- Table of sprite animations
    self.animations = {
        -- Cutscene animations
        ["sit"] = {"sit", 0.25, true},
        ["slide"] = {"slide", 0.25, true},
    }

    -- Tables of sprites to change into in mirrors
    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right",
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Cutscene offsets
        ["fall"] = {-8, -2},

        ["fallen"] = {-8, 16},

        ["sit"] = {-4, -8},

        ["slide"] = {0, 0},

        ["ghostwalk_lf"] = {-4, 3},
        ["ghostwalk_lu"] = {-4, 3},
        ["ghostwalk_rf"] = {-4, 3},
        ["ghostwalk_ru"] = {-4, 3},
    }
end

return actor
