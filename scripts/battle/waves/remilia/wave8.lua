local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()--因为播放声音直接写在函数里会导致音量听着很难受，所以只能一个一个写了
	self.timer:after(0.5,function()
		self:createBolt(0,2)
		self:createBolt(0,4)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',0.8)
		end)
	end)
	self.timer:after(1.5,function()
		self:createBolt(0,1)
		self:createBolt(0,3)
		self:createBolt(0,5)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',1)
		end)
	end)
	self.timer:after(2.5,function()
		self:createBolt(0,2)
		self:createBolt(0,4)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',0.8)
		end)
	end)
	self.timer:after(3.5,function()
		self:createBolt(0,1)
		self:createBolt(0,3)
		self:createBolt(0,5)
		self.timer:after(0.8,function()
			Assets.playSound('bolt',1)
		end)
	end)
	self.timer:after(4,function()
		local boltcount=0
		self.timer:every(1,function()
			boltcount=boltcount+1
			self:createBolt(0,boltcount)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.7)
			end)
			if boltcount==5 then
				return false
			end
		end)
	end)
	self.timer:after(10,function()
		local boltcount=0
		self.timer:every(0.1,function()
			boltcount=boltcount+1
			self:createBolt(Game.battle.soul.x)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.7)
			end)
			if boltcount==8 then
				return false
			end
		end)
	end)
	self.timer:after(12,function()
		local boltcount=0
		self.timer:every(0.1,function()
			boltcount=boltcount+1
			self:createBolt(Game.battle.soul.x)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.7)
			end)
			if boltcount==8 then
				return false
			end
		end)
	end)
	self.timer:after(13,function()
		local boltcount=6
		self.timer:every(1,function()
			boltcount=boltcount-1
			self:createBolt(0,boltcount)
			self.timer:after(0.8,function()
				Assets.playSound('bolt',0.7)
			end)
			if boltcount==1 then
				return false
			end
		end)
	end)
	self.time=20.5
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		
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