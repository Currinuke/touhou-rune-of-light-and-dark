local actor, super = Class(Actor, "flandre_c")

function actor:init()
	super.init(self)

	-- Display name (optional)
	self.name = "Flandre Scarlet C"

	self.width = 34
	self.height = 44

	-- self.hitbox = {0, 25, 19, 14}

	-- Color for this actor used in outline areas (optional, defaults to red)
	self.color = { 1, 0, 0 }

	-- Whether this actor flips horizontally (optional, values are "right" or "left", indicating the flip direction)
	self.flip = nil

	-- Path to this actor's sprites (defaults to "")
	self.path = "enemies/flandre_c"
	-- This actor's default sprite or animation, relative to the path (defaults to "")
	self.default = "idle"

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
		["battle/tired"] = {"battle/tired", 0.1, true},
		["battle/beat"] = {"battle/beat", 0.1, true},

		["idle"] = {"idle", 0.1, true},
		["talk"] = {"talk", 0.15, true},
		["handopen"] = {"handopen", 0.1, true},
		["handclose"] = {"handclose", 0.1, true},
	}

	-- Table of sprite offsets (indexed by sprite name)
	self.offsets = {
		["battle/idle"] = {0, 0},
		["battle/tired"] = {-7, 1},
		["battle/beat"] = {0, 0},

		["idle"] = {-9, -4},
		["talk"] = {-9, -4},
		["handopen"] = {-9, -4},
		["handclose"] = {-9, -4},
	}
end

return actor
