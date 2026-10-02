local actor, super = Class(Actor, "seija")

function actor:init()
    super.init(self)

    self.name = "Seija"

    self.width = 22
    self.height = 43
    self.hitbox = {2, 29, 18, 14}

    self.soul_offset = {11, 24}

    self.color = {1, 0, 1}

    self.path = "party/seija/dark"

    self.default = "walk"
    self.voice = "susie"
    self.portrait_path = "face/seija"

    self.portrait_offset = {-22, -14}
    self.can_blush = false

    self.animations = {
        ["slide"]               = {"slide", 4/30, true},

        ["battle/idle"]         = {"battle/idle", 1/6, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/spell", 1/15, false, next = "battle/idle"},
        ["battle/item"]         = {"battle/item", 1/12, false, next = "battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next = "battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/spellready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defendready", 1/15, false, next = "battle/defend"},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next = "battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp = true, duration = 0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},
        ["battle/swooned"]      = {"battle/swooned", 1/15, false},

        ["battle/transition"]   = {self.default.."/right_1", 1/15, false},
        ["battle/intro"]        = {"battle/attack", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
        ["battle/transition_out"] = {"battle/transition_out", 1/15, false},

        ["battle/rule_burster"]  = {"battle/ruleburster", 1/15, false, next = "battle/idle"},
        
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},
        ["jump_ball_slow"]      = {"ball", 4/30, true}
    }

    self.mirror_sprites = {
        ["walk/down"] = "walk/up",
        ["walk/up"] = "walk/down",
        ["walk/left"] = "walk/left",
        ["walk/right"] = "walk/right"
    }

    self.offsets = {
		-- 120*100 --> {-49, -38}
        -- offset = trim (usually positive) + (-49 or -38)
        ["walk/down"] = {0, 0},
        ["walk/left"] = {-1, -1},
        ["walk/right"] = {-2, -1},
        ["walk/up"] = {1, 0},

        ["slide"] = {-5, -12},

        ["battle/idle"] = {3, -9},

        ["battle/attack"] = {-26, 1},
        ["battle/attackready"] = {-12, 1},
        ["battle/act"] = {5, 9},
        ["battle/actend"] = {-24, -26},
        ["battle/actready"] = {5, 9},
        ["battle/spell"] = {-8, -18},
        ["battle/spellready"] = {-5, -18},
        ["battle/spellend"] = {3, -9},
        ["battle/item"] = {-22, -2},
        ["battle/itemready"] = {-22, -2},
        ["battle/defend"] = {-2, -1},
        ["battle/defendready"] = {-2, -18},
        ["battle/swooned"] = {0, 0},

        ["battle/defeat"] = {1, 12},
        ["battle/hurt"] = {-15, 3},

        ["battle/victory"] = {-18, -7},

        ["battle/ruleburster"] = {-21, -14},

        ["pose"] = {-1, -1},

        ["fall"] = {0, -4},
        ["ball"] = {-4, 8},
        ["landed"] = {-5, -2},

        ["shock_right"] = {-5, -1},

        ["away"] = {-1, -2},
        ["away_turn"] = {-1, -2},
        ["away_hips"] = {-2, -1},
        ["away_hand"] = {-2, -2},
        ["away_scratch"] = {-2, -2},

        ["t_pose"] = {-6, 0},

        ["fell"] = {-18, -2},

        ["kneel_right"] = {-4, -2},
        ["kneel_left"] = {-12, -2},

        ["diagonal_kick_right"] = {-5, -1},
        ["diagonal_kick_left"] = {-3, -1},
    }

    self.spotlight_offset = {0, -7}
end

return actor