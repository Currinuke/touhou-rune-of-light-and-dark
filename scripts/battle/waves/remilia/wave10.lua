local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	self.timer:after(0.5,function()
		self:createBolt(0,2)
		self:createBolt(0,4)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',0.8)
		end)
	end)



	self.timer:after(0.5,function()
		local batcount=0
		self.timer:every(1,function()
			batcount=batcount+1
			local bullet
			for i=1,20 do
				if batcount%2==0 then
					bullet=self:spawnBullet("remilia/bat",640+10,480-i*70)
					bullet.physics.speed_y=4
				else
					bullet=self:spawnBullet("remilia/bat",640+10,i*70)
					bullet.physics.speed_y=-4
				end
				bullet.remove_offscreen=false
				bullet.destroy_on_hit=false
				bullet.rotation=math.rad(-90)
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet.physics.speed_x=-8
			end
			if batcount==3 then
				return false
			end
		end)
	end)



	self.timer:after(5,function()
		self:createBolt(0,3)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',0.7)
		end)
	end)



	self.timer:after(5,function()
		local batcount=0
		self.timer:every(1,function()
			batcount=batcount+1
			local bullet
			for i=1,20 do
				if batcount%2==0 then
					bullet=self:spawnBullet("remilia/bat",640+10,i*70)
					bullet.physics.speed_y=-4
				else
					bullet=self:spawnBullet("remilia/bat",640+10,480-i*70)
					bullet.physics.speed_y=4
				end
				bullet.remove_offscreen=false
				bullet.destroy_on_hit=false
				bullet.rotation=math.rad(-90)
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet.physics.speed_x=-8
			end
			if batcount==3 then
				return false
			end
		end)
	end)



	self.timer:after(9,function()
		warn=Rectangle(0,101+71,640,71)
		warn:setColor(1,1,1,0)
		self:addChild(warn)
		self.timer:tween(0.2,warn,{alpha=0.8},nil,function()self.timer:tween(0.2,warn,{alpha=0.1},nil,function()warn:remove()end)end)
		self.timer:after(0.4,function()
			local batcount=0
			self.timer:every(0.015,function()
				batcount=batcount+1
				local bullet=self:spawnBullet("remilia/bat",640+10,MathUtils.random(101+71,101+142))
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet:setScale(0.5)
				bullet.destroy_on_hit=false
				bullet.physics.match_rotation=true
				bullet.physics.speed=20
				bullet.rotation=math.rad(180)
				bullet.remove_offscreen=false
				if batcount==40 then
					return false
				end
			end)
		end)


		local batcount=0
		self.timer:every(1,function()
			batcount=batcount+1
			local bullet
			for i=1,20 do
				if batcount%2==0 then
					bullet=self:spawnBullet("remilia/bat",640+10,480-i*70)
					bullet.physics.speed_y=4
				else
					bullet=self:spawnBullet("remilia/bat",640+10,i*70)
					bullet.physics.speed_y=-4
				end
				bullet.remove_offscreen=false
				bullet.destroy_on_hit=false
				bullet.rotation=math.rad(-90)
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet.physics.speed_x=-8
			end
			if batcount==3 then
				return false
			end
		end)
	end)



	self.timer:after(13.5,function()
		warn=Rectangle(0,101,640,71)
		warn:setColor(1,1,1,0)
		self:addChild(warn)
		self.timer:tween(0.2,warn,{alpha=0.8},nil,function()self.timer:tween(0.2,warn,{alpha=0.1},nil,function()warn:remove()end)end)
		self.timer:after(0.4,function()
			local batcount=0
			self.timer:every(0.015,function()
				batcount=batcount+1
				local bullet=self:spawnBullet("remilia/bat",640+10,MathUtils.random(101,101+71))
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet:setScale(0.5)
				bullet.destroy_on_hit=false
				bullet.physics.match_rotation=true
				bullet.physics.speed=20
				bullet.rotation=math.rad(180)
				bullet.remove_offscreen=false
				if batcount==40 then
					return false
				end
			end)
		end)
		self:createBolt(0,1)
		self:createBolt(0,5)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',0.8)
		end)


		local batcount=0
		self.timer:every(1,function()
			batcount=batcount+1
			local bullet
			for i=1,20 do
				if batcount%2==0 then
					bullet=self:spawnBullet("remilia/bat",640+10,i*70)
					bullet.physics.speed_y=-4
				else
					bullet=self:spawnBullet("remilia/bat",640+10,480-i*70)
					bullet.physics.speed_y=4
				end
				bullet.remove_offscreen=false
				bullet.destroy_on_hit=false
				bullet.rotation=math.rad(-90)
				bullet:setSprite('bullets/remilia/bat',1/10,true)
				bullet.physics.speed_x=-8
			end
			if batcount==3 then
				return false
			end
		end)
	end)
	self.time=19
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if bullet.x<=-20 then
			bullet.remove_offscreen=true
		end
	end
end

function Basic:createBolt(x,fixedpos)
	local boltwarn
	if fixedpos then
		boltwarn=Rectangle(250+28.4*(fixedpos-0.5),0,28.4,243)
	else
		boltwarn=Rectangle(x,0,28.4,243)
	end
	boltwarn:setOrigin(0.5,0)
	boltwarn:setColor(1,1,1,0)
	boltwarn:setScale(0.1,1)
	self:addChild(boltwarn)
	self.timer:tween(0.2,boltwarn,{alpha=0.5,scale_x=1},nil,function()self.timer:after(0.6,function()boltwarn:remove()end)end)
	self.timer:after(0.8,function()
		if fixedpos then
			local bullet=self:spawnBullet("remilia/bolt",0,fixedpos)
		else
			local bullet=self:spawnBullet("remilia/bolt",x+Game.battle.soul.width/2)--呃呃这个。因为追踪灵魂的生成位置有偏移所以就在这改了。
		end
	end)
end

return Basic