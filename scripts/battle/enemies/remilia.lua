local Remilia, super = Class(EnemyBattler)

function Remilia:init()
    super.init(self)

    -- self.name = "Remilia Scarlet"
    self:applyLocalization()
    
    self:setActor("remilia")

    self.max_health = 3000
    self.health = 3000
    self.attack = 10
    self.defense = 0
    self.money = 0

    self.spare_points = 0
    self.disable_mercy = true

    self.waves = {}

    self.dialogue = {
        "1225, 1997...",
        "...",
        "..."
    }

    self.exit_on_defeat = true

    self.check = {
        "A baojun.",
        "If aaaaaaaaaaa."
    }

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
    self.low_health_percentage = 0.1
    self.low_health_text = "* Scarlet\'s hand trembles slightly."

    self:registerAct("Talk", "")
    self:registerAct("S-Talk", "", {"seija"})
    self:registerAct("R-Talk", "", {"rin"})
end

function Remilia:applyLocalization(update_acts)
    local old_check = self.act_check
    local old_talk = self.act_talk
    local old_tell_story = self.act_tell_story

    self.name = Game:locText("[name:remilia_scarlet]")
    
    self.dialogue = {
        Game:loc("enemy_dummy_dialogue")
    }
    
    self.check = Game:loc("enemy_dummy_check")

    
    self.text = {
        Game:loc("enemy_dummy_turn_1"),
        Game:loc("enemy_dummy_turn_2"),
        Game:loc("enemy_dummy_turn_3"),
    }
    
    self.low_health_text = Game:loc("enemy_dummy_low_health")

    self.act_check = Game:loc("act_check")
    self.act_smile = Game:loc("act_dummy_smile")
    self.act_tell_story = Game:loc("act_dummy_tell_story")

    if self.acts and self.acts[1] then
        self.acts[1].name = self.act_check
    end

    if update_acts then
        for _, act in ipairs(self.acts or {}) do
            if act.name == old_check then
                act.name = self.act_check
            elseif act.name == old_talk then
                act.name = self.act_talk
            elseif act.name == old_tell_story then
                act.name = self.act_tell_story
            end
        end
    end
end

function Remilia:onAct(battler, name)
    if name == "Talk" then
        self:registerActIndex(2, "Me Shield", "Take hit\nfor party", nil, 8)
        Game.battle:startActCutscene("remilia", "kogasa_talk")
        return
    elseif name == "S-Talk" then
        self:registerActIndex(3, "Scare Burster", "Mixed\ndamage", {"seija"}, 60)
        Game.battle:startActCutscene("remilia", "seija_talk")
        return
    elseif name == "R-Talk" then
        self:registerActIndex(4, "D.Falsifier", "Falsify\nnHP stats", {"rin"}, 50)
        Game.battle:startActCutscene("remilia", "rin_talk")
        return
    elseif name == "Me Shield" then
        return Game.battle:powerAct("me_shield", battler, "kogasa", Game.battle.party)
    elseif name == "Scare Burster" then
        return Game.battle:powerAct("scare_burster", battler, "seija", self)
    elseif name == "D.Falsifier" then
        return Game.battle:powerAct("wind_flower_data_falsifier", battler, "rin", Game.battle.party)
    end

    return super.onAct(self, battler, name)
end

function Remilia:onTurnStart()
    local turn = MathUtils.clamp(Game.battle.turn_count, 1, 12)

    if turn > 1 then
        turn = 7
    end

    self.wave_override = "remilia_" .. tostring(turn)
    -- self.defense = self.defense - 1
end

return Remilia