local DoubleSwapEffect, super = Class(Sprite)

function DoubleSwapEffect:init(x, y)
	super.init(self, "effects/doublesoul/heart_dodge_full", x, y)

	self:setOrigin(0.5, 0.5)
	self:setScale(1)

	self.alpha = 1
	self.layer = BATTLE_LAYERS["below_soul"]
end

function DoubleSwapEffect:update()
	self.timer = (self.timer or 0) + DTMULT

	if self.alpha <= 0 then
		self:remove()
	elseif self.timer >= 0 then
		self.alpha = self.alpha - 0.1 * DTMULT
		self:setScale(1 + 0.5 * self.timer)
	end

	super.update(self)
end

return DoubleSwapEffect