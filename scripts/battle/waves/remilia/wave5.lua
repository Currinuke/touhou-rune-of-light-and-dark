local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onArenaEnter()
	Game.battle.arena:setSize(122,122)
	Game.battle.arena.alpha=0
	return false
end

function Basic:onStart()
	local rectw=Rectangle(190-5,40-5,260+10,260+10)
	rectw:setColor(1,1,1)
	rectw.layer=BATTLE_LAYERS['above_battlers']
	self:spawnObject(rectw)
	local rectb=Rectangle(190+2-5,40+2-5,260-4+10,260-4+10)
	rectb:setColor(0,0,0)
	rectb.layer=BATTLE_LAYERS['above_battlers']
	self:spawnObject(rectb)
	for i=1,20 do
		local bullet
		if i<=6 then--左
			bullet=self:spawnBullet("remilia/bat",0,(i-1)*24.4)
		elseif i<=12 then--右
			bullet=self:spawnBullet("remilia/bat",Game.battle.arena.width,(i-7)*24.4)
		elseif i<=16 then--上
			bullet=self:spawnBullet("remilia/bat",(i-12)*25,0)
		elseif i<=20 then--下
			bullet=self:spawnBullet("remilia/bat",(i-16)*25,Game.battle.arena.height)
		end

		bullet:setSprite('bullets/remilia/bat',1/10,true)
		bullet.rotation=math.rad(-90)
		bullet.destroy_on_hit=false
		bullet.remove_offscreen=false
		bullet:setParent(Game.battle.arena)
	end
	local randomarena=MathUtils.randomInt(1,5)

	local randomarenadir=math.rad(45+randomarena*90+MathUtils.random(-10,10))
	self.timer:after(0.2,function()
		self.timer:tween(0.5,Game.battle.arena.physics,{speed_x=math.cos(randomarenadir)*2.5,speed_y=math.sin(randomarenadir)*2.5})
		self.timer:every(0.01,function()
			local arenadir=math.atan2(Game.battle.arena.physics.speed_y,Game.battle.arena.physics.speed_x)
			Game.battle.arena.physics.speed_x=Game.battle.arena.physics.speed_x+math.cos(arenadir)*0.0015
			Game.battle.arena.physics.speed_y=Game.battle.arena.physics.speed_y+math.sin(arenadir)*0.0015
		end)
	end)
	self.time=20
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		
	end
	if Game.battle.arena.x-Game.battle.arena.width/2<=190
	or Game.battle.arena.x+Game.battle.arena.width/2>=450 then
		Game.battle.arena.physics.speed_x=-Game.battle.arena.physics.speed_x
		Assets.playSound('screenshake')
		Game.battle:shakeCamera()
	end
	if Game.battle.arena.y-Game.battle.arena.height/2<=40
	or Game.battle.arena.y+Game.battle.arena.height/2>=300 then
		Game.battle.arena.physics.speed_y=-Game.battle.arena.physics.speed_y
		Assets.playSound('screenshake')
		Game.battle:shakeCamera()
	end
end

return Basic