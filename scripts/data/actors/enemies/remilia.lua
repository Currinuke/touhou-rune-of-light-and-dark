local actor, super = Class(Actor, "remilia")

function actor:init(style)
	super.init(self)

	self.name = "Remilia Scarlet"

	self.width = 18
	self.height = 37

	self.hitbox = {0, 23, 18, 14}

	self.color = {1, 0, 1}

	self.path = "enemies/remilia"
	self.default = "wait"

	self.voice = "remilia"
    -- self.font = "main_mono"
    -- self.speech_bubble_font_size = 16
	self.portrait_path = "face/remilia"
	self.portrait_offset = {-22, -14}

	self.animations = {
		["battle/idle"] = {"battle/idle", 1/9, true},
		["battle/idle_handup"] = {"battle/idle_handup", 1/9, true},

		["battle/attack"] = {"battle/attack", 1/15, false},

		["battle/intro"] = {"battle/intro", 1/15, false, next = "battle/idle"},

		["wait"] = {"wait", 0, false},
		["walk/left"] = {"walk/left", 1/10, true},
		["walk/right"] = {"walk/right", 1/10, true},
		["freezed"] = {"freezed", 0, false},
        ["wet"] = {"wet", 1/9, true},
	}

	self.offsets = {
		-- 96*96 --> {-39, -27}
        -- offset = trim (usually positive) + (-39 or -27)
		["wait"] = {0, 0},
		["walk/left"] = {1, 0},
		["walk/right"] = {-4, 0},
		["freezed"] = {-9, 0},
        ["wet"] = {-32, -11},

		["battle/idle"] = {-3, -5},
		["battle/idle_handup"] = {-9, -5},
		["battle/intro"] = {-8, -9},

		["battle/attack"] = {-14, -5}
	}
end

return actor