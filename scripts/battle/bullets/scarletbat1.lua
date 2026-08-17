---@class ScarletBat1 : Bullet
local ScarletBat1, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir number # The dir (in radians) of the bullet
---@param speed number # The speed the bullet will move at in the specified direction
function ScarletBat1:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/smallbullet")
    
    -- Move the bullet in dir radians (0 = right, pi = left, clockwise rotation)
    self.physics.direction = dir
    -- Speed the bullet moves (pixels per frame at 30FPS)
    self.physics.speed = speed

    self.approach = false
end

function ScarletBat1:update()
    if not self.approach and self.x <= 480 then
        self.physics.speed = self.physics.speed * 0.7
        self.approach = true
    end
    super.update(self)
end

return ScarletBat1
