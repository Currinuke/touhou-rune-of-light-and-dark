local Flandre, super = Class(Encounter)

function Flandre:init()
	super.init(self)
	self.text = Game:loc("encounter_flandre_start")
	self.music = "joker"
	self.background = false

	--其实我也不知道怎么写了就这样吧。
	self.flanb = self:addEnemy("flandre",536,156)
	self.flanb.x,self.flanb.y=536,156
	self.flanb.name = Game:loc("enemy_flandreB_name")
	self.flanb.check = Game:loc("enemy_flandreB_check")
	self.flanb:setActor("flandre_b")

	self.flanc = self:addEnemy("flandre",496,277)
	self.flanc.x,self.flanc.y=496,277
	self.flanc.name = Game:loc("enemy_flandreC_name")
	self.flanc.check = Game:loc("enemy_flandreC_check")
	self.flanc:setActor("flandre_c")

	self.fland = self:addEnemy("flandre",578,323)
	self.fland.x,self.fland.y=578,323
	self.fland.name = Game:loc("enemy_flandreD_name")
	self.fland.check = Game:loc("enemy_flandreD_check")
	self.fland:setActor("flandre_d")
	
	self.no_end_message = true
end

function Flandre:getPartyPosition(index)
	--对然后我把这个抄过来了。
	local posx,posy
	if index==1 then
		posx,posy=169,185
	elseif index==2 then
		posx,posy=130,256
	elseif index==3 then
		posx,posy=100,310
	end
	return posx,posy
end
local curtime=0
function Flandre:update()
	super.update(self)
	curtime=curtime+DTMULT
	if self.flanb.sprite.anim=='battle/tired' then
		self.flanb.y=156+math.sin(math.rad(curtime*5))*8
	else
		self.flanb.y=156
	end
end

function Flandre:onStateChange(old,new)
	if old=='INTRO' and new=='ACTIONSELECT' and Game.battle.turn_count==1 then
		self.flanc:setAnimation('battle/idle')
	end
end

function Flandre:onBattleInit()
	self.tired_points = 0
	self.spin_effect = false
	self.turn_effect = 0
	self.turn_effects = {}
	self.enemy_data = {
		["attack"] = Game.battle.enemies[1].attack,
		["defense"] = Game.battle.enemies[1].defense
	}
	self.member_data = {}
	for _, member in ipairs(Game.battle.party) do
		self.member_data[member.chara.id] = {}
		local spells = member.chara:getSpells()
		for index, spell in ipairs(spells) do
			self.member_data[member.chara.id][index] = spell:getTPCost(member.chara)
		end
	end
end

function Flandre:onTurnEnd()
	self.tired_points = self.tired_points + 1

	if self.spin_effect then
		-- 回退行动效果
		local turn = self.turn_effect
		local enemies = Game.battle.enemies
		self.turn_effects[turn] = self.turn_effects[turn] or 0
		local effects = self.turn_effects[turn] or 0

		if turn == 1 then
			if effects == 2 then
				for _, enemy in ipairs(enemies) do
					enemy.attack = self.enemy_data["attack"]
				end
				self.turn_effects[1] = 1
			end
		elseif turn == 7 then
		elseif turn == 8 then
			for _, enemy in ipairs(enemies) do
				enemy.attack = self.enemy_data["attack"]
			end
			self.turn_effects[8] = 0
		end
		self.spin_effect = false
	end
end

function Flandre:onActionsEnd()
	local enemies = Game.battle.enemies

	for turn, effect in ipairs(self.turn_effects) do
		-- 上回合遗留的效果
		if turn == 1 then
			if effect == 1 then
				for _, enemy in ipairs(enemies) do
					enemy.defense = self.enemy_data["defense"]
				end
				self.turn_effects[1] = 0
			end
		end
	end

	if self.spin_effect then
		-- 使用行动效果
		local turn = self.turn_effect

		if turn == 1 then
			self.turn_effects[1] = 2
		elseif turn == 3 then
			self.turn_effects[3] = (self.turn_effects[3] or 0) + 1
		elseif turn == 7 then
			self.turn_effects[7] = (self.turn_effects[7] or 0) + 1
		elseif turn == 8 then
			self.turn_effects[8] = 1
		end
	end
end

function Flandre:createSoul(x, y, color)
	return DoubleSoul(x, y, color)
end

return Flandre