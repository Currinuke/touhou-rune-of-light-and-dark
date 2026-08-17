local Rumia, super = Class(EnemyBattler)

function Rumia:init()
    super.init(self)

    -- Enemy name
    self.name = "Rumia"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy.lua)
    self:setActor("rumia")

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
        "Is that so?\n[wait:5]Is that so?"
    }

    -- self.exit_on_defeat = false
    
    self.check = {
        "AT 9 DF 2\n[wait:5]* Her headpiece could be a decoration, [wait:5]but it\'s actually a fire axe!",
        "If that axe got removed, [wait:5]she\'ll likely become harmless again."
    
    }

    self.text = {
        "* Rumia cannot suppress her desire\nto swing the axe."
    }
    
    self.tired_percentage = 0
    self.low_health_percentage = 0

    self:registerAct("Scare-ya", "Tire a\nenemy", nil, 32)
    self:registerAct("Strong Wind", "Remove\ndarkness", {"rin"}, 50)
    self:registerAct("Seija\'s Idea", "Need\nteam up", {"seija", "rin"}, 102)

    self.event_heal = function()
        Game.battle:startActCutscene("rumia", "heal")
    end
end

function Rumia:onAct(battler, name)
    if name == "Scare-ya" then
        -- self:setTired(true)
        self:addMercy(40)
        return "* Kogasa scared Rumia!\n[wait:5]* Rumia\'s attention wavered a little."
    elseif name == "Strong Wind" then
        self:setTired(true)
        self:addMercy(50)
        self:addMercy(40)
        Game.battle:startActCutscene("rumia", "act_wind")
        return
    elseif name == "Seija\'s Idea" then -- cheater's choice
        error("聪明。但是 Currinuke 拒绝了你的尝试。")
        return
    end

    return super.onAct(self, battler, name)
end

function Rumia:onHurt(damage, battler)
    self:toggleOverlay(true)
    if not self:getActiveSprite():setAnimation("hurt") then
        self:toggleOverlay(false)
    end
    self:getActiveSprite():shake(9, 0, 0.5, 2 / 30)
end

function Rumia:onDefeat(damage, battler)
end

return Rumia