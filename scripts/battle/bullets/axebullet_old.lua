---@class AxeBullet : Bullet
local AxeBullet, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
function AxeBullet:init(x, y, dir, speed)
    -- Last argument = sprite path
    super.init(self, x, y, "bullets/smallbullet")
    
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed
end

function AxeBullet:update()
    -- For more complicated bullet behaviours, code here gets called every update
    self.physics.direction = self.physics.direction - math.rad(1)
    self.physics.speed = self.physics.speed - 0.1

    super.update(self)
end

return AxeBullet
