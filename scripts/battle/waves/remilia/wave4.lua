local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end
local spawnedpiece=false
function Basic:onStart()
	spawnedpiece=false
	self.timer:every(0.25,function()
		local bullet=self:spawnBullet("remilia/bat",640+20,80,0,5)
		bullet:setSprite('bullets/remilia/bat',1/10,true)
		bullet.destroy_on_hit=false
		bullet.remove_offscreen=false
		bullet.rotation=math.rad(180)
		bullet.physics.match_rotation=true

		local bullet=self:spawnBullet("remilia/bat",640+20,300,0,5)
		bullet:setSprite('bullets/remilia/bat',1/10,true)
		bullet.destroy_on_hit=false
		bullet.remove_offscreen=false
		bullet.rotation=math.rad(180)
		bullet.physics.match_rotation=true
	end)
	self.timer:after(2,function()
		local warnline=Rectangle(self:getAttackers()[1].x,self:getAttackers()[1].y-28,SCREEN_WIDTH,2)
		warnline.rotation=math.rad(180)
		local warnlinecolortweencount=0
		self.timer:every(0.1,function()warnlinecolortweencount=warnlinecolortweencount+1 if warnlinecolortweencount%2==0 then warnline:setColor(1,0,0,0.5)else warnline:setColor(1,1,0,0.5)end end)
		self:addChild(warnline)
		self.timer:after(0.2,function()
			self:getAttackers()[1]:setAnimation('battle/attack')
		end)
		self.timer:after(0.8,function()
			warnline:remove()
			local bullet=self:spawnBullet("remilia/spear",self:getAttackers()[1].x,self:getAttackers()[1].y-28,math.rad(180),50)
			bullet.destroy_on_hit=false
			bullet.remove_offscreen=false
			bullet.rotation=math.rad(180)
			self.timer:after(0.06,function()
				Game.battle.arena.physics.direction=math.rad(180)
				Game.battle.arena.physics.speed=50
				Game.battle.arena.shattered=self:spawnSpriteTo(Game.battle.arena,Assets.getTexture('effects/shatteredarena/arena'),-4,-4)
				Game.battle.arena.shattered:setOrigin(0,0)
				Game.battle.arena.shattered:setScale(0.5,0.5)
			end)
			self.timer:after(0.1,function()
				bullet.physics.friction=3
				Game.battle.arena.physics.friction=3
				self.timer:after(0.1,function()
					self.timer:tween(0.8,bullet,{rotation=0},'in-out-back',function()
						bullet.physics.friction=0
						bullet.physics.direction=0
						bullet.physics.speed=40
						self.timer:after(0.18,function()
							self:getAttackers()[1]:setAnimation('battle/intro')
						end)
						self.timer:after(0.5,function()
							bullet:remove()
						end)
					end)
				end)
			end)
		end)
	end)
	self.timer:after(3,function()
		self.timer:every(2.5,function()
			local bullet=self:spawnBullet("remilia/biground",self:getAttackers()[1].x,self:getAttackers()[1].y-28)
			bullet:setScale(0.2)
			bullet.destroy_on_hit=false
			bullet.physics.match_rotation=true
			bullet.alpha=0
			self.timer:tween(1,bullet,{scale_x=2,scale_y=2,alpha=1},nil,function()
				Assets.playSound('dm_tan1',0.3)
				bullet.rotation=MathUtils.angle(bullet.x,bullet.y,Game.battle.soul.x,Game.battle.soul.y)
				local bigroundrot=bullet.rotation
				bullet.physics.speed=10

				local bullet=self:spawnBullet("remilia/wobblebullet",bullet.x-math.cos(bigroundrot)*20,bullet.y-math.sin(bigroundrot)*20)
				bullet.destroy_on_hit=false
				bullet.physics.direction=bigroundrot
				bullet.physics.speed=8
				for ii=1,4 do
					if ii%2==0 then
						for i=1,2 do
							local bullet=self:spawnBullet("remilia/wobblebullet",bullet.x,bullet.y)
							bullet.destroy_on_hit=false
							bullet.physics.direction=bigroundrot+math.rad(-3+(i-1)*6)
							bullet.physics.speed=8-ii/2
						end
					else
						for i=1,2 do
							local bullet=self:spawnBullet("remilia/wobblebullet",bullet.x,bullet.y)
							bullet.destroy_on_hit=false
							bullet.physics.direction=bigroundrot+math.rad(-10+(i-1)*20)
							bullet.physics.speed=8-ii/2
						end
					end
				end
			end)
		end)
	end)
	self.timer:after(20.9,function()
		Game.battle.arena:setSize(0,0)
	end)
	self.time=21
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if not bullet.remove_offscreen then
			if bullet.x<=-50 then
				bullet.remove_offscreen=true
			end
		end
	end
	if Game.battle.arena then
		if Game.battle.arena.x-Game.battle.arena.width/2<=0 and Game.battle.arena.x~=320 then
			Game.battle.arena.alpha=0
			Game.battle.arena.shattered:remove()
			if not spawnedpiece then
				for i=1,6 do
					local arenapiece=self:spawnSprite(Assets.getTexture('effects/shatteredarena/piece'..i),0,100,BATTLE_LAYERS['below_arena'])
					arenapiece:setScale(0.5,0.5)
					arenapiece:setOrigin(0,0)
					arenapiece.physics.speed_x=MathUtils.random(4,8)
					arenapiece.physics.speed_y=MathUtils.random(-14,-8)
					arenapiece.physics.gravity=0.85
				end
				spawnedpiece=true
			end
			Game.battle.arena.sprite.x=50
			Game.battle.arena.sprite.y=0
			Game.battle.arena.sprite:explode()
			Game.battle.arena:setSize(640,240)
			Game.battle.arena.x=320
			Game.battle.arena.y=190
		end
		if Game.battle.soul.x+Game.battle.soul.width/2>=Game.battle.arena.x+Game.battle.arena.width/2 then
			Game.battle.soul.x=Game.battle.arena.x+Game.battle.arena.width/2-Game.battle.soul.width/2
		end
	end
	if Game.battle.soul.x<0 then
		Game.battle.soul.x=0
	elseif Game.battle.soul.x>640 then
		Game.battle.soul.x=640
	end
end

return Basic