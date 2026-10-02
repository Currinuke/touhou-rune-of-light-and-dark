---@class DoubleSoul : Soul
---
---
---@field allow_swap        boolean		 Whether the child souls are allowed to swap themselves
---@field can_swap          boolean		 *(Used internally)* Whether the soul is currently in a transition
---@field timer_swap        number		  *(Used internally)* A timer for the soul swapping

local DoubleSoul, super = Class(Soul)

function DoubleSoul:init(x, y, color)
	super.init(self, x, y, color)
	self.alpha = 0
	self.can_swap = true
	self.timer_swap = 0
	self.timer_swap_max = 30

	self.swap_sfx = Assets.getSound("doublesoul/transition")
	--self.swap_sfx:setLooping(true)
	self.swap_sfx_finished = "noise"

	self.offset_default = Kristal.getLibConfig("throld-doublesoul", "defaultOffset") or 100
	self.double_offset = self.offset_default

	self.souls = {
		left = ChildSoul(-self.double_offset, 0, {0, 1, 1}, -self.double_offset, "left", "player/heart_dodge_left", "player/heart_dodge_right"),
		right = ChildSoul(self.double_offset, 0, {1, 0, 0}, self.double_offset, "right", "player/heart_dodge_right", "player/heart_dodge_left")
	}

	self.collider = ColliderGroup(self, {
		CircleCollider(self, -self.double_offset, 0, 8),
		CircleCollider(self, self.double_offset, 0, 8)
	})
end

function DoubleSoul:onRemoveFromStage(stage)
	super.onRemove(self, stage)
	if self.swap_sfx then
		self.swap_sfx:stop()
		self.swap_sfx = nil
	end
end

--[[
--- *(Override)* Called when waves are started
function DoubleSoul:onWaveStart()

end--]]
--[[
--- Shatters the soul into several shards \
--- The position of the shards are controlled by [`shard_x_table`](lua://Soul.shard_x_table) and [`shard_y_table`](lua://Soul.shard_y_table)
---@param count integer The number of shards that the soul should shatter into.
function DoubleSoul:shatter(count)
	Assets.playSound("break2")

	local shard_count = count or 6

	self.shards = {}
	for i = 1, shard_count do
		local x_pos = self.shard_x_table[((i - 1) % #self.shard_x_table) + 1]
		local y_pos = self.shard_y_table[((i - 1) % #self.shard_y_table) + 1]
		local shard = Sprite("player/heart_shard", self.x + x_pos, self.y + y_pos)
		shard:setColor(self:getColor())
		shard.physics.direction = math.rad(MathUtils.random(360))
		shard.physics.speed = 7
		shard.physics.gravity = 0.2
		shard.layer = self.layer
		shard:play(5 / 30)
		table.insert(self.shards, shard)
		self.stage:addChild(shard)
	end

	self:remove()
	Game.battle.soul = nil
end

---@param x				 number  x-coordinate of the end point of the transition
---@param y				 number  y-coordinate of the end point of the transition
---@param should_destroy?   boolean Whether the soul should be removed during this transition
--]]
function DoubleSoul:transitionTo(x, y, should_destroy)
	super.transitionTo(self, x, y, should_destroy)
	self.souls.left:transitionTo(x, y, should_destroy)
	self.souls.right:transitionTo(x, y, should_destroy)
end

function DoubleSoul:getExactPosition(x, y, target) --没用的代码
	if target then
		if type(target) == "string" then
			if target == "left" then
				return self.x - self.double_offset + self.partial_x, self.y + self.partial_y
			elseif target == "right" then
				return self.x + self.double_offset + self.partial_x, self.y + self.partial_y
			end
		end
	end

	return super.getExactPosition(self, x, y)
end

--- *(Override)* Called when the soul takes damage
---@param bullet Bullet
---@param amount integer

--[[function DoubleSoul:onDamage(bullet, amount)
	-- Can be overridden, called when the soul actually takes damage from a bullet
	--[[
	for _, battler in ipairs(Game.battle.party) do
		if not battler.is_down then
			return
		end
	end
end--]]

--- *(Override)* Called when the soul collides with a bullet and before taking damage \
--- By default, this function is responsible for calling the bullet's collision check, [`Bullet:onCollide()`](lua://Bullet.onCollide)
---@param bullet Bullet
function DoubleSoul:onCollide(bullet)
	self.swap_sfx:stop()
	-- Handles damage
	bullet:onCollide(self)
end
--[[
--- *(Override)* Called when the soul is squished between two solids \
--- By default, this function is responsible for calling the solid's [`Solid:onSquished`](lua:///Solid.onSquished)
---@param solid Solid
function DoubleSoul:onSquished(solid)
	-- Called when the soul is squished by a solid
	solid:onSquished(self)
end

--- *(Override)* Called when the soul grazes something.
---@param bullet Bullet
---@param old_graze boolean
function DoubleSoul:onGraze(bullet, old_graze) end

--- *(Override)* Whether the soul should decrease the invulnerability timer.
---
--- By default, this returns `true` unless the soul is currently transitioning.
---@return boolean decrease_invuln # `true` if the invulnerability timer should decrease.
function DoubleSoul:shouldDecreaseInvuln()
	return not self.transitioning
end]]

function DoubleSoul:doDoubleSwap()
	local offsets = {}

	for name, soul in pairs(self.souls) do
		offsets[name] = soul.offset_default
	end

	for name, soul in pairs(self.souls) do
		local offset = offsets[name]
		if name == "left" then
			offset = offsets["right"]
		elseif name == "right" then
			offset = offsets["left"]
		end
		soul:doDoubleSwap(offset)
	end

	local colliders = {}

	for _, soul in pairs(self.souls) do
		table.insert(colliders, CircleCollider(self, soul.offset, 0, 8))
	end

	self.collider = ColliderGroup(self, colliders)
end

function DoubleSoul:doMovement()
	super.doMovement(self)

	-- 转换灵魂
	if not self.transitioning and Input.down("confirm") then
		if self.can_swap then
			self.timer_swap = (self.timer_swap or 0) + DTMULT

			if self.timer_swap >= 30 then
				self.can_swap = false
				self:doDoubleSwap()
				self.timer_swap = 0

				self.swap_sfx:stop()
				Assets.playSound(self.swap_sfx_finished)

				local bx, by = Game.battle:getSoulLocation()
				for _, soul in pairs(self.souls) do
					Game.battle:addChild(DoubleSwapEffect(bx + soul.offset, by))
				end
			else
				self.swap_sfx:setVolume(MathUtils.clamp(self.timer_swap/15, 0, 1))
				if not self.swap_sfx:isPlaying() then
					self.swap_sfx:play()
				end
			end
		end
	else
		self.timer_swap = 0
		self.can_swap = true
		self.swap_sfx:stop()
	end

	self.souls.left.x, self.souls.left.y = self.x + self.souls.left.offset, self.y
	self.souls.right.x, self.souls.right.y = self.x + self.souls.right.offset, self.y
	self.souls.left.mask_sprite:setColor(1, 1, 1, self.timer_swap / 30)
	self.souls.right.mask_sprite:setColor(1, 1, 1, self.timer_swap / 30)
end

function DoubleSoul:update()
	if self.transitioning then
		for _, soul in pairs(self.souls) do
			soul.mask_sprite:setColor(1, 1, 1, 0)
		end

		if self.swap_sfx then
			self.swap_sfx:stop()
		end

		if self.transition_destroy then
			for _, soul in pairs(self.souls) do
				soul.offset = soul.offset_default * (1 - self.timer / 7)
			end
		else
			for _, soul in pairs(self.souls) do
				soul.offset = soul.offset_default * self.timer / 7
			end
		end

		if self.timer >= 7 then
			Input.clear("cancel")
			self.timer = 0
			if self.transition_destroy then
				Game.battle:addChild(HeartBurst(self.target_x, self.target_y, { Game:getSoulColor() }))
				self:remove()
			else
				self.transitioning = false
				self:setExactPosition(self.target_x, self.target_y)
				for _, soul in pairs(self.souls) do
					soul.offset = soul.offset_default
				end
			end
		else
			self:setExactPosition(
				MathUtils.lerp(self.original_x, self.target_x, MathUtils.clamp(self.timer / 7, 0, 1)),
				MathUtils.lerp(self.original_y, self.target_y, MathUtils.clamp(self.timer / 7, 0, 1))
			)
			self.alpha = MathUtils.lerp(0, self.target_alpha or 1, MathUtils.clamp(self.timer / 3, 0, 1))
			-- self.sprite:setColor(self.color[1], self.color[2], self.color[3], self.alpha)
			self.timer = self.timer + (1 * DTMULT)
		end

		--[[
		for _, soul in pairs(self.souls) do
			soul.sprite:setOrigin(0.5 - soul.offset / 20, 0.5)
			soul.graze_sprite:setOrigin(0.5 - soul.offset / 50, 0.5)
			soul.mask_sprite:setOrigin(0.5 - soul.offset / 20, 0.5)
		end]]

		return
	end

	if self.can_move then
		self:doMovement()
	end

	if Game.inv_frames then
		for _, soul in pairs(self.souls) do
			if soul.inv_timer > 0 then
				local amt = math.floor(soul.inv_flash_timer / (4 / 30))
				if (amt % 2) == 1 then
					soul.mask_sprite:setColor(0.5, 0.5, 0.5)
				else
					soul.mask_sprite:setColor(1, 1, 1)
				end
			else
				soul.inv_flash_timer = 0
				soul.mask_sprite:setColor(1, 1, 1)
			end
		end
	end

	for _, soul in pairs(self.souls) do
		soul:update()
	end
end


function DoubleSoul:draw()
	for _, soul in pairs(self.souls) do
		soul.sprite:setOrigin(0.5 - soul.offset / 20, 0.5)
		soul.graze_sprite:setOrigin(0.5 - soul.offset / 50, 0.5)
		soul.mask_sprite:setOrigin(0.5 - soul.offset / 20, 0.5)
		soul:draw()
	end

	if DEBUG_RENDER then
		self.collider:draw(0, 1, 0, 0.33)
		self.souls.left.collider:draw(0, 1, 1, 0.33)
		self.souls.right.collider:draw(1, 0, 0, 0.33)
		self.souls.left.graze_collider:draw(0, 1, 1, 0.33)
		self.souls.right.graze_collider:draw(1, 0, 0, 0.33)
	end
end

return DoubleSoul