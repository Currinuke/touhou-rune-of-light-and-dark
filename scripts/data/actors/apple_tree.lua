local actor, super = Class(Actor, "apple_tree")

function actor:init()
    super.init(self)

    self.name = "Apple Tree"

    self.width = 105
    self.height = 91
    self.hitbox = { 27, 80, 40, 10 } --278 274 294 326-274 52

    self.color = { 1, 1, 0 }

    self.flip = nil

    self.path = ""
    self.default = "apple_tree"

    self.talk_sprites = {}

    self.animations = {}

    self.offsets = {}
end

return actor
