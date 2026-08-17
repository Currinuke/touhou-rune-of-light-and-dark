local Flandre, super = Class(EnemyBattler)

function Flandre:init()
    super.init(self)
    self.is_flandre = true

    -- Enemy name
    self.name = "Flandre Scarlet"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy",")
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 3000
    self.health = 3000
    -- Enemy attack (determines bullet damage)
    self.attack = 15
    -- Enemy defense (usually 0)
    self.defense = 0
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    self.exit_on_defeat = false
    -- List of possible wave ids, randomly picked each turn
    self.waves = {
        "basic",
        "aiming",
        "aiming_old",
        "movingarena",
        "rumia_1",
        "rumia_2",
        "rumia_showcase"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }

    self.tired_percentage = 0
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Is it because her HP too low,\nor has Flandre really become tried?"

    -- Register act called "Smile"
    self:registerAct("Umbrella Spin", "Unstable\nResult")
    -- Register party act with Ralsei called "Tell Story"
    -- (second argument is description, usually empty)
    self:registerAct("Group Hypnotize", "Hypnotize\nFlandre\n... a bit.", {"seija", "rin"})
end

function Flandre:onAct(battler, name)
    if name == "Umbrella Spin" then
        --for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
        --    enemy:setTired(false)
        --end
        return {
            "* Kogasa used Umbrella Spin.",
            "* What a rescue?!\nA random party has aiufehjuardwejgaiworjg"
        }
    elseif name == "Group Hypnotize" then
        for _, enemy in ipairs(Game.battle.enemies) do
            -- enemy:setTired(true)
        end
        return "* Everyone hypnotized!"
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

return Flandre