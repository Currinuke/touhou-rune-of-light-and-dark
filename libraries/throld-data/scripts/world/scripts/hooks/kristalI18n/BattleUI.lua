local BattleUI, super = HookSystem.hookScript(BattleUI)

-- 用一种恶劣的方式修复显示问题
local function isCjkCodepoint(codepoint)
	return (codepoint >= 0x2E80 and codepoint <= 0x9FFF)
		or (codepoint >= 0xF900 and codepoint <= 0xFAFF)
		or (codepoint >= 0xFE10 and codepoint <= 0xFE1F)
		or (codepoint >= 0xFF00 and codepoint <= 0xFFEF)
		or (codepoint >= 0x20000 and codepoint <= 0x2FA1F)
end

local function hasCjkText(text)
	for _, codepoint in utf8.codes(text) do
		if isCjkCodepoint(codepoint) then
			return true
		end
	end
	return false
end
		
local function hasMultipleCodepoints(text)
	local count = 0
	for _ in utf8.codes(text) do
		count = count + 1
		if count > 1 then
			return true
		end
	end
	return false
end

local function shouldPrintWithCjkSpacing(text)
	return type(text) == "string"
		and Game.lang == "zh_hans"
		and hasCjkText(text)
		and hasMultipleCodepoints(text)
	end

local function getCjkPrintedTextWidth(font, text)
	local width = 0
	for _, codepoint in utf8.codes(text) do
		local char = utf8.char(codepoint)
		width = width + font:getWidth(char)
		if isCjkCodepoint(codepoint) then
			width = width + Kristal.getLibConfig("kristalI18n", "cjkFixedTextSpacing")
		end
	end
	return width
end

local function getPrintedLineWidth(font, text)
	text = tostring(text or "")
	if shouldPrintWithCjkSpacing(text) then
		return getCjkPrintedTextWidth(font, text)
	end
	return font:getWidth(text)
end

local function getPrintedTextWidth(font, text)
	local width = 0
	for line in (tostring(text or "") .. "\n"):gmatch("(.-)\n") do
		width = math.max(width, getPrintedLineWidth(font, line))
	end
	return width
end

function BattleUI:drawState()
	if Game.battle.state == "ENEMYSELECT" then
		local enemies = Game.battle.enemies_index

		local page = math.ceil(Game.battle.current_menu_y / 3) - 1
		local max_page = math.ceil(#enemies / 3) - 1
		local page_offset = page * 3

		Draw.setColor(Game.battle.encounter:getSoulColor())
		Draw.draw(self.heart_sprite, 55, 30 + ((Game.battle.current_menu_y - page_offset) * 30))

		local font = Assets.getFont("main")
		love.graphics.setFont(font)

		local draw_mercy = Game:getConfig("mercyBar")
		local draw_percents = Game:getConfig("enemyBarPercentages")

		Draw.setColor(1, 1, 1, 1)

		if draw_mercy then
			if Game.battle.state_reason ~= "XACT" then
				love.graphics.print("HP", 424, 39, 0, 1, 0.5)
			end
			love.graphics.print("MERCY", 524, 39, 0, 1, 0.5)
		end

		for _, enemy in ipairs(Game.battle:getActiveEnemies()) do
			if self.xact_x_pos < getPrintedTextWidth(font, enemy.name) + 142 then
				self.xact_x_pos = getPrintedTextWidth(font, enemy.name) + 142
			end
		end

		for index = page_offset + 1, math.min(page_offset + 3, #enemies) do
			local enemy = enemies[index]
			local y_off = (index - page_offset - 1) * 30

			if enemy then
				---@cast enemy EnemyBattler
				local name_colors = enemy:getNameColors()
				if type(name_colors) ~= "table" then
					name_colors = { name_colors }
				end

				if #name_colors <= 1 then
					Draw.setColor(name_colors[1] or enemy.selectable and { 1, 1, 1 } or { 0.5, 0.5, 0.5 })
					love.graphics.print(enemy.name, 80, 50 + y_off)
				else
					-- Draw the enemy name to a canvas first
					local canvas = Draw.pushCanvas(getPrintedTextWidth(font, enemy.name), font:getHeight())
					Draw.setColor(1, 1, 1)
					love.graphics.print(enemy.name)
					Draw.popCanvas()

					-- Define our gradient
					local color_canvas = Draw.pushCanvas(#name_colors, 1)
					for i = 1, #name_colors do
						-- Draw a pixel for the color
						Draw.setColor(name_colors[i])
						love.graphics.rectangle("fill", i - 1, 0, 1, 1)
					end
					Draw.popCanvas()

					-- Reset the color
					Draw.setColor(1, 1, 1)

					-- Use the dynamic gradient shader for the spare/tired colors
					local shader = Kristal.Shaders["DynGradient"]
					love.graphics.setShader(shader)
					-- Send the gradient colors
					shader:send("colors", color_canvas)
					shader:send("colorSize", { #name_colors, 1 })
					-- Draw the canvas from before to apply the gradient over it
					Draw.draw(canvas, 80, 50 + y_off)
					-- Disable the shader
					love.graphics.setShader()
				end

				Draw.setColor(1, 1, 1)

				local spare_icon = false
				local tired_icon = false
				if enemy.tired and enemy:canSpare() then
					Draw.draw(self.sparestar, 80 + getPrintedTextWidth(font, enemy.name) + 20, 60 + y_off)
					Draw.draw(self.tiredmark, 80 + getPrintedTextWidth(font, enemy.name) + 40, 60 + y_off)
					spare_icon = true
					tired_icon = true
				elseif enemy.tired then
					Draw.draw(self.tiredmark, 80 + getPrintedTextWidth(font, enemy.name) + 40, 60 + y_off)
					tired_icon = true
				elseif enemy.mercy >= 100 then
					Draw.draw(self.sparestar, 80 + getPrintedTextWidth(font, enemy.name) + 20, 60 + y_off)
					spare_icon = true
				end

				for i = 1, #enemy.icons do
					if enemy.icons[i] then
						if (spare_icon and (i == 1)) or (tired_icon and (i == 2)) then
							-- Skip the custom icons if we're already drawing spare/tired ones
						else
							Draw.setColor(1, 1, 1, 1)
							Draw.draw(enemy.icons[i], 80 + getPrintedTextWidth(font, enemy.name) + (i * 20), 60 + y_off)
						end
					end
				end

				if Game.battle.state_reason == "XACT" then
					Draw.setColor(Game.battle.party[Game.battle.current_selecting].chara:getXActColor())
					if Game.battle.selected_xaction.id == 0 then
						love.graphics.print(enemy:getXAction(Game.battle.party[Game.battle.current_selecting]), self.xact_x_pos, 50 + y_off)
					else
						love.graphics.print(Game.battle.selected_xaction.name, self.xact_x_pos, 50 + y_off)
					end
				else
					local namewidth = getPrintedTextWidth(font, enemy.name)

					Draw.setColor(128 / 255, 128 / 255, 128 / 255, 1)


					if ((80 + namewidth + 60 + (font:getWidth(enemy.comment) / 2)) < 415) then
						love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off)
					else
						love.graphics.print(enemy.comment, 80 + namewidth + 60, 50 + y_off, 0, 0.5, 1)
					end


					local hp_percent = enemy.health / enemy.max_health

					local hp_x = draw_mercy and 420 or 510

					if enemy.selectable then
						-- Draw the enemy's HP
						Draw.setColor(PALETTE["action_health_bg"])
						love.graphics.rectangle("fill", hp_x, 55 + y_off, 81, 16)

						Draw.setColor(PALETTE["action_health"])
						love.graphics.rectangle("fill", hp_x, 55 + y_off, math.ceil(hp_percent * 81), 16)

						if draw_percents then
							Draw.setColor(PALETTE["action_health_text"])
							love.graphics.print(enemy:getHealthDisplay(), hp_x + 4, 55 + y_off, 0, 1, 0.5)
						end
					end
				end

				if draw_mercy then
					-- Draw the enemy's MERCY
					if enemy.selectable then
						Draw.setColor(PALETTE["battle_mercy_bg"])
					else
						Draw.setColor(127 / 255, 127 / 255, 127 / 255, 1)
					end
					love.graphics.rectangle("fill", 520, 55 + y_off, 81, 16)

					if enemy.disable_mercy then
						Draw.setColor(PALETTE["battle_mercy_text"])
						love.graphics.setLineWidth(2)
						love.graphics.line(520, 56 + y_off, 520 + 81, 56 + y_off + 16 - 1)
						love.graphics.line(520, 56 + y_off + 16 - 1, 520 + 81, 56 + y_off)
					else
						Draw.setColor(1, 1, 0, 1)
						love.graphics.rectangle("fill", 520, 55 + y_off, ((enemy.mercy / 100) * 81), 16)

						if draw_percents and enemy.selectable then
							Draw.setColor(enemy:getMercyColor())
							love.graphics.print(enemy:getMercyDisplay(), 524, 55 + y_off, 0, 1, 0.5)
						end
					end
				end
			end
		end

		Draw.setColor(1, 1, 1, 1)

		local arrow_down = false
		local i = page_offset + 3
		while true do
			i = i + 1
			if i > #enemies then
				break
			elseif enemies[i] then
				arrow_down = true
				break
			end
		end

		local arrow_up = false
		i = page_offset + 1
		while true do
			i = i - 1
			if i < 1 then
				break
			elseif enemies[i] then
				arrow_up = true
				break
			end
		end

		if arrow_down then
			Draw.draw(self.arrow_sprite, 20, 120 + (math.sin(Kristal.getTime() * 6) * 2))
		end
		if arrow_up then
			Draw.draw(self.arrow_sprite, 20, 70 - (math.sin(Kristal.getTime() * 6) * 2), 0, 1, -1)
		end
	else
		super.drawState(self)
	end
end

return BattleUI