---@class ScarletBat1 : Bullet
local ScarletBat1, super = Class(Bullet)

---@param x number # The X position of the bullet
---@param y number # The Y position of the bullet
---@param dir? string # The dir of the bullet, either "left" or "right" (default: "right")
---@param speed? number # The speed the bullet will move at in the specified direction (default: 8)
---@param newspeed? number # The new speed the bullet will move at (default: 5)
function ScarletBat1:init(x, y, dir, speed, newspeed)
    super.init(self, x, y, "bullets/smallbullet")
    
    -- Speed the bullet moves (pixels per frame at 30FPS)

    self.facing = dir or "right"
    if dir == "left" then
        self.physics.direction = math.rad(180)
    end
    
    self.physics.speed = speed or 8
    self.newspeed = newspeed or 5
    self.approach = false
end

function ScarletBat1:update()
    if not self.approach then
        if (self.facing == "left" and self.x <= Game.battle.arena.right + 80) or (self.facing == "right" and self.x >= Game.battle.arena.left - 80) then
            self.physics.speed = self.newspeed
            self.approach = true
            -- self.remove_offscreen = true
        end
    end
    
    super.update(self)
end

return ScarletBat1
