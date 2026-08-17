---@class AxeBullet : Bullet
local AxeBullet, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
function AxeBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/smallbullet")
    self.slow_down = true
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir + math.rad(15)
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function AxeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    if self.slow_down then
        self.physics.direction = self.physics.direction - math.rad(0.5)
        self.physics.speed = self.physics.speed - 0.15
        if self.physics.speed <= 0 then
            self.slow_down = false
            self.physics.speed = -self.physics.speed
            self.physics.direction = -self.physics.direction
        end
    else
        self.physics.speed = self.physics.speed - 0.15
        if self.physics.direction >= 360 then
            self.physics.direction = 0
        elseif self.physics.direction <= 0 then
            self.physics.direction = self.physics.direction - math.rad(5)
        end
    end

    super.update(self)
end

return AxeBullet
