local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	local bulletcount=0
	self.timer:every(1,function()
		bulletcount=bulletcount+1
		local x,y=self:getAttackers()[1]:getRelativePos(self:getAttackers()[1].width/2,self:getAttackers()[1].height/2)
		local angle=MathUtils.angle(x,y,Game.battle.soul.x,Game.battle.soul.y)
		for ii=1,3 do
			for i=1,2 do
				local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
				bullet.rotation=angle+math.rad(-40+ii*20)
				bullet.physics.match_rotation=true
				bullet.physics.speed=6*i
			end
		end
		local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
		self.timer:tween(0.3,bullet,{scale_x=6,scale_y=6,alpha=0.1},nil,function()bullet:remove()end)
		Assets.playSound('heavyswing')
		self.timer:after(0.2,function()
			if bulletcount==1 then
				self.timer:tween(0.3,self:getAttackers()[1],{x=500,y=120})
			elseif bulletcount==2 then
				self.timer:tween(0.3,self:getAttackers()[1],{x=480,y=280})
			elseif bulletcount==3 then
				self.timer:tween(0.3,self:getAttackers()[1],{x=550,y=200})
			end
		end)
		if bulletcount==3 then
			return false
		end
	end)
	self.timer:after(4,function()
		local x,y=self:getAttackers()[1]:getRelativePos(self:getAttackers()[1].width/2,self:getAttackers()[1].height/2)
		for i=1,3 do
			local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
			bullet.rotation=math.rad(180-24+i*12-3)
			bullet.physics.match_rotation=true
			bullet.physics.speed=12
		end
		local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
		self.timer:tween(0.3,bullet,{scale_x=6,scale_y=6,alpha=0.1},nil,function()bullet:remove()end)
		Assets.playSound('heavyswing')
	end)
	self.timer:after(4.5,function()
		Assets.playSound('boost')
	end)
	self.timer:after(5,function()
		bulletcount=0
		self.timer:every(0.15,function()
			self:getAttackers()[1]:setAnimation('battle/attack')
			self:getAttackers()[1].x,self:getAttackers()[1].y=550-90,200-70
			local x,y=self:getAttackers()[1]:getRelativePos(self:getAttackers()[1].width/2,self:getAttackers()[1].height/2)
			bulletcount=bulletcount+1
			local bullet=self:spawnBullet("rumia/axebullet",x,y,0,0)
			bullet.physics.speed_x=-13
			bullet.physics.speed_y=MathUtils.random(1,4)
			bullet.physics.gravity=0.25
			bullet.physics.gravity_direction=math.rad(0)
			self.timer:every(0.1,function()
				if bullet then
					bullet.rotation=bullet.rotation+math.rad(45)
				else
					return false
				end
			end)
			Assets.playSound('laz_c',0.6)
			if bulletcount==3 then
				return false
			end
		end)
	end)
	self.timer:after(6,function()self:getAttackers()[1]:setAnimation('battle/idle')self:getAttackers()[1].x,self:getAttackers()[1].y=550,200 end)
	self.time=9
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
end

return Basic