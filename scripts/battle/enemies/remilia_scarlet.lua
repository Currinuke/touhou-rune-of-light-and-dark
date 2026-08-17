local RemiliaScarlet, super = Class(EnemyBattler)
local talk1, talk2, talk3

function RemiliaScarlet:init()
    super.init(self)
    self.is_RemiliaScarlet = true

    -- Enemy name
    self.name = "Remilia Scarlet"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy",")
    self:setActor("dummy")

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
    self.waves = {}

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."

    -- Text randomly displayed at the bottom of the screen each turn
    self.text = {
        "* It would be an awful night.",
        "* It would be a joyful night.",
        "* It would be a scary night.",
    }

    self.tired_percentage = 0
    -- Text displayed at the bottom of the screen when the enemy has low health
    self.low_health_text = "* Is her HP too low, \nor has she really become tried?"
    --[[
    talk1 = self:registerAct("Talk", "")
    --self:registerAct("Talk ", "", {"seija"})
    --self:registerAct("Talk  ", "", {"rin"})
    talk2 = self:registerAct("Talk", "", {"seija"})
    talk3 = self:registerAct("Talk", "", {"rin"})]]

    self:registerAct("Talk", "")
    self:registerAct("Talk ", "", {"seija"})
    self:registerAct("Talk  ", "", {"rin"})
end

function RemiliaScarlet:onAct(battler, name)
    --Kristal.Console:log(battler.chara.id)
    if name == "Talk" then
        self:registerActIndex(2, "Shelter", "Take hit\nfor party", nil, 8)
        return {
            "* Kogasa tried to talk with Remilia...",
            "* What a rescue?!\nA random party has aiufehj uardwej gaiwo rjg"
        }
    elseif name == "Talk " then
        self:registerActIndex(3, "Scare Smask", "Scare\ndamage", {"seija"}, 60)
        return {
            "* Seija tried to talk with Remilia...",
            "* What a rescue?!\nA random party has aiufeh jua rdwejgai worjg"
        }
    elseif name == "Talk  " then
        self:registerActIndex(4, "Fuuka [D. Alter]", "Change HP\ndata", {"rin"}, 50)
        return {
            "* Rin tried to talk with Remilia...",
            "* What a rescue?!\nA random party has ai ufeh ju ard wejgai wor jg"
        }
    elseif name == "Shelter" then
        -- Game.battle:powerAct("shelter", battler, "kogasa")
        return {
            "* Your SOUL shined its power on\nthe party!",
            "* Kogasa will now take damage until she downs!"
        }
    elseif name == "Scare Smask" then
        Game.battle:powerAct("scare_smack", battler, "seija")
        return {
            "* Your SOUL shined its power on\nSeija!"
        }
    elseif name == "Fuuka [D. Alter]" then
        Game.battle:powerAct("fuuka_data_alter", battler, "rin")
        return {
            "* Your SOUL shined its power on\nRin!"
        }
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end

--[[
function RemiliaScarlet:onAct(battler, name)
    if name == "Talk" then
        self:registerActOn(2, "Shelter", "Take hit\nfor party", nil, 8)
        return {
            "* Kogasa tried to talk ...",
            "* What a rescue?!\nA random party hasaiufehjuardwejgaiworjg"
        }
    elseif name == "Talk " then
        self:registerActOn(3, "Scare Smask", "", {"seija"}, 60)
        return {
            "* 23232322323232323.",
            "* What a rescue?!\nA random party hasaiufehjuardwejgaiworjg"
        }
    elseif name == "Talk  " then
        self:registerActOn(4, "Fuuka [D. Eater]", "Change HP\ndata", {"rin"}, 50)
        return {
            "* 11111111111111",
            "* What a rescue?!\nA random party hasaiufehjuardwejgaiworjg"
        }
    elseif name == "Shelter" then
        return {
            "* 11111111111111",
            "* Kogasa will take damage until her downs!"
        }
    elseif name == "Scare Smask" then
        return {
            "* 11111111111111",
            "* What a rescue?!\nA random party hasaiufehjuardwejgaiworjg"
        }
    elseif name == "Fuuka [D. Eater]" then
        return {
            "* 11111111111111",
            "* What a rescue?!\nA random party hasaiufehjuardwejgaiworjg"
        }
    end

    -- If the act is none of the above, run the base onAct function
    -- (this handles the Check act)
    return super.onAct(self, battler, name)
end]]

function RemiliaScarlet:onTurnStart()
    self.wave_override = "remilia_" .. MathUtils.clamp(tostring(Game.battle.turn_count), 1, 1)
    self.defense = self.defense - 1
end

return RemiliaScarlet