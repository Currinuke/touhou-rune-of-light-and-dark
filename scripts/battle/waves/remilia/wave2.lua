local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end
local batfollow={}
local spinbullet={}
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

	
	
	self.timer:after(0.5,function()
		local bullet=self:spawnBullet("remilia/bat",250,50,0,0)
		bullet.alpha=0
		bullet:setScale(0.1)
		self.timer:tween(0.3,bullet,{scale_x=1,scale_y=1,alpha=1})
		table.insert(spinbullet,bullet)

		local bullet=self:spawnBullet("remilia/bat",390,50,0,0)
		bullet.alpha=0
		bullet:setScale(0.1)
		self.timer:tween(0.3,bullet,{scale_x=1,scale_y=1,alpha=1})
		table.insert(spinbullet,bullet)

		local bullet=self:spawnBullet("remilia/bat",250,290,0,0)
		bullet.alpha=0
		bullet:setScale(0.1)
		self.timer:tween(0.3,bullet,{scale_x=1,scale_y=1,alpha=1})
		table.insert(spinbullet,bullet)

		local bullet=self:spawnBullet("remilia/bat",390,290,0,0)
		bullet.alpha=0
		bullet:setScale(0.1)
		self.timer:tween(0.3,bullet,{scale_x=1,scale_y=1,alpha=1})
		table.insert(spinbullet,bullet)


		self.timer:every(0.5,function()
			local bullet=self:spawnBullet("remilia/bat",250,290,0,0)
			bullet:setSprite('bullets/remilia/bat',1/10,true)
			bullet.rotation=math.rad(-90)
			bullet.alpha=0
			bullet.physics.match_rotation=true
			bullet:setScale(0.1)
			self.timer:tween(0.3,bullet,{scale_x=0.75,scale_y=0.75,alpha=1},nil,function()bullet.physics.speed=5 end)
			bullet.needtrans=true
			bullet.fromup=false

			local bullet=self:spawnBullet("remilia/bat",390,50,0,0)
			bullet:setSprite('bullets/remilia/bat',1/10,true)
			bullet.rotation=math.rad(90)
			bullet.alpha=0
			bullet.physics.match_rotation=true
			bullet:setScale(0.1)
			self.timer:tween(0.3,bullet,{scale_x=0.75,scale_y=0.75,alpha=1},nil,function()bullet.physics.speed=5 end)
			bullet.needtrans=true
			bullet.fromup=true
		end)
	end)
	self.time=12
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	if self.current_time>=1 then
		Game.battle.arena.x=320+math.sin((self.current_time-1)*1.5)*160
		batfollow[1].x=Game.battle.arena.x-Game.battle.arena.width/2
		batfollow[2].x=Game.battle.arena.x+Game.battle.arena.width/2
	end
	for _,bullet in ipairs(spinbullet) do
		bullet.rotation=bullet.rotation+math.rad(3)
	end
	for _,bullet in ipairs(self.bullets) do
		if bullet.needtrans then
			if bullet.fromup then
				if bullet.y>=290 then
					bullet.needtrans=false
					bullet.physics.speed=0
					self.timer:tween(0.3,bullet,{scale_x=0.1,scale_y=0.1,alpha=0},nil,function()bullet:remove()end)
				end
			else
				if bullet.y<=50 then
					bullet.needtrans=false
					bullet.physics.speed=0
					self.timer:tween(0.3,bullet,{scale_x=0.1,scale_y=0.1,alpha=0},nil,function()bullet:remove()end)
				end
			end
		end
	end
end

return Basic