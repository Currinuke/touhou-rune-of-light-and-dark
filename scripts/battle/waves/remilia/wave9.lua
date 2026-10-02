local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onEnd()
	self:getAttackers()[1].layer=BATTLE_LAYERS['battlers']
end

local batfollow={}
function Basic:onStart()
	self:getAttackers()[1].layer=BATTLE_LAYERS['below_bullets']
	local batleft=self:spawnBullet("remilia/bat",-20,-20,0,0)
	batleft.destroy_on_hit=false
	batleft.rotation=math.rad(-90)
	batleft.collidable=false
	batleft:setScale(1.5)
	batleft:setSprite('bullets/remilia/bat',1/10,true)
	self.timer:tween(0.5,batleft,{x=Game.battle.arena.left,y=Game.battle.arena.top},nil,function()batleft:shake(-3,3)end)
	table.insert(batfollow,batleft)

	local batright=self:spawnBullet("remilia/bat",640+20,-20,0,0)
	batright.destroy_on_hit=false
	batright.rotation=math.rad(-90)
	batright.collidable=false
	batright:setScale(1.5)
	batright:setSprite('bullets/remilia/bat',1/10,true)
	self.timer:tween(0.5,batright,{x=Game.battle.arena.right,y=Game.battle.arena.top},nil,function()batright:shake(3,3)Assets.playSound('grab')end)
	table.insert(batfollow,batright)

	self.timer:after(1,function()
		self.timer:tween(0.3,Game.battle.arena,{y=Game.battle.arena.y-47})
		local arenatweencount=0
		self.timer:every(1.5,function()
			arenatweencount=arenatweencount+1
			if arenatweencount%4==0 or (arenatweencount+1)%4==0 then
				self.timer:tween(0.3,Game.battle.arena,{y=Game.battle.arena.y-47})
			else
				self.timer:tween(0.3,Game.battle.arena,{y=Game.battle.arena.y+47})
			end
		end)

		local warnline=Rectangle(self:getAttackers()[1].x,self:getAttackers()[1].y-28,SCREEN_WIDTH,2)
		warnline.rotation=math.rad(180)
		local warnlinecolortweencount=0
		self.timer:every(0.1,function()warnlinecolortweencount=warnlinecolortweencount+1 if warnlinecolortweencount%2==0 then warnline:setColor(1,0,0,0.5)else warnline:setColor(1,1,0,0.5)end end)
		self:addChild(warnline)

		self:getAttackers()[1]:setAnimation('battle/attack')
		self.timer:after(0.5,function()
			warnline:remove()
			local bullet=self:spawnBullet("remilia/spear",self:getAttackers()[1].x,self:getAttackers()[1].y-28)
			bullet.rotation=math.rad(180)
			self.timer:tween(0.1,self:getAttackers()[1],{x=200})
			self.timer:tween(0.1,bullet,{x=200})
			self.timer:after(0.3,function()
				self:getAttackers()[1]:setAnimation('battle/back')
				self.timer:tween(0.1,self:getAttackers()[1],{x=550})
				bullet:remove()
			end)
		end)
		self.timer:every(2.5,function()
			local warnline=Rectangle(self:getAttackers()[1].x,self:getAttackers()[1].y-28,SCREEN_WIDTH,2)
			warnline.rotation=math.rad(180)
			local warnlinecolortweencount=0
			self.timer:every(0.1,function()warnlinecolortweencount=warnlinecolortweencount+1 if warnlinecolortweencount%2==0 then warnline:setColor(1,0,0,0.5)else warnline:setColor(1,1,0,0.5)end end)
			self:addChild(warnline)
			self:getAttackers()[1]:setAnimation('battle/attack')
			self.timer:after(0.5,function()
				warnline:remove()
				local bullet=self:spawnBullet("remilia/spear",self:getAttackers()[1].x,self:getAttackers()[1].y-28)
				bullet.rotation=math.rad(180)
				self.timer:tween(0.1,self:getAttackers()[1],{x=200})
				self.timer:tween(0.1,bullet,{x=200})
				self.timer:after(0.3,function()
					self:getAttackers()[1]:setAnimation('battle/back')
					self.timer:tween(0.1,self:getAttackers()[1],{x=550})
					bullet:remove()
				end)
			end)
		end)
	end)
	local boltcount=0
	self.timer:every(1.5,function()
		boltcount=boltcount+1
		if boltcount<6 then
			if boltcount%2==0 then
				self:createBolt(0,2,Game.battle.arena.y-172)
				self:createBolt(0,4,Game.battle.arena.y-172)
				self.timer:after(0.8,function()
					Assets.playSound('bolt',0.8)
				end)
			else
				self:createBolt(0,3,Game.battle.arena.y-172)
				self.timer:after(0.8,function()
					Assets.playSound('bolt',0.7)
				end)
			end
		else
			if boltcount%2==0 then
				self:createBolt(0,2,Game.battle.arena.y-172)
				self:createBolt(0,4,Game.battle.arena.y-172)
				self.timer:after(0.8,function()
					Assets.playSound('bolt',0.8)
				end)
			else
				self:createBolt(0,1,Game.battle.arena.y-172)
				self:createBolt(0,3,Game.battle.arena.y-172)
				self:createBolt(0,5,Game.battle.arena.y-172)
				self.timer:after(0.8,function()
					Assets.playSound('bolt',1)
				end)
			end
		end
	end)
	self.time=18
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	if self.current_time>=0.5 then
		batfollow[1].y=Game.battle.arena.y-Game.battle.arena.height/2
		batfollow[2].y=Game.battle.arena.y-Game.battle.arena.height/2
	end
	if Game.battle.soul.x<250 then
		Game.battle.soul.x=250
	end
end

function Basic:createBolt(x,fixedpos,offsety)
	if not offsety then
		offsety=0
	end
	local boltwarn
	if fixedpos then
		boltwarn=Rectangle(250+28.4*(fixedpos-0.5),0,28.4,243+offsety)
	else
		boltwarn=Rectangle(x,0,28.4,243+offsety)
	end
	boltwarn:setOrigin(0.5,0)
	boltwarn:setColor(1,1,1,0)
	boltwarn:setScale(0.1,1)
	self:addChild(boltwarn)
	self.timer:tween(0.2,boltwarn,{alpha=0.5,scale_x=1},nil,function()self.timer:after(0.6,function()boltwarn:remove()end)end)
	self.timer:after(0.8,function()
		local bullet
		if fixedpos then
			bullet=self:spawnBullet("remilia/bolt",0,fixedpos)
		else
			bullet=self:spawnBullet("remilia/bolt",x)
		end
		bullet.y=bullet.y+offsety
	end)
end

return Basic