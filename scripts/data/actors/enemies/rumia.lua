local actor, super = Class(Actor, "rumia")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Rumia"

    -- Width and height for this actor, used to determine its center
    self.width = 44
    self.height = 49

    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = {12, 34, 19, 14}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {1, 0, 0}

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = "enemies/rumia"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "idle"

    -- Sound to play when this actor speaks (optional)
    self.voice = nil
    -- Path to this actor's portrait for dialogue (optional)
    self.portrait_path = nil
    -- Offset position for this actor's portrait (optional)
    self.portrait_offset = nil

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {
        ["idle"] = {"idle", 1/10, true},
        ["attack"] = {"attack", 1/10, true}
    }

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {
        -- Since the width and height is the idle sprite size, the offset is 0,0
        ["idle"] = { 0, 0 },
        ["attack"] = { 0, 0 }
    }
end

return actor
