local bolt, super = Class(Bullet)

function bolt:init(x, fixedpos)
	if fixedpos then
		x = 278 + (fixedpos - 1) * 28.4 - Game.battle.soul.width / 2 - Game.battle.soul.width / 4 + 1
	else
		x = x - Game.battle.soul.width / 2
	end
	super.init(self, x, 102 + 144 - 4 + 1, "bullets/remilia/bolt_new")
	self.sprite:play(1/15, true)
	self:setOrigin(0.5, 1)
	self:setScale(1.5, 2)
    self.collider = Hitbox(self, self.width * 3 / 8, 0, self.width / 4, self.height)
	self.destroy_on_hit = false
	self.damage = 99.61
	Game.battle.timer:tween(0.6, self, {alpha = 0.1}, nil, function() self:remove() end)
end

function bolt:update()
	super.update(self)
	if self.alpha <= 0.75 then
		self.collidable = false
	end
end

return bolt