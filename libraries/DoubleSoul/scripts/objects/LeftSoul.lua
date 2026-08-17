local LeftSoul, super = Class(Soul)

function LeftSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.color = {0, 1, 1}

    self.sprite:setSprite("player/heart_dodge_left")
    self.sprite.inherit_color = false

    self.can_move = false

    self.mask_sprite = Sprite("player/heart_dodge_right")
    self.mask_sprite.inherit_color = false
    self:addChild(self.mask_sprite)

    self.sync_inv = Kristal.getLibConfig("throld-doublesoul", "sameInv")

    self.onSwap = function(swapped)
        self.mask_sprite:setColor(1, 1, 1, 0)

        if swapped then
            self.color = {1, 0, 0}
            self.sprite:setSprite("player/heart_dodge_right")
            self.mask_sprite:setSprite("player/heart_dodge_left")
        else
            self.color = {0, 1, 1}
            self.sprite:setSprite("player/heart_dodge_left")
            self.mask_sprite:setSprite("player/heart_dodge_right")
        end
    end
end
--[[
function LeftSoul:move(x, y, speed)
    local movex, movey = x * (speed or 1), y * (speed or 1)

    local mxa, mxb = self:moveX(movex, movey)
    local mya, myb = self:moveY(movey, movex)

    local moved = (mxa and not mxb) or (mya and not myb)
    local collided = (not mxa and not mxb) or (not mya and not myb)

    return moved, collided
end

function LeftSoul:onRemove(parent)
    super.onRemove(self, parent)

    if parent == Game.battle and Game.battle.soul.double_left == self then
        Game.battle.soul.double_left = nil
    end
end--]]

function LeftSoul:doMovement() end

function LeftSoul:onDamage(bullet, amount)
    super.onDamage(self, bullet, amount)
    if self.sync_inv then
        Game.battle.soul.double_right.inv_timer = self.inv_timer
    end
end
--[[
function LeftSoul:draw()
    super.draw(self)
    
    if self.effect_timer >= 0 then
        self.effect_timer = self.effect_timer + DTMULT
        self.effect_sprite:draw(1, 1, 1, 1 - (self.effect_timer / self.effect_timer_max))
        if self.effect_timer >= self.effect_timer_max then
            self.effect_timer = -1
        end
    else
        self.effect_sprite:draw(1, 1, 1, 0)
    end

    if DEBUG_RENDER then
        self.collider:draw(0, 1, 0)
        self.graze_collider:draw(1, 1, 1, 0.33)
    end
end]]

--[[
    local soul = Game.battle.soul.double_right
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

    local allow_move = true
    if soul then
        if soul.last_collided_x == 0 and soul.last_collided_y == 0 then
            allow_move = true
        else
            allow_move = false
        end
    end

    if allow_move then
        if move_x ~= 0 or move_y ~= 0 then
            if not self:move(move_x, move_y, speed * DTMULT) then
                self.moving_x = 0
                self.moving_y = 0
            end
        end
    end
end]]

return LeftSoul