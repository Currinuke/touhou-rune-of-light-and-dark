local DoubleSoul, super = Class(Soul)

function DoubleSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.alpha = 0
    self.swapped = false
    self.can_swap = true
    self.swap_timer = 0
    self.swap_timer_max = 30

    self.transition_sfx = Assets.getSound("doublesoul/transition")
    --self.transition_sfx:setLooping(true)
    self.finished_name = "noise"

    self.default_offset = Kristal.getLibConfig("throld-doublesoul", "defaultOffset") or 100
    self.double_offset = self.default_offset
    self.double_left = LeftSoul(x - self.double_offset, y, color)
    self.double_right = RightSoul(x + self.double_offset, y, color)

    self.collider = ColliderGroup(self, {
        CircleCollider(self, -self.double_offset, 0, 8),
        CircleCollider(self, self.double_offset, 0, 8)
    })
end

--[[
function DoubleSoul:onRemove(parent)
    if self.transition_sfx then
        --if self.transition_sfx:isPlaying() then
            self.transition_sfx:stop()
        --end
        
    end

    super.super.onRemove(self, parent)
end--]]

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

---@param x                 number  x-coordinate of the end point of the transition
---@param y                 number  y-coordinate of the end point of the transition
---@param should_destroy?   boolean Whether the soul should be removed during this transition
--]]
function DoubleSoul:transitionTo(x, y, should_destroy)
    super.transitionTo(self, x, y, should_destroy)
    self.double_left:transitionTo(x, y, should_destroy)
    self.double_right:transitionTo(x, y, should_destroy)
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

--- Sets the soul's exact position (including a fractional part)
---@param x number
---@param y number
--[[
function DoubleSoul:setExactPosition(x, y)
    self.x = math.floor(x)
    self.partial_x = x - self.x
    self.y = math.floor(y)
    self.partial_y = y - self.y
end--]]

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
    self.transition_sfx:stop()
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

function DoubleSoul:doMovement()
    super.doMovement(self)

    -- 转换灵魂
    if not self.transitioning and Input.down("confirm") then
        if self.can_swap then
            self.swap_timer = self.swap_timer + DTMULT

            if self.swap_timer >= 30 then
                self.can_swap = false
                self.swapped = not self.swapped
                self.double_left:onSwap(self.swapped)
                self.double_right:onSwap(self.swapped)
                self.swap_timer = 0

                self.transition_sfx:stop()
                Assets.playSound(self.finished_name)

                local bx, by = Game.battle:getSoulLocation()
                 -- self:addChild(DoubleSwapEffect(bx - self.double_offset, by))
                -- self:addChild(DoubleSwapEffect(bx + self.double_offset, by))
                DoubleSwapEffect(bx - self.double_offset, by)
                DoubleSwapEffect(bx + self.double_offset, by)
                -- AfterImage(bx + self.double_offset, by)
                -- HeartBurst(bx - self.double_offset, by, {1, 1, 1, 1})
                -- HeartBurst(bx + self.double_offset, by, {1, 1, 1, 1})
            else
                self.transition_sfx:setVolume(MathUtils.clamp(self.swap_timer/15, 0, 1))
                if not self.transition_sfx:isPlaying() then
                    self.transition_sfx:play()
                end
            end
        end
    else
        self.swap_timer = 0
        self.can_swap = true
        self.transition_sfx:stop()
    end

    self.double_left.x, self.double_left.y = self.x - self.double_offset, self.y
    self.double_right.x, self.double_right.y = self.x + self.double_offset, self.y
    self.double_left.mask_sprite:setColor(1, 1, 1, self.swap_timer / 30)
    self.double_right.mask_sprite:setColor(1, 1, 1, self.swap_timer / 30)
end

function DoubleSoul:update()
    if self.transitioning then
        self.double_left.mask_sprite:setColor(1, 1, 1, 0)
        self.double_right.mask_sprite:setColor(1, 1, 1, 0)

        if self.transition_sfx then
            self.transition_sfx:stop()
        end

        if self.transition_destroy then
            self.double_offset = self.default_offset * (1 - self.timer / 7)
        else
            self.double_offset = self.default_offset * self.timer / 7
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
                self.double_offset = self.default_offset
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

        self.double_left.sprite:setOrigin(0.5 + self.double_offset / 20, 0.5)
        self.double_left.graze_sprite:setOrigin(0.5 + self.double_offset / 50, 0.5)
        self.double_left.mask_sprite:setOrigin(0.5 + self.double_offset / 20, 0.5)

        self.double_right.sprite:setOrigin(0.5 - self.double_offset / 20, 0.5)
        self.double_right.graze_sprite:setOrigin(0.5 - self.double_offset / 50, 0.5)
        self.double_right.mask_sprite:setOrigin(0.5 - self.double_offset / 20, 0.5)
        return
    end

    if self.can_move then
        self:doMovement()
    end

    if Game.inv_frames then
        for _, soul in ipairs({self.double_left, self.double_right}) do
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

    self.double_left:update()
    self.double_right:update()
end


function DoubleSoul:draw()
    self.double_left:draw()
    self.double_right:draw()

    if DEBUG_RENDER then
        self.collider:draw(0, 1, 0, 0.33)
        self.double_left.collider:draw(0, 1, 1, 0.33)
        self.double_right.collider:draw(1, 0, 0, 0.33)
        self.double_left.graze_collider:draw(0, 1, 1, 0.33)
        self.double_right.graze_collider:draw(1, 0, 0, 0.33)
    end
end

return DoubleSoul