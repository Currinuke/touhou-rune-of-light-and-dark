local DoubleSoul, super = Class(Soul)
local alt = Object(0,0,0,0)
--local alt, super = Class(Soul)
-- local alt = Soul()

function DoubleSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.sprite = Sprite("player/heart_dodge_left")
    self.sprite:setOrigin(0.5, 0.5)
    self.sprite.inherit_color = true
    self:addChild(self.sprite)

    self.swap_timer = 0
    self.can_swap = true
    self.half_left = {0,1,1}
    self.half_right = {1,0,0}
    self.is_alt = false
    self.color = {0,1,1}

    --main = Soul(x,y,{0,1,1})
    --alt = Soul(x,y,{1,0,0})
    self.alt_soul = self:addChild(alt)
    super.init(self.alt_soul, x + 20, y, color)
    self.alt_soul.is_alt = true
end

--- Called every frame from within [`Soul:update()`](lua://Soul.update) if the soul is able to move. \
--- Movement for the soul based on player input should be controlled within this method.
function DoubleSoul:doMovement()
    --if self.is_alt then
        --self.x = 
        --self.y = 
    --else
    local speed = self.speed

    -- Do speed calculations here if required.

    if self.allow_focus then
        if Input.down("cancel") then speed = speed / 2 end -- Focus mode.
    end

    local move_x, move_y = 0, 0

    -- Keyboard input:
    if Input.down("left")  then move_x = move_x - 1 end
    if Input.down("right") then move_x = move_x + 1 end
    if Input.down("up")    then move_y = move_y - 1 end
    if Input.down("down")  then move_y = move_y + 1 end

    self.moving_x = move_x
    self.moving_y = move_y

    if move_x ~= 0 or move_y ~= 0 then
        if not self:move(move_x, move_y, speed * DTMULT) then
            self.moving_x = 0
            self.moving_y = 0
            --left:move(move_x, move_y, speed * 2 * DTMULT)
            --right:move(move_x, move_y, speed * 0.5 * DTMULT)
        end
    end

    if Input.down("confirm") then
        if self.can_swap then
            self.swap_timer = self.swap_timer + DTMULT
            if self.swap_timer >= 30 then
                self.can_swap = false
                self.color = {0,1,1}
                self.alt_soul:explode(self.x, self.y, true)
            else
                self.color = {self.swap_timer/30,0,0}
            end
        end
    else
        self.swap_timer = 0
        self.can_swap = true
        self.color = {0,1,1}
    end

    --self.alt_soul.doMovement = function()end
    self.alt_soul.x = (self.x + 20)/8
    self.alt_soul.y = (self.y)/8


    --end
end

return DoubleSoul
