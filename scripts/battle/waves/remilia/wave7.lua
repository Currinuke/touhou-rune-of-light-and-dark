local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	self.timer:every(0.15,function()--相较于第一回合，子弹生成间隔由0.3s改为0.15s，并会随机在左或右方生成
		local bullet
		if love.math.random()>=0.5 then--左方子弹
			bullet=self:spawnBullet("remilia/bat",640+20,MathUtils.random(Game.battle.arena.bottom,Game.battle.arena.top),math.rad(180),10)
			bullet.fromleft=true
		else
			bullet=self:spawnBullet("remilia/bat",-20,MathUtils.random(Game.battle.arena.bottom,Game.battle.arena.top),0,10)
		end
		bullet.remove_offscreen=false
	end)
	self.time=12
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if bullet.fromleft then
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
		else
			if bullet.x>=100 then
				bullet.physics.speed=6
				if not bullet.transformed then
					bullet.transformed=true
					bullet.rotation=0
					bullet:setSprite('bullets/remilia/bat',1/10,true)
				end
				if bullet.x>Game.battle.arena.right then
					if not bullet.tweening then
						bullet.tweening=true
						self.timer:tween(0.5,bullet,{alpha=0},nil,function()bullet:remove()end)
					end
				end
			else
				bullet.rotation=bullet.rotation+math.rad(5)
			end
		end
	end
end

return Basic