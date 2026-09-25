local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	local bulletcount=0
	self.timer:every(1,function()
		bulletcount=bulletcount+1
		local x,y=self:getAttackers()[1]:getRelativePos(self:getAttackers()[1].width/2,self:getAttackers()[1].height/2)
		for ii=1,3 do
			for i=1,2 do
				local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
				bullet.rotation=math.rad(180-24+ii*12-3)
				bullet.physics.match_rotation=true
				bullet.physics.speed=6*i
			end
		end
		local bullet=self:spawnBullet("rumia/wobblebullet",x,y,0,0)
		self.timer:tween(0.3,bullet,{scale_x=6,scale_y=6,alpha=0.1},nil,function()bullet:remove()end)
		Assets.playSound('heavyswing')
		if bulletcount==2 then
			return false
		end
	end)
	self.timer:every(3,function()
		local x,y=self:getAttackers()[1]:getRelativePos(self:getAttackers()[1].width/2,self:getAttackers()[1].height/2)
		local warnlinetable={}
		for i=1,2 do
			local warnline=Rectangle(20,35,SCREEN_WIDTH+500,2)
			local warnlinecolortweencount=0
			warnline.rotation=math.rad(180-135+i*90)
			self.timer:every(0.1,function()warnlinecolortweencount=warnlinecolortweencount+1 if warnlinecolortweencount%2==0 then warnline:setColor(1,0,0,0.5)else warnline:setColor(1,1,0,0.5)end end)
			self:getAttackers()[1]:addChild(warnline)
			table.insert(warnlinetable,warnline)
		end
		
		self.timer:after(0.5,function()
			for i=1,2 do
				warnlinetable[i]:remove()
				local bullet=self:spawnBullet("rumia/laser",x,y+55,0,0)
				bullet:setOrigin(0,0)
				bullet.rotation=math.rad(180-135+i*90)
				self.timer:tween(0.5,bullet,{rotation=math.rad(180-30+i*20)})
				self.timer:after(0.3,function()self.timer:tween(0.3,bullet,{alpha=0.2},nil,function()bullet:remove()end)end)
			end
			Assets.playSound('laz_c',0.7,0.5)
		end)
		self.timer:after(1.5,function()
			local bullet=self:spawnBullet("rumia/wobblebullet",x,y+20,0,0)
			self.timer:tween(0.3,bullet,{scale_x=6,scale_y=6,alpha=0.1},nil,function()bullet:remove()end)
			for ii=1,3 do
				local bullet=self:spawnBullet("rumia/diamondvert",x,y+20,0,0)
				bullet.physics.speed_x=-20
				bullet.physics.speed_y=-2+ii*1

				local bullet=self:spawnBullet("rumia/diamond",x,y+20,0,0)
				bullet.physics.speed_x=-16
				bullet.physics.speed_y=-1.6+ii*0.8
				for i=1,3 do
					local bullet=self:spawnBullet("rumia/diamondform",x,y+20,0,0)
					bullet.physics.speed_x=-16+i*3
					bullet.physics.speed_y=-2*bullet.physics.speed_x/20+ii*2*bullet.physics.speed_x/20/2
				end
			end
			Assets.playSound('heavyswing')
		end)
	end)
	self.timer:after(9.5,function()
		Assets.playSound('boost')
	end)
	self.timer:after(10,function()
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
	self.timer:after(11,function()self:getAttackers()[1]:setAnimation('battle/idle')self:getAttackers()[1].x,self:getAttackers()[1].y=550,200 end)
	self.time=15
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
end

return Basic