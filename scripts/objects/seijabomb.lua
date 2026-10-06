local SeijaBomb, super = Class(Sprite, "SeijaBomb")

function SeijaBomb:init(x, y, tx, ty, time)
	super.init(self, "effects/seijabomb/bomb", x, y)
    self:setOrigin(0.5, 0.5)
    self:setScale(1, 1)
	self:play(1/25, true)
    self.alpha = 1
    self.layer = 1.7
	Game.world.timer:tween(time or 0.6, self, {x = tx or x, y = ty or y}, nil, function()
        -- self:remove()
    end)
end

return SeijaBomb