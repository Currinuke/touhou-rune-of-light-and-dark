local bolt, super = Class(Bullet)

function bolt:init(x, fixedpos)
	if fixedpos then
		x = 278 + (fixedpos - 1) * 28.4
	end
	super.init(self, x, 102, "bullets/remilia/bolt")
	self.sprite:play(1/15, true)
	self:setScale(0.25, 0.4)
	self.collider = Hitbox(self, 410, 350, 28.4*2, 500)
	self.destroy_on_hit = false
	self.damage = 99.61
	Game.battle.timer:tween(0.6, self, {alpha=0.1}, nil, function() self:remove() end)
end

function bolt:update()
	super.update(self)
	if self.alpha <= 0.75 then
		self.collidable = false
	end
end

function bolt:onDamage(soul)
	local damage = self:getDamage()
    if damage > 0 then
        local target = MathUtils.randomInt(1,4)
		if Game.party[target].health < 0 then
			target = 1
		end
		if Game.party[1].health < 0 then
			target = 2
		end
		if Game.party[2].health < 0 then
			target = 3
		end
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        soul.inv_timer = self:getInvulnTime()
        soul:onDamage(self, damage)
        return battlers
    end
	return {}
end

return bolt