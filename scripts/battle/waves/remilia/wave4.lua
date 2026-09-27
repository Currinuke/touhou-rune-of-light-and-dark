local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	self.timer:every(0.25,function()
		local bullet=self:spawnBullet("remilia/bat",640+20,80,0,5)
		bullet:setSprite('bullets/remilia/bat',1/10,true)
		bullet.destroy_on_hit=false
		bullet.remove_offscreen=false
		bullet.rotation=math.rad(180)
		bullet.physics.match_rotation=true

		local bullet=self:spawnBullet("remilia/bat",640+20,300,0,5)
		bullet:setSprite('bullets/remilia/bat',1/10,true)
		bullet.destroy_on_hit=false
		bullet.remove_offscreen=false
		bullet.rotation=math.rad(180)
		bullet.physics.match_rotation=true
	end)
	self.time=20
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if not bullet.remove_offscreen then
			if bullet.x<=-50 then
				bullet.remove_offscreen=true
			end
		end
	end
end

return Basic