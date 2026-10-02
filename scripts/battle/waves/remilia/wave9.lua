local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

local batfollow={}
function Basic:onStart()
	local batleft=self:spawnBullet("remilia/bat",-20,-20,0,0)
	batleft.destroy_on_hit=false
	batleft.rotation=math.rad(-90)
	batleft:setScale(1.5)
	batleft:setSprite('bullets/remilia/bat',1/10,true)
	self.timer:tween(0.5,batleft,{x=Game.battle.arena.left,y=Game.battle.arena.top},nil,function()batleft:shake(-3,3)end)
	table.insert(batfollow,batleft)

	local batright=self:spawnBullet("remilia/bat",640+20,-20,0,0)
	batright.destroy_on_hit=false
	batright.rotation=math.rad(-90)
	batright:setScale(1.5)
	batright:setSprite('bullets/remilia/bat',1/10,true)
	self.timer:tween(0.5,batright,{x=Game.battle.arena.right,y=Game.battle.arena.top},nil,function()batright:shake(3,3)Assets.playSound('grab')end)
	table.insert(batfollow,batright)

	self.timer:after(0.3,function()
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
	self.time=18
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	if self.current_time>=0.5 then
		batfollow[1].y=Game.battle.arena.y-Game.battle.arena.height/2
		batfollow[2].y=Game.battle.arena.y+Game.battle.arena.height/2
	end
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
			local bullet=self:spawnBullet("remilia/bolt",x)
		end
	end)
end

return Basic