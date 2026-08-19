local actor, super = Class(Actor, "flandre_b")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Flandre Scarlet B"

    self.width = 46
    self.height = 47

    -- self.hitbox = {0, 25, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 0, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/flandre_b"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "battle/idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Whether this actor as a follower will blush when close to the player
    self.can_blush = false

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["battle/idle"] = {"battle/idle", 0.1, true},
        ["battle/hurt"] = {"battle/hurt", 0.1, true},
        ["battle/tired"] = {"battle/tired", 0.1, true},
        ["battle/teleport"] = {"battle/teleport", 0.1, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        ["battle/idle"] = {0, 0},
        ["battle/hurt"] = {0, 0},
        ["battle/tired"] = {0, -4},
        ["battle/teleport"] = {0, 0}
    }
end

return actor
