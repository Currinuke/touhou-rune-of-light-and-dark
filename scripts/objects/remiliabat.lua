local RemiliaBat, super = Class(Sprite, "RemiliaBat")

function RemiliaBat:init(x, y, tx, ty, time)
	super.init(self, "bullets/remilia/cutscene_bat", x, y)
    self:setOrigin(0.5, 0.5)
    self:setScale(1, 1)
	self:play(1/10, true)
    self.alpha = 1
    self.layer = 0.7
	Game.world.timer:tween(time or 0.6, self, {x = tx or x, y = ty or y})
end

return RemiliaBat