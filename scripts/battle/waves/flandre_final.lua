local Basic, super = Class(Wave)

function Basic:onArenaEnter()
    self:setArenaSize(SCREEN_WIDTH, SCREEN_HEIGHT)
    self:setArenaPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    -- self:setSoulPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
end

function Basic:onStart()
    self.time = 20

    self.timer:every(0.2, function()
        local rep = 2
        local num = MathUtils.random()

        if num < 0.4 then
            rep = 5
        end

        for i = 1, rep do
            local x = SCREEN_WIDTH + 20
            local y = MathUtils.random(0, SCREEN_HEIGHT)
            local bullet = self:spawnBullet("remilia/scarletbat1", x, y, "left", 8, 5)
            bullet.remove_offscreen = false
        end
    end)
end

function Basic:update()
    super.update(self)
end

return Basic
