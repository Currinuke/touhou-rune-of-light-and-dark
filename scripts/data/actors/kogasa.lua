local actor, super = Class(Actor, "kogasa")

function actor:init()
    super.init(self)

    self.name = "Kogasa"

    -- Width and height for this actor, used to determine its center
    self.width = 19
    self.height = 37

    self.hitbox = {0, 25, 19, 14}
    self.soul_offset = {10, 24}

    -- Color for this actor used in outline areas (optional, defaults to red)
    self.color = {0, 1, 1}

    self.path = "party/kogasa/dark"
    self.default = "walk"

    self.voice = nil
    self.portrait_path = "face/kogasa"
    self.portrait_offset = {-12, -10}

    self.can_blush = false

    self.animations = {
        -- Movement animations
        ["slide"]               = {"slide_new", 4/30, true},

        -- Battle animations
        ["battle/idle"]         = {"battle/idle", 1/10, true},

        ["battle/attack"]       = {"battle/attack", 1/15, false},
        ["battle/act"]          = {"battle/act", 1/15, false},
        ["battle/spell"]        = {"battle/act", 1/15, false},
        ["battle/item"]         = {"battle/item", 1/12, false, next="battle/idle"},
        ["battle/spare"]        = {"battle/act", 1/15, false, next="battle/idle"},

        ["battle/attack_ready"] = {"battle/attackready", 0.2, true},
        ["battle/act_ready"]    = {"battle/actready", 0.2, true},
        ["battle/spell_ready"]  = {"battle/actready", 0.2, true},
        ["battle/item_ready"]   = {"battle/itemready", 0.2, true},
        ["battle/defend_ready"] = {"battle/defend", 1/15, false},

        ["battle/act_end"]      = {"battle/actend", 1/15, false, next="battle/idle"},

        ["battle/hurt"]         = {"battle/hurt", 1/15, false, temp=true, duration=0.5},
        ["battle/defeat"]       = {"battle/defeat", 1/15, false},
        ["battle/swooned"]      = {"battle/defeat", 1/15, false},

        ["battle/transition"]   = {"sword_jump_down", 0.2, true},
        ["battle/intro"]        = {"battle/intro", 1/15, false},
        ["battle/victory"]      = {"battle/victory", 1/10, false},
        ["battle/transition_out"] = {"battle/intro", 1/15, false},

        -- Cutscene animations
        ["jump_fall"]           = {"fall", 1/5, true},
        ["jump_ball"]           = {"ball", 1/15, true},
        ["jump_ball_slow"]      = {"ball", 4/30, true},
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
        -- Movement offsets
        ["walk/left"] = {0, 0},
        ["walk/right"] = {0, 0},
        ["walk/up"] = {0, 0},
        ["walk/down"] = {0, 0},

        ["walk_blush/down"] = {0, 0},

        ["slide"] = {0, 0},
        ["slide_animated"] = {-5, -2},
        ["slide_new"] = {-5, -2},

        -- Battle offsets
        ["battle/idle"] = {-8, -1},

        ["battle/attack"] = {-13, -3},
        ["battle/attackready"] = {0, -1},
        ["battle/act"] = {-8, -1},
        ["battle/actend"] = {-6, -6},
        ["battle/actready"] = {-8, 1},
        ["battle/item"] = {-8, -6},
        ["battle/itemready"] = {-8, 0},
        ["battle/defend"] = {-8, 0},

        ["battle/defeat"] = {0, 8},
        ["battle/hurt"] = {-11, -1},

        ["battle/intro"] = {-13, 0},
        ["battle/victory"] = {-3, 0},

        -- Climb offsets
        ["climb/climbing"] = {-5, -15},
        ["climb/fall"] = {-3, -14},
        ["climb/charge"] = {-4, -12},
        ["climb/charge_right"] = {-4, -12},
        ["climb/charge_left"] = {-4, -12},
        ["climb/slip_right"] = {-3, -13},
        ["climb/slip_left"] = {-2, -13},
        ["climb/jump_up"] = {-4, -13},
        ["climb/land_right"] = {-4, -13},
        ["climb/land_left"] = {-4, -13},

        -- Cutscene offsets
        ["pose"] = {-4, -2},

        ["fall"] = {-5, -6},
        ["ball"] = {1, 8},
        ["landed"] = {-4, -2},

        ["fell"] = {-14, 1},

        ["sword_jump_down"] = {-19, -5},
        ["sword_jump_settle"] = {-27, 4},
        ["sword_jump_up"] = {-17, 2},

        ["hug_left"] = {-4, -1},
        ["hug_right"] = {-2, -1},

        ["peace"] = {0, 0},
        ["rude_gesture"] = {0, 0},

        ["reach"] = {-3, -1},

        ["sit"] = {-3, 0},

        ["t_pose"] = {-4, 0},
    }

    if Game.chapter <= 2 then
        self.animations["slide"] = {"slide", 4/30, true}
    elseif Game.chapter == 3 then
        self.animations["slide"] = {"slide_animated", 4/30, true}
    end

    if Game.chapter == 1 then
        self.animations["battle/transition"] = {"walk/right", 0, true}
    end

    -- The x and y offsets of the ReviveSong spotlight
    self.spotlight_offset = { -2, -5 }
end

function actor:onSetAnimation(sprite, anim, callback)
    -- Kristal.Console:push("old: " .. tostring(sprite.temp_sprite))
    -- Kristal.Console:push("new: " .. anim[1])
    -- Kristal.Console:push(tostring(anim[1]))
    if anim[1] == "battle/idle" then
        --Assets.playSound("ominous")
    end
end

return actor
