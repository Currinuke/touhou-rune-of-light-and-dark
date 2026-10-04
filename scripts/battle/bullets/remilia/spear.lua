local spear, super = Class(Bullet)

function spear:init(x, y, dir, speed)
	super.init(self, x, y, "bullets/remilia/spear")
	self:setScale(1)
	self.damage = 9961
	self.destroy_on_hit = false
	self.remove_offscreen = false
	self.solidcollider = Hitbox(self, self.width / 4 - 20, self.height / 4, self.width / 2 - 10, self.height / 2)

	self.physics.direction = dir
	self.physics.speed = speed
end

function spear:update()
	super.update(self)
	local soul = Game.battle.soul
	if soul and Game.battle.soul.collidable then
		Object.startCache()
		local angle_diff = self.clockwise and -(math.pi / 2) or (math.pi / 2)
		local angle
		while soul:collidesWith(self.solidcollider) do
			if not angle then
				local x1, y1 = self:getRelativePos(self.solidcollider.x, self.solidcollider.y, Game.battle)
				local x2, y2 = self:getRelativePos(self.solidcollider.x2, self.solidcollider.y2, Game.battle)
				angle = Utils.angle(x1, y1, x2, y2)
			end
			Object.uncache(soul)
			soul:setPosition(
				soul.x + (math.cos(angle + angle_diff)),
				soul.y
			 )
			end
		Object.endCache()
	end
end

function spear:onDamage(soul)
	local damage = self:getDamage()
    if damage > 0 then
        local target = "ANY"
        local battlers = Game.battle:hurt(damage, false, target, self:shouldSwoon(damage, target, soul))
        soul.inv_timer = self:getInvulnTime()
        soul:onDamage(self, damage)
        return battlers
    end
	return {}
end

return spear