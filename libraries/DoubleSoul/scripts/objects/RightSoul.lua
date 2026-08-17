local RightSoul, super = Class(Soul)

function RightSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.color = {1, 0, 0}

    local offset = 100

    self.sprite:setSprite("player/heart_dodge_right")
    self.sprite:setOrigin(0.5 - offset / 20, 0.5)
    self.sprite.inherit_color = false
    self:addChild(self.sprite)

    self.graze_sprite:setOrigin(0.5 - offset / 50, 0.5)
    self:addChild(self.graze_sprite)
    
    --self.graze_collider = CircleCollider(self, 0, 0, 25 * self.graze_size_factor)
    self.can_move = false

    -- self.mask_sprite = Sprite("player/heart_dodge_right_mask")
    self.mask_sprite = Sprite("player/heart_dodge_left")
    self.mask_sprite:setOrigin(0.5 - offset / 20, 0.5)
    self.mask_sprite.inherit_color = false
    self:addChild(self.mask_sprite)

    self.onSwap = function(swapped)
        self.mask_sprite:setColor(1, 1, 1, 0)

        if swapped then
            self.color = {0, 1, 1}
            self.sprite:setSprite("player/heart_dodge_left")
            self.mask_sprite:setSprite("player/heart_dodge_right")
        else
            self.color = {1, 0, 0}
            self.sprite:setSprite("player/heart_dodge_right")
            self.mask_sprite:setSprite("player/heart_dodge_left")
        end
    end
end
--[[
function RightSoul:onRemove(parent)
    super.onRemove(self, parent)

    if parent == Game.battle and Game.battle.soul.double_right == self then
        Game.battle.soul.double_right = nil
    end
end--]]

function RightSoul:doMovement() end

function RightSoul:onDamage(bullet, amount)
    Game.battle.soul.double_left.inv_timer = self.inv_timer
end

--[[
function RightSoul:draw()
    super.draw(self)
end--[[
    local soul = Game.battle.soul.double_left
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

return RightSoul