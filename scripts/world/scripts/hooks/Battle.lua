local Battle, super = HookSystem.hookScript(Battle)

--[[
function Battle:updateIntro()
    if false then -- 哈哈直接禁用
        super.updateIntro(self)
    else
        self.intro_timer = self.intro_timer + 1 * DTMULT
        if self.intro_timer >= 26 then
            for _, v in ipairs(self.party) do
                v:setAnimation("battle/idle")
            end
            self:setState("ACTIONSELECT", "INTRO")
            -- self:nextTurn()
        end
    end
end--]]

function Battle:updateIntro()
    -- 保证小伞的battle/intro动画不会被打断
    self.intro_timer = self.intro_timer - 0.5 * DTMULT
    super.updateIntro(self)
end

function Battle:nextTurn()
    self.turn_count = self.turn_count + 1
    if self.turn_count > 1 then
        if self.encounter:onTurnEnd() then
            return
        end
        for _, enemy in ipairs(self:getActiveEnemies()) do
            if enemy:onTurnEnd() then
                return
            end
        end
    end

    for _, action in ipairs(self.current_actions) do
        if action.action == "DEFEND" then
            self:finishAction(action)
        end
    end

    for _, enemy in ipairs(self.enemies) do
        enemy.selected_wave = nil
        enemy.hit_count = 0
    end

    for _, battler in ipairs(self.party) do
        battler.hit_count = 0
        if (battler.chara:getHealth() <= 0) and battler.chara:canAutoHeal() and self.encounter:isAutoHealingEnabled(battler) then
            battler:heal(battler.chara:autoHealAmount(), nil, true)
        end
        battler.action = nil
    end

    self.attackers = {}
    self.normal_attackers = {}
    self.auto_attackers = {}

    self.current_selecting = 1
    while not (self.party[self.current_selecting]:isActive()) do
        self.current_selecting = self.current_selecting + 1
        if self.current_selecting > #self.party then
            Kristal.Console:warn("Nobody up! This shouldn't happen...")
            self.current_selecting = 1
            break
        end
    end

    self.current_button = 1

    self.character_actions = {}
    self.current_actions = {}
    self.processed_action = {}

    if self.battle_ui then
        for _, box in ipairs(self.battle_ui.action_boxes) do
            box.selected_button = 1
            -- 好像这个才是呢
            if box.battler.chara.name == "Seija" then box.selected_button = #box:getSelectableButtons() end
            --box:setHeadIcon("head")
            box:resetHeadIcon()
        end
        local text, portrait, actor = nil, nil, nil
        if self.state == "INTRO" or self.state_reason == "INTRO" or not self.seen_encounter_text then
            self.seen_encounter_text = true
            text, portrait, actor = self:getInitialEncounterText()
        else
            text, portrait, actor = self:getEncounterText()
        end

        self.battle_ui.current_encounter_text = {
            text = text,
            portrait = portrait,
            actor = actor
        }

        self:setEncounterText(self.battle_ui.current_encounter_text, false)
    end

    if self.soul then
        self:returnSoul()
    end

    self.encounter:onTurnStart()

    for _, enemy in ipairs(self:getActiveEnemies()) do
        enemy:onTurnStart()
    end

    if self.battle_ui then
        for _, party in ipairs(self.party) do
            party.chara:onTurnStart(party)
        end
    end

    if self.current_selecting ~= 0 and self.state ~= "ACTIONSELECT" then
        self:setState("ACTIONSELECT")
    end
end


--- Spawns the soul and sets up its transition from the source character to its starting position
---@param x? number
---@param y? number
function Battle:spawnSoul(x, y)
    local bx, by = self:getSoulLocation()
    local color = { self.encounter:getSoulColor() }

    self:addChild(HeartBurst(bx - 2, by + 1, color))

    if not self.soul then 
        self.soul = self.encounter:createSoul(bx, by, color)
        self.soul:transitionTo(x or SCREEN_WIDTH / 2, y or SCREEN_HEIGHT / 2)
        self.soul.target_alpha = self.soul.alpha
        self.soul.alpha = 0
        self:addChild(self.soul)
    end


    if not Game:getConfig("soulInvBetweenWaves") then
        -- There is technically one frame of invulnerability here, otherwise it would be `-1`
        Game:setInvulnFrames(0)
    end

    if self.state == "DEFENDINGBEGIN" or self.state == "DEFENDING" then
        self.soul:onWaveStart()
    end
end

--[[
function Battle:returnSoul(dont_destroy)
    if dont_destroy == nil then dont_destroy = false end
    local bx, by = self:getSoulLocation(true)
    for _, soul in ipairs({self.soul or false, self.soul_left or false, self.soul_right or false}) do
        Kristal.Console:push(tostring(soul))
        if soul then
            soul:transitionTo(bx - 2, by + 1, not dont_destroy)
        end
    end
end]]

return Battle