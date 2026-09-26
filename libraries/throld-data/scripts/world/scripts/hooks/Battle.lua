local Battle, super = HookSystem.hookScript(Battle)

function Battle:updateIntro()
	-- 等效于将入场时间延长约一倍，来保证小伞的入场动画正常播放完毕
	self.intro_timer = self.intro_timer - 0.45 * DTMULT
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
---@param key string
function Battle:onKeyPressed(key)
	if Kristal.isDevMode() and Input.ctrl() then
		if key == "h" then
			for _, party in ipairs(self.party) do
				party:heal(math.huge)
			end
		end
		if key == "y" then
			Input.clear(nil, true)
			self:setState("VICTORY")
		end
		if key == "m" then
			if self.music then
				if self.music:isPlaying() then
					self.music:pause()
				else
					self.music:resume()
				end
			end
		end
		if self.state == "DEFENDING" and key == "f" then
			self:endWaves()
		end
		if key == "b" then
			self:hurt(math.huge, true, "ALL")
		end
		if key == "k" then
			Game:setTension(Game:getMaxTension())
		end
		if key == "n" then
			NOCLIP = not NOCLIP
		end
	end

	if self.state == "MENUSELECT" then
		local menu_width = 2
		local menu_height = math.ceil(#self.menu_items / 2)

		if Input.isConfirm(key) then
			local menu_item = self.menu_items[self:getItemIndex()]
			local can_select = self:canSelectMenuItem(menu_item)
			if self.encounter:onMenuSelect(self.state_reason, menu_item, can_select) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattleMenuSelect, self.state_reason, menu_item, can_select) then return end
			if can_select then
				self.ui_select:stop()
				self.ui_select:play()
				menu_item["callback"](menu_item)
				return
			end
		elseif Input.isCancel(key) then
			local menu_item = self.menu_items[self:getItemIndex()]
			local can_select = self:canSelectMenuItem(menu_item)
			if self.encounter:onMenuCancel(self.state_reason, menu_item) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattleMenuCancel, self.state_reason, menu_item, can_select) then return end
			self.ui_move:stop()
			self.ui_move:play()
			Game:setTensionPreview(0)
			self:setState("ACTIONSELECT", "CANCEL")
			return
		elseif Input.is("left", key) then -- TODO: pagination
			self.current_menu_x = self.current_menu_x - 1
			if self.current_menu_x < 1 then
				self.current_menu_x = menu_width
				if not self:isValidMenuLocation() then
					self.current_menu_x = 1
				end
			end
		elseif Input.is("right", key) then
			self.current_menu_x = self.current_menu_x + 1
			if not self:isValidMenuLocation() then
				self.current_menu_x = 1
			end
		end
		if Input.is("up", key) then
			self.current_menu_y = self.current_menu_y - 1
			if self.current_menu_y < 1 then
				self.current_menu_y = 1 -- No wrapping in this menu.
			end
		elseif Input.is("down", key) then
			if self:getItemIndex() % 6 == 0 and #self.menu_items % 6 == 1 and self.current_menu_y == menu_height - 1 then
				self.current_menu_x = self.current_menu_x - 1
			end
			self.current_menu_y = self.current_menu_y + 1
			if (self.current_menu_y > menu_height) or (not self:isValidMenuLocation()) then
				self.current_menu_y = menu_height -- No wrapping in this menu.
				if not self:isValidMenuLocation() then
					self.current_menu_y = menu_height - 1
				end
			end
		end
	elseif self.state == "ENEMYSELECT" then
		if Input.isConfirm(key) then
			if self.encounter:onEnemySelect(self.state_reason, self.current_menu_y) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattleEnemySelect, self.state_reason, self.current_menu_y) then return end
			self.ui_select:stop()
			self.ui_select:play()
			if #self.enemies_index == 0 then return end
			self.selected_enemy = self.current_menu_y
			local enemy = self:_getEnemyByIndex(self.selected_enemy)
			if self.state_reason == "XACT" then
				local xaction = TableUtils.copy(self.selected_xaction)
				if xaction.default then
					xaction.name = enemy:getXAction(self.party[self.current_selecting])
				end
				self:pushAction("XACT", enemy, xaction)
			elseif self.state_reason == "SPARE" then
				self:pushAction("SPARE", enemy)
			elseif self.state_reason == "ACT" then
				self:clearMenuItems()
				for _, v in ipairs(enemy.acts) do
					local insert = not v.hidden
					if v.character and self.party[self.current_selecting].chara.id ~= v.character then
						insert = false
					end
					if v.party and (#v.party > 0) then
						for _, party_id in ipairs(v.party) do
							if not self:getPartyIndex(party_id) then
								insert = false
								break
							end
						end
					end
					if insert then
						self:addMenuItem({
							["name"] = v.name,
							["tp"] = v.tp or 0,
							["description"] = v.description,
							["party"] = v.party,
							["color"] = v.color or { 1, 1, 1, 1 },
							["highlight"] = v.highlight or enemy,
							["icons"] = v.icons,
							["callback"] = function(menu_item)
								self:pushAction("ACT", enemy, menu_item, nil, {
									["index"] = v.index
								})
							end
						})
					end
				end
				self:setState("MENUSELECT", "ACT")
			elseif self.state_reason == "ATTACK" then
				self:pushAction("ATTACK", enemy)
			elseif self.state_reason == "SPELL" then
				self:pushAction("SPELL", enemy, self.selected_spell)
			elseif self.state_reason == "ITEM" then
				self:pushAction("ITEM", enemy, self.selected_item)
			else
				self:nextParty()
			end
			return
		end
		if Input.isCancel(key) then
			if self.encounter:onEnemyCancel(self.state_reason, self.current_menu_y) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattleEnemyCancel, self.state_reason, self.current_menu_y) then return end
			self.ui_move:stop()
			self.ui_move:play()
			if self.state_reason == "SPELL" or self.state_reason == "XACT" then
				self:setState("MENUSELECT", "SPELL")
			elseif self.state_reason == "ITEM" then
				self:setState("MENUSELECT", "ITEM")
			else
				self:setState("ACTIONSELECT", "CANCEL")
			end
			return
		end
		if Input.is("up", key) then
			if #self.enemies_index == 0 then return end
			local old_location = self.current_menu_y
			local give_up = 0
			repeat
				give_up = give_up + 1
				if give_up > 100 then return end
				-- Keep decrementing until there's a selectable enemy.
				self.current_menu_y = self.current_menu_y - 1
				if self.current_menu_y < 1 then
					self.current_menu_y = #self.enemies_index
				end
			until self:_isEnemyByIndexSelectable(self.current_menu_y)

			if self.current_menu_y ~= old_location then
				self.ui_move:stop()
				self.ui_move:play()
			end
		elseif Input.is("down", key) then
			if #self.enemies_index == 0 then return end
			local old_location = self.current_menu_y
			local give_up = 0
			repeat
				give_up = give_up + 1
				if give_up > 100 then return end
				-- Keep decrementing until there's a selectable enemy.
				self.current_menu_y = self.current_menu_y + 1
				if self.current_menu_y > #self.enemies_index then
					self.current_menu_y = 1
				end
			until self:_isEnemyByIndexSelectable(self.current_menu_y)

			if self.current_menu_y ~= old_location then
				self.ui_move:stop()
				self.ui_move:play()
			end
		end
	elseif self.state == "PARTYSELECT" then
		if Input.isConfirm(key) then
			if self.encounter:onPartySelect(self.state_reason, self.current_menu_y) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattlePartySelect, self.state_reason, self.current_menu_y) then return end
			self.ui_select:stop()
			self.ui_select:play()
			if self.state_reason == "SPELL" then
				self:pushAction("SPELL", self.party[self.current_menu_y], self.selected_spell)
			elseif self.state_reason == "ITEM" then
				self:pushAction("ITEM", self.party[self.current_menu_y], self.selected_item)
			else
				self:nextParty()
			end
			return
		end
		if Input.isCancel(key) then
			if self.encounter:onPartyCancel(self.state_reason, self.current_menu_y) then return end
			if Kristal.callEvent(KRISTAL_EVENT.onBattlePartyCancel, self.state_reason, self.current_menu_y) then return end
			self.ui_move:stop()
			self.ui_move:play()
			if self.state_reason == "SPELL" then
				self:setState("MENUSELECT", "SPELL")
			elseif self.state_reason == "ITEM" then
				self:setState("MENUSELECT", "ITEM")
			else
				self:setState("ACTIONSELECT", "CANCEL")
			end
			return
		end
		if Input.is("up", key) then
			self.ui_move:stop()
			self.ui_move:play()
			self.current_menu_y = self.current_menu_y - 1
			if self.current_menu_y < 1 then
				self.current_menu_y = #self.party
			end
		elseif Input.is("down", key) then
			self.ui_move:stop()
			self.ui_move:play()
			self.current_menu_y = self.current_menu_y + 1
			if self.current_menu_y > #self.party then
				self.current_menu_y = 1
			end
		end
	elseif self.state == "BATTLETEXT" then
		-- Nothing here
	elseif self.state == "SHORTACTTEXT" then
		-- Nothing here
	elseif self.state == "ENEMYDIALOGUE" then
		-- Nothing here
	elseif self.state == "ACTIONSELECT" then
		self:handleActionSelectInput(key)
	elseif self.state == "ATTACKING" then
		self:handleAttackingInput(key)
	end
end

function Battle:beginAction(action)
	local battler = self.party[action.character_id]
	local enemy = action.target

	-- Add the action to the actions table, for group processing
	table.insert(self.current_actions, action)

	-- Set the state
	if self.state == "ACTIONS" then
		self:setSubState(action.action)
	end

	-- Call mod callbacks for adding new beginAction behaviour
	if Kristal.callEvent(KRISTAL_EVENT.onBattleActionBegin, action, action.action, battler, enemy) then
		return
	end

	if action.action == "ACT" then
		-- Play the ACT animation by default
		battler:setAnimation("battle/act")
		-- Enemies might change the ACT animation, so run onActStart here
		enemy:onActStart(battler, action.name, action.index)
	end
end

function Battle:processAction(action)
	local battler = self.party[action.character_id]
	local party_member = battler.chara
	local enemy = action.target

	self.current_processing_action = action

	local next_enemy = self:retargetEnemy()
	if not next_enemy then
		return true
	end

	if enemy and enemy.done_state then
		enemy = next_enemy
		action.target = next_enemy
	end

	-- Call mod callbacks for onBattleAction to either add new behaviour for an action or override existing behaviour
	-- Note: non-immediate actions require explicit "return false"!
	local callback_result = Kristal.modCall("onBattleAction", action, action.action, battler, enemy)
	if callback_result ~= nil then
		return callback_result
	end
	for lib_id, _ in Kristal.iterLibraries() do
		callback_result = Kristal.libCall(lib_id, "onBattleAction", action, action.action, battler, enemy)
		if callback_result ~= nil then
			return callback_result
		end
	end

	if action.action == "SPARE" then
		local worked = enemy:canSpare()

		local text = enemy:getSpareText(battler, worked)
		if text then
			self:battleText(text)
		end

		battler:setAnimation("battle/spare", function()
			enemy:onMercy(battler)
			if not worked then
				enemy:mercyFlash()
			end
			self:finishAction(action)
		end)

		return false

	elseif action.action == "ATTACK" or action.action == "AUTOATTACK" then
		local attacksound = battler.chara:getWeapon() and battler.chara:getWeapon():getAttackSound(battler, enemy, action.points) or battler.chara:getAttackSound()
		local attackpitch  = battler.chara:getWeapon() and battler.chara:getWeapon():getAttackPitch(battler, enemy, action.points) or battler.chara:getAttackPitch()
		local src = Assets.stopAndPlaySound(attacksound or "laz_c")
		assert(src, "Attempted to play non-existent attack sound \"" .. (attacksound or "laz_c") .. "\" for " .. battler.chara:getName())
		src:setPitch(attackpitch or 1)

		self.actions_done_timer = 1.2

		local crit = action.points == 150 and action.action ~= "AUTOATTACK"
		if crit then
			Assets.stopAndPlaySound("criticalswing")

			for i = 1, 3 do
				local sx, sy = battler:getRelativePos(battler.width, 0)
				local sparkle = Sprite("effects/criticalswing/sparkle", sx + MathUtils.random(50), sy + 30 + MathUtils.random(30))
				sparkle:play(4 / 30, true)
				sparkle:setScale(2)
				sparkle.layer = BATTLE_LAYERS["above_battlers"]
				sparkle.physics.speed_x = MathUtils.random(2, 6)
				sparkle.physics.friction = -0.25
				sparkle:fadeOutSpeedAndRemove()
				self:addChild(sparkle)
			end
		end

		battler:setAnimation("battle/attack", function()
			action.icon = nil

			if action.target and action.target.done_state then
				enemy = self:retargetEnemy()
				action.target = enemy
				if not enemy then
					self.cancel_attack = true
					self:finishAction(action)
					return
				end
			end

			local damage = MathUtils.round(enemy:getAttackDamage(action.damage or 0, battler, action.points or 0))
			if damage < 0 then
				damage = 0
			end

			if damage > 0 then
				Game:giveTension(MathUtils.round(enemy:getAttackTension(action.points or 100)))

				local attacksprite = battler.chara:getWeapon() and battler.chara:getWeapon():getAttackSprite(battler, enemy, action.points) or battler.chara:getAttackSprite()
				local dmg_sprite = Sprite(attacksprite or "effects/attack/cut")
				dmg_sprite:setOrigin(0.5, 0.5)
				if crit then
					dmg_sprite:setScale(2.5, 2.5)
				else
					dmg_sprite:setScale(2, 2)
				end
				local relative_pos_x, relative_pos_y = enemy:getRelativePos(enemy.width / 2, enemy.height / 2)
				dmg_sprite:setPosition(relative_pos_x + enemy.dmg_sprite_offset[1], relative_pos_y + enemy.dmg_sprite_offset[2])
				dmg_sprite.layer = enemy.layer + 0.01
				dmg_sprite.battler_id = action.character_id or nil
				table.insert(enemy.dmg_sprites, dmg_sprite)
				local dmg_anim_speed = 1 / 15
				if attacksprite == "effects/attack/shard" then
					-- Ugly hardcoding BlackShard animation speed accuracy for now
					dmg_anim_speed = 1 / 10
				end
				dmg_sprite:play(dmg_anim_speed, false, function(s) s:remove(); TableUtils.removeValue(enemy.dmg_sprites, dmg_sprite) end) -- Remove itself and Remove the dmg_sprite from the enemy's dmg_sprite table when its removed
				enemy.parent:addChild(dmg_sprite)

				local sound = enemy:getDamageSound() or "damage"
				if sound and type(sound) == "string" then
					Assets.stopAndPlaySound(sound)
				end
				enemy:hurt(damage, battler)

				-- TODO: Call this even if damage is 0, will be a breaking change
				battler.chara:onAttackHit(enemy, damage)
			else
				enemy:hurt(0, battler, nil, nil, nil, action.points ~= 0)
			end

			for _, item in ipairs(battler.chara:getEquipment()) do
				item:onAttackHit(battler, enemy, damage)
			end

			self:finishAction(action)

			TableUtils.removeValue(self.normal_attackers, battler)
			TableUtils.removeValue(self.auto_attackers, battler)

			if not self:retargetEnemy() then
				self.cancel_attack = true
			elseif #self.normal_attackers == 0 and #self.auto_attackers > 0 then
				local next_attacker = self.auto_attackers[1]

				local next_action = self:getActionBy(next_attacker, true)
				if next_action then
					self:beginAction(next_action)
					self:processAction(next_action)
				end
			end
		end)

		return false

	elseif action.action == "ACT" then
		-- fun fact: this would have only been a single function call
		-- if stupid multi-acts didn't exist

		-- Check for other short acts
		local self_short = false
		self.short_actions = {}
		for _, iaction in ipairs(self.current_actions) do
			if iaction.action == "ACT" then
				local ibattler = self.party[iaction.character_id]
				local ienemy = iaction.target

				if ienemy then
					local act = ienemy and (ienemy:getIndexAct(iaction.index) or ienemy:getAct(iaction.name))

					if (act and act.short) or (ienemy:getXAction(ibattler) == iaction.name and ienemy:isXActionShort(ibattler)) then
						table.insert(self.short_actions, iaction)
						if ibattler == battler then
							self_short = true
						end
					end
				end
			end
		end

		if self_short and #self.short_actions > 1 then
			local short_text = {}
			for _, iaction in ipairs(self.short_actions) do
				local ibattler = self.party[iaction.character_id]
				local ienemy = iaction.target

				local act_text = ienemy:onShortAct(ibattler, iaction.name, iaction.index)
				if act_text then
					table.insert(short_text, act_text)
				end
			end

			self:shortActText(short_text)
		else
			local text = enemy:onAct(battler, action.name, action.index)
			if text then
				self:setActText(text)
			end
		end

		return false

	elseif action.action == "SKIP" then
		return true

	elseif action.action == "SPELL" then
		self.battle_ui:clearEncounterText()

		-- The spell itself handles the animation and finishing
		action.data:onStart(battler, action.target)

		return false

	elseif action.action == "ITEM" then
		local item = action.data
		if item.instant then
			self:finishAction(action)
		else
			local text = item:getBattleText(battler, action.target)
			if text then
				self:battleText(text)
			end
			battler:setAnimation("battle/item", function()
				local result = item:onBattleUse(battler, action.target)
				if result or result == nil then
					self:finishAction(action)
				end
			end)
		end
		return false

	elseif action.action == "DEFEND" then
		battler:setAnimation("battle/defend")
		battler.defending = true
		return false

	else
		-- we don't know how to handle this...
		Kristal.Console:warn("Unhandled battle action: " .. tostring(action.action))
		return true
	end
end

return Battle