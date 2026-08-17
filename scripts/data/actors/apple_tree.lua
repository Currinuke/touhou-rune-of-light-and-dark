local actor, super = Class(Actor, "apple_tree")

function actor:init()
    super.init(self)

    -- Display name (optional)
    self.name = "Apple Tree"

    -- Width and height for this actor, used to determine its center
    self.width = 105
    self.height = 91
    -- Hitbox for this actor in the overworld (optional, uses width and height by default)
    self.hitbox = { 27, 80, 40, 10 } --278 274 294 326-274 52

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = { 1, 1, 0 }

    -- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
    self.flip = nil

    -- Path to this actor's sprites (defaults to "")
    self.path = ""
    -- self.path = "spr_blocktree_parts_0"
    -- This actor's default sprite or animation, relative to the path (defaults to "")
    self.default = "apple_tree"

    -- Table of talk sprites and their talk speeds (default 0.25)
    self.talk_sprites = {}

    -- Table of sprite animations
    self.animations = {}

    -- Table of sprite offsets (indexed by sprite name)
    self.offsets = {}
end

return actor
