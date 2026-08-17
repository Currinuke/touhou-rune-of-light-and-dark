---@class DoubleSwapEffect : Sprite
---@overload fun(...) : DoubleSwapEffect
local DoubleSwapEffect, super = Class(Sprite)

function DoubleSwapEffect:init(x, y)
    super.init(self, "player/heart_dodge_full", x, y)
    self:setOrigin(0.5, 0.5)
    -- self.layer = BATTLE_LAYERS["soul"] - 1
    self.timer = 0
end

function DoubleSwapEffect:update()
    self.timer = self.timer + DTMULT
    
    if self.timer >= 0 then
        self.alpha = self.alpha - 0.05 * DTMULT
        self:setScale(1 + 0.1 * DTMULT)
    end

    if self.alpha <= 0 then
        self:remove()
    end

    super.update(self)
end

return DoubleSwapEffect

--[[
function DoubleSwapEffect:draw()
    -- 15 -> 0.5s
    local r, g, b, a = self:getDrawColor()
    -- Draw.setColor(r, g, b, a * (0.8 - (self.burst / 6)))
    Draw.setColor(r, g, b, a)
    local xscale, yscale = 0.25 + self.burst, (0.25 + (self.burst / 2))
    Draw.draw(self.swap_sprite, 1, 1, 1, xscale * 4, yscale * 4, self.swap_sprite:getWidth() / 2, self.swap_sprite:getHeight() / 2)

    xscale, yscale = (0.25 + (self.burst / 1.5)), (0.25 + (self.burst / 3))
    -- self:drawHeartOutline(xscale * 4, yscale * 4, (1 - (self.burst / 6)))

    xscale, yscale = (0.2 + (self.burst / 2.5)), (0.2 + (self.burst / 5))
    -- self:drawHeartOutline(xscale * 4, yscale * 4, (1.2 - (self.burst / 6)))

    super.draw(self)

    if self.burst > 100 then
        self:remove()
    end
end--]]