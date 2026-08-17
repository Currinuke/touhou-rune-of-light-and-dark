local DoubleSwapEffect, super = Class(Object)

function DoubleSwapEffect:init(x, y)
    super.init(self, x, y)

    self:setColor(1, 1, 1, 1)
    self:setOrigin(0.5, 0.5)

    self.layer = BATTLE_LAYERS["soul"] - 1
    self.burst = 0
    self.swap_sprite = Assets.getTexture("player/heart_dodge_full")
end

function DoubleSwapEffect:update()
    self.burst = self.burst + DTMULT
    super.update(self)
end

function DoubleSwapEffect:draw()
    -- 15 -> 0.5s
    local r, g, b, a = self:getDrawColor()
    Draw.setColor(r, g, b, a * (0.8 - (self.burst / 6)))
    local xscale, yscale = 0.25 + self.burst, (0.25 + (self.burst / 2))
    Draw.draw(self.swap_sprite, 0, 0, 0, xscale * 4, yscale * 4, self.swap_sprite:getWidth() / 2, self.swap_sprite:getHeight() / 2)

    xscale, yscale = (0.25 + (self.burst / 1.5)), (0.25 + (self.burst / 3))
    -- self:drawHeartOutline(xscale * 4, yscale * 4, (1 - (self.burst / 6)))

    xscale, yscale = (0.2 + (self.burst / 2.5)), (0.2 + (self.burst / 5))
    -- self:drawHeartOutline(xscale * 4, yscale * 4, (1.2 - (self.burst / 6)))

    super.draw(self)

    if self.burst > 10 then
        self:remove()
    end
end

return DoubleSwapEffect