local Basic, super = Class(Wave)
--这个回合写的确实有点乱。对。
function Basic:onArenaEnter()
	self:setArenaSize(SCREEN_WIDTH, SCREEN_HEIGHT)
	self:setArenaPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
	-- self:setSoulPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
end

function Basic:getAttackers()
	return {Game.battle.enemies[2]}
end
local scfontstate={
	size=64,
	alpha=0,
	y=400
}
function Basic:draw()
	love.graphics.setFont(Assets.getFont("main",scfontstate.size))
	love.graphics.setColor(1,1,1,scfontstate.alpha)
	love.graphics.printf("「里·四重存在」",630,scfontstate.y,0,'right')
end
local textpartyhp
local textsctime
local kogasahp
local seijahp
local rinhp
local flansprtable={}
function Basic:onStart()
	self.timer:after(0.5,function()
		local flanbspr=Game.battle:addChild(Sprite('enemies/flandre_b/battle/idle',100,70))
		table.insert(flansprtable,flanbspr)
		local flanaspr=Game.battle:addChild(Sprite('enemies/flandre_a/battle/idle',240,70))
		table.insert(flansprtable,flanaspr)
		local flancspr=Game.battle:addChild(Sprite('enemies/flandre_c/battle/idle',380,70))
		table.insert(flansprtable,flancspr)
		local flandspr=Game.battle:addChild(Sprite('enemies/flandre_d/battle/upspin',540,70))
		table.insert(flansprtable,flandspr)
		for _,spr in ipairs(flansprtable) do
			spr:setLayer(BATTLE_LAYERS['below_soul'])
			spr:setOrigin(0.5,0.5)
			spr:setScale(2,2)
			spr:play(1/10)
			spr.alpha=0
			self.timer:tween(0.3,spr,{alpha=1})
		end
		flanbspr.flip_x=true
		flanbspr:setOrigin(0,0.5)
		flanaspr:play(1/5)
	end)
	self.timer:after(1,function()
		self.timer:tween(0.3,scfontstate,{alpha=1})
		self.timer:tween(0.45,scfontstate,{size=32})
		self.timer:after(1.1,function()
			self.timer:tween(1.2,scfontstate,{y=10},'in-out-sine')
		end)
		Assets.playSound('spellcard',0.5)
		local flanscsprtable={}
		local flanbscspr=Game.battle:addChild(Sprite('enemies/flandre_b/battle/idle_1',480,-250))
		table.insert(flanscsprtable,flanbscspr)
		local flanascspr=Game.battle:addChild(Sprite('enemies/flandre_a/battle/idle_1',580,-160))
		table.insert(flanscsprtable,flanascspr)
		local flancscspr=Game.battle:addChild(Sprite('enemies/flandre_c/battle/idle_1',500,-80))
		table.insert(flanscsprtable,flancscspr)
		local flandscspr=Game.battle:addChild(Sprite('enemies/flandre_d/battle/idle_1',540,0))
		table.insert(flanscsprtable,flandscspr)
		for _,spr in ipairs(flanscsprtable) do
			spr:setLayer(BATTLE_LAYERS['bullets']+1)
			spr:setOrigin(0.5,0.5)
			spr:setScale(4,4)
			self.timer:tween(0.3,spr,{y=spr.y+300,alpha=1},nil,function()
				self.timer:tween(1.2,spr,{y=spr.y+40},nil,function()
					self.timer:tween(0.5,spr,{y=spr.y+110,alpha=0},nil,function()
						spr:remove()
					end)
				end)
			end)
		end



		textpartyhp=Game.battle:addChild(Text(
		'[font:smallnumbers][color:#00FFFF]'..Game.party[1].health..'/'..Game.party[1]:getStat('health')..
		'  [color:#CC2929]'..Game.party[2].health..'/'..Game.party[2]:getStat('health')..
		'  [color:#FFFF00]'..Game.party[3].health..'/'..Game.party[3]:getStat('health')))
		textpartyhp.alpha=0
		textpartyhp:setLayer(BATTLE_LAYERS['above_bullets'])
		self.timer:tween(0.3,textpartyhp,{alpha=1})

		self.sctime=30.00
		textsctime=Game.battle:addChild(Text('30.00',320,30,126,66))
		textsctime:setOrigin(0.25,0.25)
		textsctime.alpha=0
		textsctime:setLayer(BATTLE_LAYERS['above_bullets'])
		self.timer:tween(0.3,textsctime,{alpha=1})
		self.timer:every(1,function()
			if self.sctime<=0 then
				textsctime:setScale(1.6,1.6)
				Assets.playSound('sctime1',0.4)
				Assets.playSound('sctime2',0.85)
				self.timer:tween(0.4,textsctime,{scale_x=1,scale_y=1},'out-circ')
				return false
			elseif self.sctime<=5 then
				textsctime:setColor(1,80/255,80/255)
				textsctime:setScale(1.6,1.6)
				Assets.playSound('sctime1',0.4)
				Assets.playSound('sctime2',0.4+0.4/self.sctime)
			elseif self.sctime<=15 then
				textsctime:setColor(1,144/255,144/255)
				textsctime:setScale(1.3,1.3)
				Assets.playSound('sctime1',0.7)
			else
				textsctime:setScale(1.2,1.2)
				Assets.playSound('sctime1',0.5)
			end
			self.timer:tween(0.4,textsctime,{scale_x=1,scale_y=1},'out-circ')
		end)

		self.timer:every(0.01,function()--看了wiki说是频繁调用会卡。试过放在update里会直接显示不出。于是放在这了。
			if textpartyhp then
				textpartyhp:setText(kogasahp..seijahp..rinhp)
				textpartyhp.x,textpartyhp.y=Game.battle.soul.x-100,Game.battle.soul.y-25
			end
			if textsctime then
				textsctime:setText(string.format('%.2f',self.sctime))
			end
		end)
		self.timer:after(1.5,function()
			self.timer:every(1.2,function()
				if self.sctime<=20 then
					Assets.playSound('scbreak',0.3)
					for _,bullet in ipairs(self.bullets) do
						bullet:resetPhysics()
						bullet.collidable=false
						self.timer:tween(0.3,bullet,{alpha=0,scale_x=6,scale_y=6},nil,function()bullet:remove()end)
					end
					return false
				end
				Assets.playSound('dm_tan1',0.15)
				local randompos=MathUtils.randomInt(1,5)
				local randomangle=math.rad(MathUtils.random(0,360))
				for i=1,18 do
					local bullet
					if randompos==1 then
						bullet=self:spawnBullet("flandre/wobblebullet",100,70)
					elseif randompos==2 then
						bullet=self:spawnBullet("flandre/wobblebullet",240,70)
					elseif randompos==3 then
						bullet=self:spawnBullet("flandre/wobblebullet",380,70)
					elseif randompos==4 then
						bullet=self:spawnBullet("flandre/wobblebullet",540,70)
					end
					bullet.physics.direction=math.rad(i*20)+randomangle
					bullet.physics.speed=3
				end
			end)
		end)

		self.timer:after(10,function()
			self.timer:every(0.9,function()
				if self.sctime<=10 then
					Assets.playSound('scbreak',0.3)
					for _,bullet in ipairs(self.bullets) do
						bullet:resetPhysics()
						bullet.collidable=false
						self.timer:tween(0.3,bullet,{alpha=0,scale_x=6,scale_y=6},nil,function()bullet:remove()end)
					end
					return false
				end
				Assets.playSound('dm_tan1',0.15)
				local randompos=MathUtils.randomInt(1,5)
				local randomangle=math.rad(MathUtils.random(0,360))
				for i=1,20 do
					local bullet
					if randompos==1 then
						bullet=self:spawnBullet("flandre/wobblebullet",100,70)
					elseif randompos==2 then
						bullet=self:spawnBullet("flandre/wobblebullet",240,70)
					elseif randompos==3 then
						bullet=self:spawnBullet("flandre/wobblebullet",380,70)
					elseif randompos==4 then
						bullet=self:spawnBullet("flandre/wobblebullet",540,70)
					end
					bullet.physics.direction=math.rad(i*18)+randomangle
					bullet.physics.speed=4
				end
			end)
		end)
		self.timer:after(20,function()
			self.timer:every(0.65,function()
				if self.sctime<=0 then
					Assets.playSound('scbreak',0.3)
					for _,bullet in ipairs(self.bullets) do
						bullet:resetPhysics()
						bullet.collidable=false
						self.timer:tween(0.3,bullet,{alpha=0,scale_x=6,scale_y=6},nil,function()bullet:remove()end)
					end
					return false
				end
				Assets.playSound('dm_tan1',0.15)
				local randompos=MathUtils.randomInt(1,5)
				local randomangle=math.rad(MathUtils.random(0,360))
				for i=1,15 do
					local bullet
					if randompos==1 then
						bullet=self:spawnBullet("flandre/wobblebullet",100,70)
					elseif randompos==2 then
						bullet=self:spawnBullet("flandre/wobblebullet",240,70)
					elseif randompos==3 then
						bullet=self:spawnBullet("flandre/wobblebullet",380,70)
					elseif randompos==4 then
						bullet=self:spawnBullet("flandre/wobblebullet",540,70)
					end
					bullet.physics.direction=math.rad(i*24)+randomangle
					bullet.physics.speed=5
				end
			end)
		end)
	end)
	self.timer:after(31.5,function()self.timer:tween(0.5,textsctime,{alpha=0.1},nil,function()textsctime:remove()end)end)
	self.time=33
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	if self.sctime then
		if self.sctime>0 then
			self.sctime=self.sctime-DTMULT/30
		else
			self.sctime=0
		end
	end
	if Game.party[1].health>0 then
		kogasahp='[font:smallnumbers][color:#00FFFF]'..Game.party[1].health..'/'..Game.party[1]:getStat('health')
	else
		kogasahp='[font:smallnumbers][color:#FF0000]'..Game.party[1].health..'/'..Game.party[1]:getStat('health')
	end
	if Game.party[2].health>0 then
		seijahp='  [color:#CC2929]'..Game.party[2].health..'/'..Game.party[2]:getStat('health')
	else
		seijahp='  [color:#FF0000]'..Game.party[2].health..'/'..Game.party[2]:getStat('health')
	end
	if Game.party[3].health>0 then
		rinhp='  [color:#FFFF00]'..Game.party[3].health..'/'..Game.party[3]:getStat('health')
	else
		rinhp='  [color:#FF0000]'..Game.party[3].health..'/'..Game.party[3]:getStat('health')
	end
	for _,bullet in ipairs(self.bullets) do

	end
end

function Basic:onEnd()
	textpartyhp:remove()
	for _,spr in ipairs(flansprtable) do
		spr:remove()
	end
end

return Basic
