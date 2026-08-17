local Basic, super = Class(Wave)

function Basic:onStart()
    self.timer:every(0.3, function()
        local rep = 1
        local num = MathUtils.random()

        if num < 0.3 then
            rep = 2
        end

        for i = 1, rep do
            local x = SCREEN_WIDTH + 20
            local y = MathUtils.random(Game.battle.arena.top, Game.battle.arena.bottom)
            local bullet = self:spawnBullet("scarletbat1", x, y, math.rad(180), 8)
            bullet.remove_offscreen = false
        end
    end)
end

function Basic:update()
    super.update(self)
end

return Basic
