local FlandreScarlet, super = Class(EnemyBattler)

function FlandreScarlet:init()
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
        --"rumia_1",
        "rumia_2"--,
        --"rumia_showcase"
    }

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."
    
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }

    self.tired_percentage = 0
    self.low_health_percentage = 0.15
    self.low_health_text = "* Is it because her HP too low,\nor has Flandre really become tried?"

    self:registerAct("UMB. Spin", "Unstable\nResult")
    self:registerAct("Group Hypnotize", "Hypnotize\nFlandre\n... a bit.", {"seija", "rin"})
end

function FlandreScarlet:onAct(battler, name)
    if name == "UMB. Spin" then
        --for _, enemy in ipairs(Game.battle.enemies) do
            -- Make the enemy tired
        --    enemy:setTired(false)
        --end
        local _turn = Game.battle.turn_count
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

return FlandreScarlet