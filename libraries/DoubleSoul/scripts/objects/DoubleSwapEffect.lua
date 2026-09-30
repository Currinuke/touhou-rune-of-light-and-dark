local DoubleSwapEffect, super = Class(Object)

function DoubleSwapEffect:init(x, y)
	super.init(self, x, y)
	self:setSprite("player/heart_dodge_full")
	self.alpha = 1
	-- self.layer = BATTLE_LAYERS["soul"] + 1
end

function DoubleSwapEffect:update()
	self.timer = (self.timer or 0) + DTMULT

	if self.alpha <= 0 then
		self:remove()
		Kristal.Console:push("remove")
	elseif self.timer >= 0 then
		self.alpha = self.alpha - 0.05 * DTMULT
		self:setScale(1 + 0.15 * self.timer)
		Kristal.Console:push("timer: " .. tostring(self.timer))
	end

	super.update(self)
end

function DoubleSwapEffect:draw()
	love.graphics.setColor(1, 1, 1, self.alpha)
	love.graphics.draw(Assets.getTexture("player/heart_dodge_full"), 0, 0, 0, 1)
end

function DoubleSwapEffect:setSprite(sprite)
	if self.sprite then
		self.sprite:remove()
	end
	self.sprite = Sprite(sprite, 0, 0)
	self:addChild(self.sprite)
	self:setSize(self.sprite:getSize())
end

return DoubleSwapEffect