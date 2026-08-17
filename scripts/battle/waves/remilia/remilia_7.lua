local Remilia, super = Class(Wave)

function Remilia:onStart()
    self.time = 13

    local times = 24
    self.timer:every(0.4, function()
        if times > 0 then
            times = times - 1

            local x1 = SCREEN_WIDTH + 20
            local y1 = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
            local bullet1 = self:spawnBullet("remilia/scarletbat1", x1, y1, "left", 8, 5)
            bullet1.remove_offscreen = false

            local x2 = -20
            local y2 = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
            local bullet2 = self:spawnBullet("remilia/scarletbat1", x2, y2, "right", 8, 5)
            bullet2.remove_offscreen = false
        end
    end)
end

function Remilia:update()
    super.update(self)
end

return Remilia