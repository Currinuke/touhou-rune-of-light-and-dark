local actor, super = Class(Actor, "rin")

function actor:init()
	super.init(self)

	self.name = "Rin"

	self.width = 23
	self.height = 42
	self.hitbox = {3, 28, 17, 14}

	self.color = {0, 1, 0}

	self.path = "party/rin/dark"
	self.default = "walk"

	self.voice = "ralsei"
	self.portrait_path = "face/rin"
	self.portrait_offset = {-22, -14}

	self.can_blush = false

	self.animations = {
		["battle/idle"] = {"battle/idle", 1/6, true},

		["battle/attack"] = {"battle/attack", 1/15, false},
		["battle/act"] = {"battle/act", 1/15, false},
		["battle/spell"] = {"battle/spell", 1/15, false, next = "battle/idle"},
		["battle/item"] = {"battle/item", 1/12, false, next = "battle/idle"},
		["battle/spare"] = {"battle/spell", 1/15, false, next = "battle/idle"},

		["battle/attack_ready"] = {"battle/attackready", 0.2, true},
		["battle/act_ready"] = {"battle/actready", 0.2, true},
		["battle/spell_ready"] = {"battle/spellready", 0.2, true},
		["battle/item_ready"] = {"battle/itemready", 0.2, true},

		["battle/act_end"] = {"battle/actend", 1/15, false, next = "battle/idle"},
		-- ["battle/spell_end"] = {"battle/spellend", 1/15, false, next = "battle/idle"},

		["battle/hurt"] = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
		["battle/defeat"] = {"battle/defeat", 1/15, false},
		["battle/swooned"] = {"battle/defeat", 1/15, false},

		["battle/transition"] = {"walk/right_1", 1/15, false},
		["battle/intro"] = {"battle/intro", 1/15, false},
		["battle/victory"] = {"battle/victory", 1/10, false},
		["battle/transition_out"] = {"battle/transition_out", 1/15, false}
	}
	
	self.mirror_sprites = {
		["walk/down"] = "walk/up",
		["walk/up"] = "walk/down",
		["walk/left"] = "walk/left",
		["walk/right"] = "walk/right"
	}

	self.offsets = {
		-- 120*100 --> {-53, -39}
		-- offset = trim (usually positive) + (-53 or -39)

		["walk/down"] = {0, 0},
		["walk/left"] = {4, 0},
		["walk/right"] = {1, 0},
		["walk/up"] = {-1, 0},

		["battle/idle"] = {2, 0},

		["battle/attack"] = {-8, 1},
		["battle/attackready"] = {-7, 1},
		["battle/act"] = {2, 1},
		["battle/actend"] = {2, 1},
		["battle/actready"] = {2, 1},
		["battle/spell"] = {-4, -3},
		["battle/spellready"] = {-2, 0},
		["battle/spellend"] = {-4, -3},
		["battle/item"] = {2, 1},
		["battle/itemready"] = {2, 1},
		["battle/itemend"] = {2, 1},
		["battle/defend"] = {2, 1},

		["battle/defeat"] = {2, 30},
		["battle/hurt"] = {-4, 1},

		["battle/intro"] = {-4, -3},
		["battle/victory"] = {2, 0},

		["pose"] = {-3, 0},
		["fell"] = {-10, 18}
	}

	self.spotlight_offset = {10, -5}
end

return actor