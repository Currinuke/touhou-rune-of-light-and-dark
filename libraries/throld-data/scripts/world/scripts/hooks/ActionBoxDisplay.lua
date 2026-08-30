local ActionBoxDisplay, super = HookSystem.hookScript(ActionBoxDisplay)

function ActionBoxDisplay:draw()
    if self.actbox.battler.chara.id ~= "seija" then
        super.draw(self) -- 不是正邪就应用原函数
    else
        -- 由于没有重写注释，以下注释都可能是错的
        -- 包括 212 * 44
        -- 212 * 44
        -- love.graphics.line(1  , 2, 1,   36)
        -- love.graphics.line(212, 2, 212, 36)
        
        local bar_x = 212
        local bar_y = 44

        if Game.battle.current_selecting == self.actbox.index then
           Draw.setColor(self.actbox.battler.chara:getColor())
        else
            Draw.setColor(PALETTE["action_strip"], 1)
        end

        love.graphics.setLineWidth(2)
        love.graphics.line(0  , Game:getConfig("oldUIPositions") and 2 or 1, 213, Game:getConfig("oldUIPositions") and 2 or 1)

        love.graphics.setLineWidth(2)
        if Game.battle.current_selecting == self.actbox.index then
            love.graphics.line(1  , 2, 1,   36)
            love.graphics.line(212, 2, 212, 36)
        end

        -- love.graphics.rectangle(mode, x, y, width, height, rx, ry, segments)

        Draw.setColor(PALETTE["action_fill"])
        love.graphics.rectangle("fill", 2, Game:getConfig("oldUIPositions") and 3 or 2, 209, Game:getConfig("oldUIPositions") and 34 or 35)

        Draw.setColor(PALETTE["action_health_bg"])
    
        -- love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, 76, 9) 
        -- 212*36 212 = 128 + 8 + 76 36 = 9 + 5 + 22
        love.graphics.rectangle("fill", 8, 10 - self.actbox.data_offset, 76, 9)

        local health = (self.actbox.battler.chara:getHealth() / self.actbox.battler.chara:getStat("health")) * 76

        if health > 0 then
            Draw.setColor(self.actbox.battler.chara:getColor())
            
            -- love.graphics.rectangle("fill", 128, 22 - self.actbox.data_offset, math.ceil(health), 9)
            -- 同上，但是正邪的血量从左向右扣，所以要额外“反转”
            -- 8 + 76 - math.ceil(health) -> x
            love.graphics.rectangle("fill", 84 - math.ceil(health), 10 - self.actbox.data_offset, math.ceil(health), 9)
        end


        local color = PALETTE["action_health_text"]
        if health <= 0 then
            color = PALETTE["action_health_text_down"]
        elseif (self.actbox.battler.chara:getHealth() <= (self.actbox.battler.chara:getStat("health") / 4)) then
            color = PALETTE["action_health_text_low"]
        else
            color = PALETTE["action_health_text"]
        end


        local health_offset = 0
        health_offset = (#tostring(self.actbox.battler.chara:getHealth()) - 1) * 8

        --love.graphics.print(text, x, y, r, sx, sy, ox, oy, kx, ky)
        -- 212*44
        -- 定下斜线的坐标变化然后套给其它数字(-124, +16)

        Draw.setColor(color)
        love.graphics.setFont(self.font)
        --love.graphics.print(self.actbox.battler.chara:getHealth(), 152 - health_offset, 9 - self.actbox.data_offset)
        love.graphics.print(self.actbox.battler.chara:getHealth(), 28 - health_offset, 22 - self.actbox.data_offset)
        Draw.setColor(PALETTE["action_health_text"])
        --love.graphics.print("/", 161, 9 - self.actbox.data_offset)
        -- / -> 14*10
        -- 212 = 161 + ?(14) + 37
        -- 44 = 9 + ?(10) + 25
        love.graphics.print("/", 37, 22 - self.actbox.data_offset)
        local string_width = self.font:getWidth(tostring(self.actbox.battler.chara:getStat("health")))
        Draw.setColor(color)
        --love.graphics.print(self.actbox.battler.chara:getStat("health"), 205 - string_width, 9 - self.actbox.data_offset)
        love.graphics.print(self.actbox.battler.chara:getStat("health"), 81 - string_width, 22 - self.actbox.data_offset)

        super.super.draw(self)
    end
end

return ActionBoxDisplay