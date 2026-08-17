local RemiliaScarlet, super = Class(EnemyBattler)
local talk1, talk2, talk3

function RemiliaScarlet:init()
    super.init(self)
    self.is_RemiliaScarlet = true

    -- Enemy name
    self.name = "Remilia Scarlet"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy",")
    self:setActor("remilia_scarlet")

    -- Enemy health
    self.max_health = 3000
    self.health = 3000
    -- Enemy attack (determines bullet damage)
    self.attack = 10
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "remilia_1"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- self.exit_on_defeat = false

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
        "A baojun.",
        "If aaaaaaaaaaa."
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* It would be an awful night.",
        "* It would be a joyful night.",
        "* It would be a scary night.",
        "* Scarlet gazes at all of you.",
        "* Smells like a vampire bat.",
        "* Moonlight shines through the red mist upon the battlefield.",
        "* Moonlight shines through the red mist upon the battlefield.\n[wait:5]* Moonlight is scarlet."
    }

    self.tired_percentage = 0
    self.low_health_percentage = 0.15
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Scarlet\'s hand trembles slightly."

    self:registerAct("Talk", "")
    self:registerAct("S-Talk", "", {"seija"})
    self:registerAct("R-Talk", "", {"rin"})
end

function RemiliaScarlet:onAct(battler, name)
    if name == "Talk" then
        self:registerActIndex(2, "Me Shield", "Take hit\nfor party", nil, 8)
        Game.battle:startActCutscene("remilia_scarlet", "kogasa_talk")
        return
    elseif name == "S-Talk" then
        self:registerActIndex(3, "Scare Burster", "Scare\ndamage", {"seija"}, 60)
        Game.battle:startActCutscene("remilia_scarlet", "seija_talk")
        return
    elseif name == "R-Talk" then
        self:registerActIndex(4, "W.F.[D.F.]", "Falsify\nHP data", {"rin"}, 50)
        Game.battle:startActCutscene("remilia_scarlet", "rin_talk")
        return
    elseif name == "Me Shield" then
        -- Game.battle:powerAct("shelter", battler, "kogasa")
        return {
            "* Your SOUL shined its power on\nTatara Kogasa!",
            "* Kogasa will take all damage for her teammates before DOWN!"
        }
    elseif name == "Scare Burster" then
        Game.battle:powerAct("scare_burster", battler, "seija")
        return {
            "* Your SOUL shined its power on\nKijin Seija!"
        }
    elseif name == "W.F.[D.F.]" then
        Game.battle:powerAct("wind_flower_data_falsifier", battler, "rin")
        return {
            "* Your SOUL shined its power on\nSatsuki Rin!"
        }
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function RemiliaScarlet:onTurnEnd()
    self.wave_override = "remilia_" .. tostring(MathUtils.clamp(Game.battle.turn_count, 1, 1))
    self.defense = self.defense - 1
end

return RemiliaScarlet