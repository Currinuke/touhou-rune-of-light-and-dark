local OverworldActionBox, super = HookSystem.hookScript(OverworldActionBox)

function OverworldActionBox:init(x, y, index, chara)
    if chara.id ~= "seija" then
        super.init(self, x, y, index, chara)
    else
        -- 213 * 26
        local bar_x = 212
        local bar_y = 46

        super.super.init(self, x, y)

        self.index = index
        self.chara = chara

        -- 暂时用34 * 25
        self.head_sprite = Sprite(chara:getHeadIcons() .. "/head", bar_x - 13 - 34, 13)

        if chara:getNameSprite() then
            -- self.name_sprite = Sprite(chara:getNameSprite(), 51, 16)
            self.name_sprite = Sprite(chara:getNameSprite(), 113, 16)
            self:addChild(self.name_sprite)
        end

        -- 16 * 11
        self.hp_sprite = Sprite("ui/hp", bar_x - 109 - 16, bar_y - 24 - 11)

        local ox, oy = chara:getHeadIconOffset()
        self.head_sprite.x = self.head_sprite.x + ox
        self.head_sprite.y = self.head_sprite.y + oy

        self:addChild(self.head_sprite)
        self:addChild(self.hp_sprite)

        self.font = Assets.getFont("smallnumbers")
        self.main_font = Assets.getFont("main")

        self.selected = false

        self.reaction_text = ""
        self.reaction_alpha = 0
    end
end

function OverworldActionBox:draw()
    if self.chara.id ~= "seija" then
        super.draw(self)
    else
        -- 213 * 26
        local bar_x = 212
        local bar_y = 44

        -- Draw the line at the top
        if self.selected then
            Draw.setColor(self.chara:getColor())
        else
            Draw.setColor(PALETTE["action_strip"])
        end

        love.graphics.setLineWidth(2)
        love.graphics.line(0, 1, 213, 1)

        if Game:getConfig("oldUIPositions") then
            love.graphics.line(0, 2, 2, 2)
            love.graphics.line(211, 2, 213, 2)
        end

        -- Draw health
        -- 新数字 = bar_x - 原数字 - 贴图横像素数

        Draw.setColor(PALETTE["action_health_bg"])
        love.graphics.rectangle("fill", bar_x - 128 - 76, bar_y - 24 - 9, 76, 9)

        local health = (self.chara:getHealth() / self.chara:getStat("health")) * 76

        if health > 0 then
            Draw.setColor(self.chara:getColor())
            love.graphics.rectangle("fill", bar_x - 128 - math.ceil(health), bar_y - 24 - 9, math.ceil(health), 9)
        end

        local color = PALETTE["action_health_text"]
        if health <= 0 then
            color = PALETTE["action_health_text_down"]
        elseif (self.chara:getHealth() <= (self.chara:getStat("health") / 4)) then
            color = PALETTE["action_health_text_low"]
        else
            color = PALETTE["action_health_text"]
        end

        local health_offset = 0
        health_offset = (#tostring(self.chara:getHealth()) - 1) * 8

        
        --love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
        -- 212*44
        -- 定下斜线的坐标变化然后套给其它数字(-175, +21)
        -- / -> 14*10
        
        Draw.setColor(color)
        love.graphics.setFont(self.font)
        love.graphics.print(self.chara:getHealth(), 152 - health_offset - 123, bar_y - 11 - 10)
        Draw.setColor(PALETTE["action_health_text"])
        love.graphics.print("/", bar_x - 161 - 14, bar_y - 11 - 10)
        local string_width = self.font:getWidth(tostring(self.chara:getStat("health")))
        Draw.setColor(color)
        love.graphics.print(self.chara:getStat("health"), 205 - string_width - 123, bar_y - 11 - 10)

        -- Draw name text if there's no sprite
        if not self.name_sprite then
            local font = Assets.getFont("name")
            love.graphics.setFont(font)
            Draw.setColor(1, 1, 1, 1)

            local name = self.chara:getName():upper()
            local spacing = 5 - StringUtils.len(name)

            local off = font:getWidth(StringUtils.sub(name, StringUtils.len(name), StringUtils.len(name)))
            for i = StringUtils.len(name), 1, -1 do
                local letter = StringUtils.sub(name, i, i)
                love.graphics.print(letter, bar_x - (51 + off), 16 - 1)
                off = off + font:getWidth(letter) + spacing
            end
        end

        local reaction_x = -1

        if self.x == 0 then -- lazy check for leftmost party member
            reaction_x = 3
        end

        love.graphics.setFont(self.main_font)
        Draw.setColor(1, 1, 1, self.reaction_alpha / 6)
        love.graphics.print(self.reaction_text, reaction_x, 43, 0, 0.5, 0.5)

        super.super.draw(self)
    end
end

return OverworldActionBox