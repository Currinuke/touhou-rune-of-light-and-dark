local Remilia, super = Class(EnemyBattler)

function Remilia:init()
    super.init(self)
    -- self.is_remilia = true

    -- Enemy name
    self.name = "Remilia Scarlet"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy",")
    self:setActor("remilia")

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
    self.disable_mercy = true

    -- List of possible wave ids, randomly picked each turn
    self.waves = {}

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "1225, 1997...",
        "...",
        "..."
    }

    self.exit_on_defeat = true

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
    self.low_health_percentage = 0.1
    self.low_health_text = "* Scarlet\'s hand trembles slightly."

    self:registerAct("Talk", "")
    self:registerAct("S-Talk", "", {"seija"})
    self:registerAct("R-Talk", "", {"rin"})
end

function Remilia:onAct(battler, name)
    if name == "Talk" then
        self:registerActIndex(2, "Me Shield", "Take hit\nfor party", nil, 8)
        Game.battle:startActCutscene("remilia", "kogasa_talk")
        return
    elseif name == "S-Talk" then
        self:registerActIndex(3, "Scare Burster", "Scare\ndamage", {"seija"}, 60)
        Game.battle:startActCutscene("remilia", "seija_talk")
        return
    elseif name == "R-Talk" then
        self:registerActIndex(4, "W.F.[D.F.]", "Falsify\nHP data", {"rin"}, 50)
        Game.battle:startActCutscene("remilia", "rin_talk")
        return
    elseif name == "Me Shield" then
        Game.battle:startActCutscene("remilia", "kogasa_act")
        return
    elseif name == "Scare Burster" then
        Game.battle:startActCutscene("remilia", "seija_act")
        return
    elseif name == "W.F.[D.F.]" then
        Game.battle:startActCutscene("remilia", "rin_act")
        return
    end

    return super.onAct(self, battler, name)
end

function Remilia:onTurnStart()
    local turn = MathUtils.clamp(Game.battle.turn_count, 1, 12)

    if turn > 1 then
        turn = 7
    end

    self.wave_override = "remilia/remilia_" .. tostring(turn)
    -- self.defense = self.defense - 1
end

return Remilia