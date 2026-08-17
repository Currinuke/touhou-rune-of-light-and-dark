local Remilia, super = Class(Wave)

function Remilia:onStart()
    self.time = 12

    local times = 30
    self.timer:every(0.3, function()
        if times > 0 then
            local rep = 1
            local num = MathUtils.random()
            times = times - 1

            if num < 0.3 then -- 这种判定是不是太丢人了
                rep = rep + 1
            end

            for i = 1, rep do
                local x = SCREEN_WIDTH + 20
                local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
                local bullet = self:spawnBullet("remilia/scarletbat1", x, y, "left", 8, 5)
                bullet.remove_offscreen = false
            end
        end
    end)
end

function Remilia:update()
    super.update(self)
end

return Remilia