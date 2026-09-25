local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	self.timer:every(0.3,function()
		for i=1,MathUtils.random(1,3) do
			local bullet=self:spawnBullet("remilia/bat",640+20,MathUtils.random(Game.battle.arena.bottom,Game.battle.arena.top),math.rad(180),10)
			bullet.remove_offscreen=false
		end
	end)
	self.time=12
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if bullet.x<=540 then
			bullet.physics.speed=6
			if not bullet.transformed then
				bullet.transformed=true
				bullet.rotation=math.rad(180)
				bullet:setSprite('bullets/remilia/bat',1/10,true)
			end
			if bullet.x<Game.battle.arena.left then
				if not bullet.tweening then
					bullet.tweening=true
					self.timer:tween(0.5,bullet,{alpha=0},nil,function()bullet:remove()end)
				end
			end
		else
			bullet.rotation=bullet.rotation-math.rad(5)
		end
	end
end

return Basic