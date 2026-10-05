local RemiliaBat, super = Class(Sprite, "RemiliaBat")

function RemiliaBat:init(x, y, tx, ty)
	super.init(self, "bullets/remilia/cutscene_bat", x, y)
    self:setOrigin(0.5, 0.5)
    self:setScale(1, 1)
	self:play(1/10, true)
    self.alpha = 1
    self.layer = 0.7
	Game.world.timer:tween(0.6, self, {x = tx, y = ty})
end

return RemiliaBat