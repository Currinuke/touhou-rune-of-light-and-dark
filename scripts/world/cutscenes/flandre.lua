return {
	outside = function(cutscene, event)
		local kogasa = cutscene:getCharacter("kogasa")
		local seija = cutscene:getCharacter("seija")
		local rin = cutscene:getCharacter("rin")
		
		local x = event.x + event.width/2
		local y = event.y + event.height/2

		if kogasa and seija and rin then
			cutscene:detachCamera()
			cutscene:detachFollowers()
			cutscene:walkTo(kogasa, x, y + 60, 1, "up")
			cutscene:walkTo(seija, x - 40, y + 80, 1, "up")
			cutscene:walkTo(rin, x + 40, y + 80, 1, "up")
			cutscene:wait(1)

			-- 没写钥匙之类的其它东西，所以默认拿到钥匙了
			--[[cutscene:text("* We bring the key.", "smile", "kogasa")
			cutscene:text("* So?\n[wait:5]Are you coming out or what?", "bangs/smile", "seija")
			cutscene:wait(0.5)
			cutscene:text("* Out...? [wait:5]Aren't you misunderstanding something?")
			cutscene:text("* It's not about me going out.\n[wait:5]It's about you coming in.")
			cutscene:wait(0.5)
			cutscene:text("* Come in... [wait:10]and play a little game with me.")]]
			cutscene:text("* 我们把钥匙带来了。", "smile", "kogasa")
			cutscene:text("* 所以呢?\n[wait:5]你是打算出来还是什么?", "bangs/smile", "seija")
			cutscene:wait(0.5)
			cutscene:text("* 出去...?\n[wait:5]你们是不是搞错了什么?")
			cutscene:text("* 我需要的不是出去，\n[wait:5]而是你们进来。")
			cutscene:wait(0.5)
			cutscene:text("* 进来...\n[wait:10]陪我玩个小小的游戏。")

			cutscene:walkTo(kogasa, x, y + 20, 0.5, "up")
			cutscene:walkTo(seija, x - 20, y + 40, 0.5, "up")
			cutscene:walkTo(rin, x + 20, y + 40, 0.5, "up")
			cutscene:wait(0.3)
			Assets.playSound('dooropen')
			cutscene:mapTransition("rm_flandre", "entry", "up", function()
			end)
			cutscene:wait(0.3)
			Assets.playSound('doorclose')
			cutscene:gotoCutscene('flandre.inside')
		end
	end,

	inside=function(cutscene,event)
		local kogasa = cutscene:getCharacter("kogasa")
		local seija = cutscene:getCharacter("seija")
		local rin = cutscene:getCharacter("rin")
		local flana = cutscene:getCharacter("flandre_a")
		local flanb = cutscene:getCharacter("flandre_b")
		local flanc = cutscene:getCharacter("flandre_c")
		local fland = cutscene:getCharacter("flandre_d")

		if kogasa and seija and rin then
			cutscene:detachCamera()
			cutscene:detachFollowers()
			seija.x=kogasa.x-45
			seija.y=kogasa.y+40
			rin.x=kogasa.x+45
			rin.y=kogasa.y+40

			cutscene:walkTo(kogasa, 420, 200, 1, "up",true)
			cutscene:walkTo(seija, 375, 240, 1, "up",true)
			cutscene:walkTo(rin, 465, 240, 1, "up",true)
			cutscene:wait(1)
			cutscene:text("* 芙兰朵露，\n[wait:5]你想和我们玩什么游戏呢?", "smile", "rin")
			cutscene:text("* 看来你们又搞错了，\n[wait:5]需要你们陪着玩游戏的不是我...")
			cutscene:wait(0.3)
			cutscene:slideTo(flanb, flanb.x, 156,0.2)
			cutscene:slideTo(flanc, flanc.x, 277,0.2)
			cutscene:slideTo(fland, fland.x, 323,0.2)
			cutscene:wait(0.2)
			Assets.playSound('impact')
			cutscene:look(kogasa,'right')
			cutscene:look(seija,'right')
			cutscene:look(rin,'right')
			cutscene:slideTo(kogasa, 270, 200,0.2)
			cutscene:slideTo(seija, 225, 240,0.2)
			cutscene:slideTo(rin, 315, 240,0.2)
			cutscene:wait(0.2)
			cutscene:setSprite(rin, "battle/hurt")
			cutscene:shakeCharacter(rin, 4, 0, 2)
			cutscene:wait(0.3)
			cutscene:text("* 而是她们!")
			cutscene:text("* 还有三个你?!", "surprise", "rin")
			cutscene:resetSprite(rin)
			cutscene:look(rin,'right')
			cutscene:text("* [speed:0.5]...", "bangs/neutral_narrow", "seija")
			cutscene:look(kogasa,'down')
			cutscene:look(seija,'down')
			cutscene:look(rin,'left')
			cutscene:text("* 我们可是大忙人，\n[wait:5]有正经的事去干。", "bangs/neutral", "seija")
			cutscene:look(seija,'right')
			cutscene:text("* 没空陪这么多个你瞎闹。", "bangs/neutral", "seija")
			cutscene:walkTo(kogasa, 270, 300, 4, "right")
			cutscene:walkTo(seija, 225, 340, 4, "right")
			cutscene:walkTo(rin, 315, 340, 4, "right")
			cutscene:setAnimation(flanb,'battle/tired')
			local curtime=0.495
			local flanbfloat=Game.stage.timer:every(DTMULT/30,function()curtime=curtime+DTMULT flanb.y=156+math.sin(math.rad(curtime*5))*8 end)
			cutscene:text("[noskip]* 拜托，这也太扫兴了吧!\n[wait:5]游戏甚至都还没开始呢![speed:0.1]  ",nil,nil,{auto=true})
			Game.stage.timer:cancel(flanbfloat)
			cutscene:setAnimation(flanb,'battle/idle')
			cutscene:setAnimation(fland,'battle/upspin')
			cutscene:text("[noskip]* 游戏还没开始就投降可是要受惩罚的![speed:0.1]  ",nil,nil,{auto=true})
			cutscene:setAnimation(fland,'battle/idle')
			cutscene:setAnimation(flanc,'talk')
			cutscene:text("* 而作为惩罚...")
			cutscene:wait(0.5)
			cutscene:setAnimation(flanc,'handopen')
			cutscene:setSprite(rin, "battle/hurt")
			cutscene:shakeCharacter(rin, 4, 0, 2)
			cutscene:text("* 就让我捏碎那个付丧神的目好了!")
			cutscene:setAnimation(flanc,'handclose')
			flana.sprite:stop()
			flanb.sprite:stop()
			fland.sprite:stop()
			local rect=Rectangle(0,0, SCREEN_WIDTH+500, SCREEN_HEIGHT+500)
			rect:setColor(0,0,0,0)
			Game.world:addChild(rect)
			rect:setLayer(WORLD_LAYERS["below_ui"])
			rect.alpha=0.5
			local soul=Game.world:addChild(Sprite('player/heart',268,267))
			soul:setOrigin(0.5,0.5)
			soul:setColor(1,0,0,1)
			soul:setLayer(WORLD_LAYERS["above_ui"])
			Assets.playSound('hurt')
			cutscene:wait(0.1)
			rect.alpha=1
			soul:setSprite('player/heart_break')
			Assets.playSound('break1')

			cutscene:wait(2)
			rect.alpha=0.5
			local soulshakecount=0
			Game.stage.timer:every(0.05,function()
				soulshakecount=soulshakecount+1
				Assets.playSound('graze')
				if soulshakecount%2==0 then
					soul.x=266
				else
					soul.x=270
				end
				if soulshakecount==20 then
					soul.x=268
					return false
				end
			end)
			cutscene:wait(1)
			soul:setSprite('player/heart')
			Game.stage.timer:tween(0.5,soul,{alpha=0.1,scale_x=5,scale_y=5},nil,function()soul:remove()end)
			Assets.playSound('greatshine')
			local soulleft=Game.world:addChild(Sprite('player/heart_dodge_left',268,267))
			soulleft:setOrigin(0.5,0.5)
			soulleft:setLayer(WORLD_LAYERS["above_ui"])
			Game.stage.timer:tween(0.3,soulleft,{x=268-50,y=200})
			local soulright=Game.world:addChild(Sprite('player/heart_dodge_right',268,267))
			soulright:setOrigin(0.5,0.5)
			soulright:setLayer(WORLD_LAYERS["above_ui"])
			Game.stage.timer:tween(0.3,soulright,{x=268+150,y=200})
			cutscene:wait(1)
			--我知道这段可能很构式但是我也不知道怎么写了。
			soulleft.collider = CircleCollider(soulleft, 0, 0, 8)
			soulright.collider = CircleCollider(soulright, 0, 0, 8)
			local bulletTable={}
			local soulspeed=4
			local soulinv=false
			local invtime=0
			local curtime=0
			local swap_sfx = Assets.getSound("doublesoul/transition")
			local timer_swap=0
			local transformed=false
			local canmove=true
			local soullefttrans=Game.world:addChild(Sprite('player/heart_dodge_right',soulleft.x,soulleft.y))
			soullefttrans:setOrigin(0.5,0.5)
			soullefttrans:setLayer(WORLD_LAYERS["top"])
			soullefttrans.alpha=0
			local soulrighttrans=Game.world:addChild(Sprite('player/heart_dodge_left',soulright.x,soulright.y))
			soulrighttrans:setOrigin(0.5,0.5)
			soulrighttrans:setLayer(WORLD_LAYERS["top"])
			soulrighttrans.alpha=0
			local soulUpdate=Game.stage.timer:during(math.huge,function()
				curtime=curtime+DTMULT/30
				if Input.down("cancel") then
					soulspeed=2
				else
					soulspeed=4
				end
				if canmove then
					if Input.down("left") then
						if soulleft.x-soulleft.width/2>=0 then
							soulleft.x=soulleft.x-soulspeed*DTMULT
							soulright.x=soulright.x-soulspeed*DTMULT
						end
					end
					if Input.down("right") then
						if soulright.x+soulright.width/2<=SCREEN_WIDTH then
							soulleft.x=soulleft.x+soulspeed*DTMULT
							soulright.x=soulright.x+soulspeed*DTMULT
						end
					end
					if Input.down("up") then
						if soulright.y-soulright.height/2>=20 then--防止大玉看不见。等等话说这个真的有用吗。，，
							soulleft.y=soulleft.y-soulspeed*DTMULT
							soulright.y=soulright.y-soulspeed*DTMULT
						end
					end
					if Input.down("down") then
						if soulright.y+soulright.height/2<=SCREEN_HEIGHT then
							soulleft.y=soulleft.y+soulspeed*DTMULT
							soulright.y=soulright.y+soulspeed*DTMULT
						end
					end
				end
				for _,bullet in ipairs(bulletTable) do
					if bullet.collider:collidesWith(soulleft.collider) or bullet.collider:collidesWith(soulright.collider) then
						if not soulinv then
							soulinv=true
							Assets.playSound('hurt')
							cutscene:shakeCamera()
							if Game.party[1].health>20 then--想了想还是加上扣血吧。
								Game.party[1].health=Game.party[1].health-10
							else
								Game.party[1].health=1
							end
							Game.stage.timer:after(Game:getConfig("defaultInvulnTime")/30,function()soulinv=false end)
						end
					end
				end
				invtime=invtime+DTMULT/30/(4/30)
				if soulinv and math.floor(invtime)%2==1 then
					soulleft:setColor(0.5,0.5,0.5,1)
					soulright:setColor(0.5,0.5,0.5,1)
				else
					soulleft:setColor(1,1,1,1)
					soulright:setColor(1,1,1,1)
				end




				if curtime>=6 and not transformed then
					if Input.down("confirm") then
						timer_swap = (timer_swap or 0) + DTMULT

						if timer_swap >= 30 then
							soulleft:setSprite('player/heart_dodge_right')
							soulright:setSprite('player/heart_dodge_left')
							timer_swap = 0

							swap_sfx:stop()
							Assets.playSound('noise')

							local soulvfxleft=Game.world:addChild(Sprite('effects/doublesoul/heart_dodge_full',soulleft.x,soulleft.y))
							soulvfxleft:setOrigin(0.5,0.5)
							soulvfxleft:setLayer(WORLD_LAYERS["top"])
							Game.stage.timer:tween(0.3,soulvfxleft,{alpha=0.1,scale_x=5,scale_y=5},nil,function()soulvfxleft:remove()end)
							local soulvfxright=Game.world:addChild(Sprite('effects/doublesoul/heart_dodge_full',soulright.x,soulright.y))
							soulvfxright:setOrigin(0.5,0.5)
							soulvfxright:setLayer(WORLD_LAYERS["top"])
							Game.stage.timer:tween(0.3,soulvfxright,{alpha=0.1,scale_x=5,scale_y=5},nil,function()soulvfxright:remove()end)
							transformed=true
							soullefttrans:remove()
							soulrighttrans:remove()
						else
							swap_sfx:setVolume(MathUtils.clamp(timer_swap/15, 0, 1))
							if not swap_sfx:isPlaying() then
								swap_sfx:play()
							end
						end
					else
						timer_swap = 0
						swap_sfx:stop()
					end
					soullefttrans.alpha=timer_swap/30
					soulrighttrans.alpha=timer_swap/30
				end
			end)
			cutscene:wait(0.5)
			for i=1,4 do--手搓子弹？？，，(何意味。
				local bullet=Game.world:addChild(Sprite('bullets/flandre/diamondbullet',SCREEN_WIDTH+20,soulleft.y+(i-2)*20))
				bullet:setLayer(WORLD_LAYERS["top"])
				bullet.collider=Hitbox(bullet,bullet.width/4,bullet.height/4, bullet.width/2, bullet.height/2)
				bullet.physics.speed_x=-8
				table.insert(bulletTable,bullet)
			end
			Assets.playSound('dm_tan2',0.3)
			cutscene:wait(2)
			for i=1,4 do
				local bullet=Game.world:addChild(Sprite('bullets/flandre/diamondbullet',-20,soulleft.y+(i-4)*20))
				bullet:setLayer(WORLD_LAYERS["top"])
				bullet.collider=Hitbox(bullet, bullet.width/4, bullet.height/4, bullet.width/2.5-2, bullet.height/3-2)
				bullet.physics.speed_x=8
				table.insert(bulletTable,bullet)
			end
			Assets.playSound('dm_tan2',0.3)
			cutscene:wait(2)
			local br1=Game.world:addChild(Sprite('bullets/flandre/biground',soulleft.x,soulleft.y-500))
			br1:setScale(2,2)
			br1:setOrigin(0.5,0.5)
			br1:setLayer(WORLD_LAYERS["top"])
			br1:setColor(1,0,0)
			Game.stage.timer:tween(0.3,br1,{y=soulleft.y-80})
			local br2=Game.world:addChild(Sprite('bullets/flandre/biground',soulright.x,soulleft.y-500))
			br2:setScale(2,2)
			br2:setOrigin(0.5,0.5)
			br2:setLayer(WORLD_LAYERS["top"])
			br2:setColor(0,1,1)
			Game.stage.timer:tween(0.3,br2,{y=soulright.y-80})
			canmove=false
			cutscene:wait(0.3)
			Assets.playSound('noise')
			rect.alpha=1
			soullefttrans.x,soullefttrans.y=soulleft.x,soulleft.y
			soulrighttrans.x,soulrighttrans.y=soulright.x,soulright.y
			cutscene:wait(1)
			local hinttext=Game.world:addChild(Sprite('hint_cn',soulleft.x+100,soulleft.y-500))
			hinttext:setScale(0.5,0.5)
			hinttext:setOrigin(0.5,0.5)
			hinttext:setLayer(WORLD_LAYERS["top"])
			--[[local hinttext=Game.world:addChild(Text('',soulleft.x+20,0,nil,nil,{font='zh_main',font_size=36}))
			hinttext:setLayer(WORLD_LAYERS['top'])
			hinttext:setText('(长按[bind:confirm]键)')]]

			if soulleft.y>=450 then
				hinttext.y=soulleft.y-30
			else
				hinttext.y=soulleft.y+30
			end
			cutscene:wait(function()
				return transformed
			end)
			hinttext:remove()
			canmove=true
			rect.alpha=0.5
			Game.stage.timer:tween(0.5,br1,{y=800})
			Game.stage.timer:tween(0.5,br2,{y=800})
			cutscene:wait(2)

			Game.stage.timer:cancel(soulUpdate)
			for _,bullet in ipairs(bulletTable) do
				bullet:remove()
			end
			soulleft:remove()
			soulright:remove()
			rect:remove()
			cutscene:setAnimation(flanc,'idle')
			flana.sprite:resetSprite()
			flanb.sprite:resetSprite()
			fland.sprite:resetSprite()
			Assets.playSound('noise')
			Assets.playSound('hurt')
			cutscene:setAnimation(kogasa, "battle/defeat")
			cutscene:wait(0.5)
			cutscene:resetSprite(rin)
			cutscene:look(rin,'up')
			cutscene:text("* 小伞，[wait:5]你还好吗?!", "sad", "rin")
			cutscene:text("* 我-[wait:3][face:bangs/sad]我没事，[wait:5]\n就是...[wait:5]感觉有些怪怪的...", "bangs/neutral", "kogasa")
			cutscene:text("* 虽然不知道你到底做了什么，\n[wait:5]但既然你想打...", "bangs/smile", "seija")
			cutscene:playSound("laz_c", nil, 0.9)
			cutscene:setAnimation(seija, "battle/attack")
			cutscene:wait(0.3)
			cutscene:resetSprite(kogasa)
			cutscene:look(kogasa,'down')
			cutscene:shakeCharacter(kogasa, 4, 0, 2)
			cutscene:wait(1)
			cutscene:look(kogasa,'right')
			cutscene:look(rin,'right')
			cutscene:text("* 那就放马过来吧!", "bangs/smile", "seija")
			cutscene:startEncounter("flandre", true, nil, {on_start = function()
				-- rumia:setFlag("dont_load", true)
				-- rumia:remove()
				flanb:remove()
				flanc:remove()
				fland:remove()
			end})
		end
	end
}
