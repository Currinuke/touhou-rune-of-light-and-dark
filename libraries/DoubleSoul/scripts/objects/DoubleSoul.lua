local DoubleSoul, super = Class(Soul)

function DoubleSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.swapped = false
    self.can_swap = true
    self.swap_timer = 0
    self.swap_timer_max = 30
    self.color = {1, 1, 1, 0}
    self.charge_sfx = Assets.getSound("chargeshot_charge")

    self.double_offset = 100

    self.double_left = LeftSoul(x - self.double_offset, y, color)
    self.double_right = RightSoul(x + self.double_offset, y, color)
    self.collider = ColliderGroup(self, {
        CircleCollider(self, -self.double_offset, 0, 8),
        CircleCollider(self, self.double_offset, 0, 8)
    })
end

function DoubleSoul:onRemove(parent)
    super.onRemove(self, parent)

    if parent == Game.battle and Game.battle.soul == self then
        if self.charge_sfx:isPlaying() then
            self.charge_sfx:stop()
        end
        Game.battle.soul = nil
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

---@param x                 number  x-coordinate of the end point of the transition
---@param y                 number  y-coordinate of the end point of the transition
---@param should_destroy?   boolean Whether the soul should be removed during this transition
--]]
function DoubleSoul:transitionTo(x, y, should_destroy)
    super.transitionTo(self, x, y, should_destroy)
    self.double_left:transitionTo(x, y, should_destroy)
    self.double_right:transitionTo(x, y, should_destroy)
end
--[[
---@return boolean
function DoubleSoul:isMoving()
    return self.moving_x ~= 0 or self.moving_y ~= 0
end

--- Gets the soul's exact position (including the fractional part) \
--- *The soul's `x` and `y` values are truncated so this must be used for the soul's exact position*
---@param x number
---@param y number
---@return number exact_x
---@return number exact_y
function DoubleSoul:getExactPosition(x, y)
    return self.x + self.partial_x, self.y + self.partial_y
end

--- Sets the soul's exact position (including a fractional part)
---@param x number
---@param y number
function DoubleSoul:setExactPosition(x, y)
    self.x = math.floor(x)
    self.partial_x = x - self.x
    self.y = math.floor(y)
    self.partial_y = y - self.y
end]]

--- Moves the soul by `x` and `y`, accounting for collision in the soul's movement path
---@param x?     number
---@param y?     number
---@param speed? number An optional multiplier to the amount of `x` and `y` that the soul moves by.
---@return boolean  moved       Whether the soul moved from its previous position
---@return boolean  collided    Whether the soul collided with something on its movement path

function DoubleSoul:move(x, y, speed)
    local movex, movey = x * (speed or 1), y * (speed or 1)

    local mxa, mxb = self:moveX(movex, movey)
    -- self.double_left:moveX(movex, movey)
    -- self.double_right:moveX(movex, movey)
    local mya, myb = self:moveY(movey, movex)
    -- self.double_left:moveY(movey, movex)
    -- self.double_right:moveY(movey, movex)

    if not self.transitioning then
        self.double_left.x, self.double_left.y = self.x - self.double_offset, self.y
        self.double_right.x, self.double_right.y = self.x + self.double_offset, self.y
    end

    local moved = (mxa and not mxb) or (mya and not myb)
    local collided = (not mxa and not mxb) or (not mya and not myb)

    return moved, collided
end
--[[
--- *(Used internally)* Performs collision abiding movement of the soul along the x-axis
---@param amount number
---@param move_y number
---@return boolean
---@return boolean?
function DoubleSoul:moveX(amount, move_y)
    local last_collided = self.last_collided_x and (MathUtils.sign(amount) == self.last_collided_x)

    if amount == 0 then
        return not last_collided, true
    end

    self.partial_x = self.partial_x + amount

    local move = math.floor(self.partial_x)
    self.partial_x = self.partial_x % 1

    if move ~= 0 then
        local moved = self:moveXExact(move, move_y)
        return moved
    else
        return not last_collided
    end
end

--- *(Used internally)* Performs collision abiding movement of the soul along the y-axis
---@param amount number
---@param move_x number
---@return boolean
---@return boolean?
function DoubleSoul:moveY(amount, move_x)
    local last_collided = self.last_collided_y and (MathUtils.sign(amount) == self.last_collided_y)

    if amount == 0 then
        return not last_collided, true
    end

    self.partial_y = self.partial_y + amount

    local move = math.floor(self.partial_y)
    self.partial_y = self.partial_y % 1

    if move ~= 0 then
        local moved = self:moveYExact(move, move_x)
        return moved
    else
        return not last_collided
    end
end

--- *(Used internally)* Performs collision abiding movement of the soul on the x-axis
---@param amount number
---@param move_y number
---@return boolean
---@return Arena?
function DoubleSoul:moveXExact(amount, move_y)
    local sign = MathUtils.sign(amount)
    for i = sign, amount, sign do
        local last_x = self.x
        local last_y = self.y

        self.x = self.x + sign

        if not self.noclip then
            Object.uncache(self)
            Object.startCache()
            local collided, target = Game.battle:checkSolidCollision(self)
            if self.slope_correction then
                if collided and not (move_y > 0) then
                    for j = 1, 2 do
                        Object.uncache(self)
                        self.y = self.y - 1
                        collided, target = Game.battle:checkSolidCollision(self)
                        if not collided then break end
                    end
                end
                if collided and not (move_y < 0) then
                    self.y = last_y
                    for j = 1, 2 do
                        Object.uncache(self)
                        self.y = self.y + 1
                        collided, target = Game.battle:checkSolidCollision(self)
                        if not collided then break end
                    end
                end
            end
            Object.endCache()

            if collided then
                self.x = last_x
                self.y = last_y

                if target and target.onCollide then
                    target:onCollide(self)
                end

                self.last_collided_x = sign
                return false, target
            end
        end
    end
    self.last_collided_x = 0
    return true
end

--- *(Used internally)* Performs collision abiding movment of the soul on the y-axis
---@param amount number
---@param move_x number
---@return boolean
---@return Arena?
function DoubleSoul:moveYExact(amount, move_x)
    local sign = MathUtils.sign(amount)
    for i = sign, amount, sign do
        local last_x = self.x
        local last_y = self.y

        self.y = self.y + sign

        if not self.noclip then
            Object.uncache(self)
            Object.startCache()
            local collided, target = Game.battle:checkSolidCollision(self)
            if self.slope_correction then
                if collided and not (move_x > 0) then
                    for j = 1, 2 do
                        Object.uncache(self)
                        self.x = self.x - 1
                        collided, target = Game.battle:checkSolidCollision(self)
                        if not collided then break end
                    end
                end
                if collided and not (move_x < 0) then
                    self.x = last_x
                    for j = 1, 2 do
                        Object.uncache(self)
                        self.x = self.x + 1
                        collided, target = Game.battle:checkSolidCollision(self)
                        if not collided then break end
                    end
                end
            end
            Object.endCache()

            if collided then
                self.x = last_x
                self.y = last_y

                if target and target.onCollide then
                    target:onCollide(self)
                end

                self.last_collided_y = sign
                return i ~= sign, target
            end
        end
    end
    self.last_collided_y = 0
    return true
end--]]

--- *(Override)* Called when the soul takes damage
---@param bullet Bullet
---@param amount integer
function DoubleSoul:onDamage(bullet, amount)
    -- Can be overridden, called when the soul actually takes damage from a bullet
end

--- *(Override)* Called when the soul collides with a bullet and before taking damage \
--- By default, this function is responsible for calling the bullet's collision check, [`Bullet:onCollide()`](lua://Bullet.onCollide)
---@param bullet Bullet
function DoubleSoul:onCollide(bullet)
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

--- Called every frame from within [`Soul:update()`](lua://Soul.update) if the soul is able to move. \
--- Movement for the soul based on player input should be controlled within this method.
--[[
function DoubleSoul:doMovement()
    local speed = self.speed

    -- Do speed calculations here if required.

    if self.allow_focus then
        if Input.down("cancel") then speed = speed / 2 end -- Focus mode.
    end

    local move_x, move_y = 0, 0

    -- Keyboard input:
    if Input.down("left") then move_x = move_x - 1 end
    if Input.down("right") then move_x = move_x + 1 end
    if Input.down("up") then move_y = move_y - 1 end
    if Input.down("down") then move_y = move_y + 1 end

    self.moving_x = move_x
    self.moving_y = move_y

    if move_x ~= 0 or move_y ~= 0 then
        if not self:move(move_x, move_y, speed * DTMULT) then
            self.moving_x = 0
            self.moving_y = 0
        end
    end


end]]

function DoubleSoul:update()
    if self.transitioning then
        self.swap_timer = 0
        if self.charge_sfx:isPlaying() then
            self.charge_sfx:stop()
        end

        if self.transition_destroy then
            self.double_offset = 100 - 100 * self.timer / 7
        else
            self.double_offset = 100 * self.timer / 7
        end

        self.double_left.sprite:setOrigin(0.5 + self.double_offset / 20, 0.5)
        self.double_left.graze_sprite:setOrigin(0.5 + self.double_offset / 50, 0.5)
        self.double_left.mask_sprite:setOrigin(0.5 + self.double_offset / 20, 0.5)

        self.double_right.sprite:setOrigin(0.5 - self.double_offset / 20, 0.5)
        self.double_right.graze_sprite:setOrigin(0.5 - self.double_offset / 50, 0.5)
        self.double_right.mask_sprite:setOrigin(0.5 - self.double_offset / 20, 0.5)

        if self.timer >= 7 then
            Input.clear("cancel")
            self.timer = 0
            if self.transition_destroy then
                Game.battle:addChild(HeartBurst(self.target_x, self.target_y, { Game:getSoulColor() }))
                self:remove()
            else
                self.transitioning = false
                self:setExactPosition(self.target_x, self.target_y)
                self.double_offset = 100
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
        return
    end

    -- swap判定
    if self.can_move then
        if not self.transitioning and Input.down("confirm") then
            if self.can_swap then
                self.swap_timer = self.swap_timer + DTMULT

                if self.swap_timer >= 30 then
                    self.can_swap = false
                    self.swapped = not self.swapped
                    self.double_left:onSwap(self.swapped)
                    self.double_right:onSwap(self.swapped)
                    self.swap_timer = 0

                    if self.charge_sfx:isPlaying() then
                        self.charge_sfx:stop()
                    end
                    Assets.playSound("noise")

                    local bx, by = Game.battle:getSoulLocation()
                    self:addChild(DoubleSwapEffect(bx - 60, by))
                    self:addChild(DoubleSwapEffect(bx + 60, by))
                else
                    self.charge_sfx = Assets.getSound("chargeshot_charge")
                    self.charge_sfx:setLooping(true)
                    self.charge_sfx:setVolume(MathUtils.clamp(self.swap_timer/15, 0, 1))
                    self.charge_sfx:play()
                end
            end
        else
            self.swap_timer = 0
            self.can_swap = true
            if self.charge_sfx:isPlaying() then
                self.charge_sfx:stop()
            end
        end

        self.double_left.mask_sprite:setColor(1, 1, 1, self.swap_timer / 30)
        self.double_right.mask_sprite:setColor(1, 1, 1, self.swap_timer / 30)

        self:doMovement()
        --self.double_left:doMovement()
        --self.double_right:doMovement()
    end

    -- 这一块代码不会让两个灵魂同时进入无敌时间，其实是没用的代码
    -- 什么叫Game.inv_frames是nil搞得我还得额外写一个判断语句
    -- 哦原来我用的是旧版啊
    --[[
    if Game.inv_frames then
        for _, soul in ipairs({self.double_left, self.double_right}) do
            if Game.inv_frames > 0 then
                soul.inv_flash_timer = soul.inv_flash_timer + DT
                local amt = math.floor(soul.inv_flash_timer / (4 / 30))
                if (amt % 2) == 1 then
                    soul.sprite:setColor(0.5, 0.5, 0.5)
                else
                    soul.sprite:setColor(1, 1, 1)
                end
            else
                soul.inv_flash_timer = 0
                soul.sprite:setColor(1, 1, 1)
            end
        end
    end--]]

    -- 这段代码，会
    if Game.inv_frames then
        for _, soul in ipairs({self.double_left, self.double_right}) do
            if soul.inv_timer > 0 then
                local amt = math.floor(soul.inv_flash_timer / (4 / 30))
                if (amt % 2) == 1 then
                    soul.mask_sprite:setColor(0.5, 0.5, 0.5)
                else
                    soul.msak_sprite:setColor(1, 1, 1)
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

--[[
function DoubleSoul:onWaveStart()
    -- 这一堆代码根本不用维护，能跑就行
    -- 重构也行
    local soul_x, soul_y, soul_offset_x, soul_offset_y
    local has_arena = true
    for _, wave in ipairs(Game.battle.waves) do
        soul_x = wave.soul_start_x or soul_x
        soul_y = wave.soul_start_y or soul_y
        soul_offset_x = wave.soul_offset_x or soul_offset_x
        soul_offset_y = wave.soul_offset_y or soul_offset_y
        if not wave.has_arena then
            has_arena = false
        end
    end

    local center_x, center_y
    if has_arena then
        center_x, center_y = Game.battle.arena:getCenter()
    else
        center_x, center_y = SCREEN_WIDTH / 2, (SCREEN_HEIGHT - 155) / 2 + 10
    end

    soul_x = soul_x or (soul_offset_x and center_x + soul_offset_x)
    soul_y = soul_y or (soul_offset_y and center_y + soul_offset_y)

    local bx, by = Game.battle:getSoulLocation()
    local color = {Game.battle.encounter:getSoulColor()}
    Game.battle:addChild(HeartBurst(bx - 2, by + 1, color))

    for index, soul in ipairs({Game.battle.soul.double_left or false, Game.battle.soul.double_right or false}) do
        if not soul then
            soul = Game.battle.encounter:createSoul(bx, by, color, index)
            soul:transitionTo((soul_x or center_x) + 120 * index - 180, soul_y or center_y)
            soul.target_alpha = soul.alpha
            soul.alpha = 0
            Game.battle:addChild(soul)
            
            if Game.battle.state == "DEFENDINGBEGIN" or Game.battle.state == "DEFENDING" then
                soul:onWaveStart()
            end
        end
    end
end

function DoubleSoul:update()
    --super.super.update(self)
    if not self.transitioning and Input.down("confirm") then
        if self.can_swap then
            self.swap_timer = self.swap_timer + DTMULT
            if self.swap_timer >= 30 then
                self.can_swap = false
                self.swapped = not self.swapped
                -- self.color = {0,1,1}
                local _x, _y = self:getExactPosition(self.x, self.y)
                self:explode(_x, _y, true)
                -- Assets.playSound("squeak")
            else
                --self.color = {self.swap_timer/30,0,0}
                Assets.playSound("squeak")
            end
        end
    else
        self.swap_timer = 0
        self.can_swap = true
    end

    local table = {Game.battle.soul.double_left, Game.battle.soul.double_right}
    local souls = #table
    local rx = self.x

    for i = 1, souls do
        if table[i] then
            rx = rx + (table[i].x or 0)
        else
            souls = souls - 1
        end
    end

    rx = rx / souls
    self:transitionTo(rx, self.y, true)
end

--[[
function DoubleSoul:update()
    if Game.battle.soul.double_left then
        Game.battle.soul.double_left.x = Game.soul.double_leftul_left.x - 1
        Game.battle.soul.double_left:update()
    end
    if Game.battle.soul.double_right then
        Game.battle.soul.double_right.x = Game.soul.double_rightl_right.x + 1
        Game.battle.soul.double_right:update()
    end
end]]

function DoubleSoul:draw()
    --super.super.draw(self)
    --
    self.double_left:draw()
    self.double_right:draw()

    if DEBUG_RENDER then
        self.collider:draw(0, 1, 0)
        self.double_left.collider:draw(0, 1, 1)
        self.double_right.collider:draw(1, 0, 0)
        self.double_left.graze_collider:draw(0, 1, 1, 0.33)
        self.double_right.graze_collider:draw(1, 0, 0, 0.33)
    end--]]
    --[[
    if Game.battle.soul.double_left then
        
    end
    if Game.battle.soul.double_right then
        super.draw(Game.battle.soul.double_right)

        if DEBUG_RENDER then
            Game.battle.soul.double_right.collider:draw(0, 1, 0)
            Game.battle.soul.double_right.graze_collider:draw(1, 1, 1, 0.33)
        end
    end]]
end

return DoubleSoul