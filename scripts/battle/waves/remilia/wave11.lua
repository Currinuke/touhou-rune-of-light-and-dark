local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	local boltcount=1
	local boltdir=1
	self.timer:every(0.5,function()
		local bullet=self:spawnBullet("remilia/bat",640+20,MathUtils.random(Game.battle.arena.bottom,Game.battle.arena.top),math.rad(180),10)
		bullet.batbullet=true
		bullet.remove_offscreen=false
	end)
	self.timer:every(1,function()
		if boltcount==1 then
			self:createBolt(0,1)
			self:createBolt(0,5)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.8)
			end)
			boltdir=1
		elseif boltcount==2 then
			self:createBolt(0,2)
			self:createBolt(0,4)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.8)
			end)
		elseif boltcount==3 then
			self:createBolt(0,3)
				self.timer:after(0.8,function()
				Assets.playSound('bolt',0.7)
			end)
			boltdir=-1
		end
		boltcount=boltcount+boltdir
	end)
	self.time=18.5
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if bullet.batbullet then
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