local Rumia, super = Class(EnemyBattler)

function Rumia:init()
    super.init(self)

    -- Enemy name
    self.name = "Rumia"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 320
    self.health = 320
    -- Enemy attack (determines bullet damage)
    self.attack = 9
    -- Enemy defense (usually 0)
    self.defense = 2
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0

    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "rumia_1",
        "rumia_2",
        "rumia_showcase"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = {
        "AT 9 DF 2\n* Cotton heart and button eye\n* Looks just like a fluffy guy.",
        "Cotton heart and button eye looks just like a fluffy guy."
    
    }

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* The dummy looks like it's\nabout to fall over."

    -- self:registerAct("Check", "Useless\nanalysis")
    self:registerAct("Startle", "Startle\nAction", nil, 32)
    self:registerAct("Strong Wind", "Remove\ndarkness", {"rin"}, 50)
    self:registerAct("Seija's Idea", "Need\nteam up", {"seija", "rin"}, 102)
end

function Rumia:onAct(battler, name)
    if name == "Startle" then
        self:addMercy(40)
        -- Change this enemy's dialogue for 1 turn
        -- self.dialogue_override = "... ^^"
        return "* "
    elseif name == "Strong Wind" then
        self:setTired(true)
        self:addMercy(50)
        self:addMercy(40)
        return {
            "* Kogasa commands Rin to blow strong wind!",
            "* Press [bind:confirm] to summon strong wind!"
        }

    elseif name == "Seija's Idea" then -- cheater's choice
        return "* Cheater..."
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

function Rumia:onHurtEnd()
end

return Rumia