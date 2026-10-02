local Basic, super = Class(Wave)

function Basic:getAttackers()
	return {Game.battle.enemies[1]}
end

function Basic:onStart()
	self.timer:every(0.5,function()--相较于第三回合，生成间隔由0.7s改为0.5s
		self.timer:after(love.math.random()/2,function()--相较于第三回合，随机延迟由0s~0.67s改为0s~0.5s
			Assets.playSound('ui_move')
			local randomside=MathUtils.randomInt(1,5)
			local randomposx
			local randomposy
			local randomspin=math.rad(MathUtils.random(-6,6))
			if randomside==1 then--from.左
				randomposx=-50
				randomposy=MathUtils.random(-50,480+50)
			elseif randomside==2 then--from.右
				randomposx=640+50
				randomposy=MathUtils.random(-50,480+50)
			elseif randomside==3 then--from.上
				randomposx=MathUtils.random(-50,640+50)
				randomposy=-50
			elseif randomside==4 then--from.下
				randomposx=MathUtils.random(-50,640+50)
				randomposy=480+50
			end
			local angle=MathUtils.angle(randomposx,randomposy,Game.battle.soul.x,Game.battle.soul.y)

			local bullet=self:spawnBullet("remilia/chainarrow",randomposx,randomposy,0,0)
			bullet.collidable=false
			bullet.remove_offscreen=false
			bullet.rotation=angle-randomspin*5
			bullet.physics.match_rotation=true
			bullet.physics.speed=120
			bullet.graphics.spin=randomspin*2
			bullet.alpha=0
			local warnlinecount=0
			self.timer:every(0.005,function()
				warnlinecount=warnlinecount+1
				local warnline=Rectangle(bullet.x,bullet.y,20,1)
				warnline.rotation=bullet.rotation
				warnline:setColor(1,0,0,1)
				self:addChild(warnline)
				if warnlinecount>=100 then
					return false
				end
				self.timer:after(1,function()warnline:remove()end)
			end)

			self.timer:after(1,function()
				Assets.playSound('spearappear')
				local bullet=self:spawnBullet("remilia/chainarrow",randomposx,randomposy,0,0)
				bullet.remove_offscreen=false
				bullet.rotation=angle-randomspin*5
				bullet.physics.match_rotation=true
				bullet.graphics.spin=randomspin
				bullet.physics.speed=60
				local chaincount=0
				self.timer:every(0.05,function()
					chaincount=chaincount+1
						local bullet=self:spawnBullet("remilia/chain",randomposx,randomposy,0,0)
						bullet.remove_offscreen=false
						bullet.rotation=angle-randomspin*5
						bullet.physics.match_rotation=true
						bullet.graphics.spin=randomspin
						bullet.physics.speed=60
					if chaincount>=12 then
						return false
					end
				end)
			end)
		end)
	end)
	self.time=20
	self.current_time=0
end

function Basic:update()
	super.update(self)
	self.current_time=self.current_time+DTMULT/30
	for _,bullet in ipairs(self.bullets) do
		if bullet.x>=0 and bullet.x<=640 and bullet.y>=0 and bullet.y<=480 and not bullet.remove_offscreen then
			bullet.remove_offscreen=true
		end
	end
end

return Basic