local Battle, super = HookSystem.hookScript(Battle)

function Battle:updateIntro()
    -- 等同于将入场时间延长一倍，来保证小伞的入场动画正常播放完毕
    self.intro_timer = self.intro_timer - 0.5 * DTMULT
    super.updateIntro(self)
end

function Battle:powerAct(spell, battler, user, target)

    local user_battler = self:getPartyBattler(user)
    local user_index = self:getPartyIndex(user)

    if user_battler == nil then
        Kristal.Console:error("Invalid power act user: " .. tostring(user))
        return
    end

    if type(spell) == "string" then
        spell = Registry.createSpell(spell)
    end

    local menu_item = {
        data = spell,
        tp = 0
    }

    if target == nil then
        if spell:getTarget() == "ally" then
            target = user_battler
        elseif spell:getTarget() == "party" then
            target = self.party
        elseif spell:getTarget() == "enemy" then
            target = self:getActiveEnemies()[1]
        elseif spell:getTarget() == "enemies" then
            target = self:getActiveEnemies()
        end
    end

    local name = user_battler.chara:getName():upper()
    if name == "SUSIE" then
        -- deltarune inconsistency lol
        name = "Susie"
    end

    -- 替换为角色的全名
    if user_battler.chara.id == "kogasa" then
        name = Game:locText("[name:tatara_kogasa]"):upper()
    elseif user_battler.chara.id == "seija" then
        name = Game:locText("[name:kijin_seija]"):upper()
    elseif user_battler.chara.id == "rin" then
        name = Game:locText("[name:satsuki_rin]"):upper()
    end

    self:setActText(Game:loc("battle_powerAct", {userName = name}), true)

    self.timer:after(7 / 30, function()
        Assets.playSound("boost")
        battler:flash()
        user_battler:flash()
        local bx, by = self:getSoulLocation()
        local soul = Sprite("effects/soulshine", bx + 5.5, by)
        soul:play(1 / 30, false, function() soul:remove() end)
        soul:setOrigin(0.5)
        soul:setScale(2, 2)
        self:addChild(soul)
    end)

    self.timer:after(24 / 30, function()
        self:pushAction("SPELL", target, menu_item, user_index)
        self:markAsFinished(nil, { user })
    end)
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
            if box.battler.chara.id == "seija" then box.selected_button = #box:getSelectableButtons() end
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

function Battle:hurt(amount, exact, target, swoon)
    -- If target is a numberic value, it will hurt the party battler with that index
    -- "ANY" will choose the target randomly
    -- "ALL" will hurt the entire party all at once
    target = target or "ANY"

    -- Alright, first let's try to adjust targets.

    if type(target) == "number" then
        target = self.party[target]
    end

    if isClass(target) and target:includes(PartyBattler) then
        if (not target) or (target.chara:getHealth() <= 0) then -- Why doesn't this look at :canTarget()? Weird.
            target = self:randomTargetOld()
        end
    end

    if target == "ANY" then
        target = self:randomTargetOld()

        if isClass(target) and target:includes(PartyBattler) then
            -- Calculate the average HP of the party.
            -- This is "scr_party_hpaverage", which gets called multiple times in the original script.
            -- We'll only do it once here, just for the slight optimization. This won't affect accuracy.

            -- Speaking of accuracy, this function doesn't work at all!
            -- It contains a bug which causes it to always return 0, unless all party members are at full health.
            -- This is because of a random floor() call.
            -- I won't bother making the code accurate; all that matters is the output.

            local party_average_hp = 1

            for _, battler in ipairs(self.party) do
                if battler.chara:getHealth() ~= battler.chara:getStat("health") then
                    party_average_hp = 0
                    break
                end
            end

            -- Retarget... twice.
            if target.chara:getHealth() / target.chara:getStat("health") < (party_average_hp / 2) then
                target = self:randomTargetOld()
            end
            if target.chara:getHealth() / target.chara:getStat("health") < (party_average_hp / 2) then
                target = self:randomTargetOld()
            end

            -- If we landed on Kris (or, well, the first party member), and their health is low, retarget (plot armor lol)
            if (target == self.party[1]) and ((target.chara:getHealth() / target.chara:getStat("health")) < 0.35) then
                target = self:randomTargetOld()
            end

            -- They got hit, so un-darken them
            target.should_darken = false
            target.targeted = true
        end
    end

    -- Now it's time to actually damage them!
    if isClass(target) and target:includes(PartyBattler) then
        -- 这里插入一段检查代码
        if target.chara:getFlag("evilundulations_have", 0) > 0 then
            Assets.playSound("hurt")
            Game.battle:shakeCamera(4)
            target:statusMessage("damage", 0, nil, true)
            target.chara:addFlag("evilundulations_have", -1)
        else
            target:hurt(amount, exact, nil, { swoon = self.encounter:canSwoon(target) and swoon })
        end
        return { target }
    end

    if target == "ALL" then
        Assets.playSound("hurt")
        local alive_battlers = TableUtils.filter(self.party, function(battler) return not battler.is_down end)
        for _, battler in ipairs(alive_battlers) do
            battler:hurt(amount, exact, nil, { all = true, swoon = self.encounter:canSwoon(battler) and swoon })
        end
        -- Return the battlers who aren't down, aka the ones we hit.
        return alive_battlers
    end
end

return Battle