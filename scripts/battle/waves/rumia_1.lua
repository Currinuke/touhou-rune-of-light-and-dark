local Rumia, super = Class(Wave)

function Rumia:onStart()
    local _times = 3
    -- self.time = 7
    self.timer:every(0.5, function()
        -- Get all enemies that selected this wave as their attack
        local attackers = self:getAttackers()

        -- Loop through all attackers
        for _, attacker in ipairs(attackers) do
            _times = _times - 1
            if _times < 0 then return end
            local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)
            local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)
            for rate_x = -10, -8, 2 do
                for rate_y = -1, 1 do
                    self:spawnBullet("rumia/wobblebullet", x, y, rate_x, rate_x * math.tan(angle) + (rate_x / 2+ 2) * rate_y)
                end
            end
        end
    end)
    
    self.timer:every(0.5, function()
        local attackers = self:getAttackers()
        for _, attacker in ipairs(attackers) do
            if _times > -2 or _times < -3 then return end
            -- Get the attacker's center position
            local x, y = attacker:getRelativePos(attacker.width / 2, attacker.height / 2)

            -- Get the angle between the bullet position and the soul's position
            local angle = MathUtils.angle(x, y, Game.battle.soul.x, Game.battle.soul.y)

            self:spawnBullet("axebullet", x, y, angle + math.rad(15), 10)
            self:spawnBullet("axebullet", x, y, angle + math.rad(15), 12)

            self:spawnBullet("axebullet", x, y, angle, 10)
            self:spawnBullet("axebullet", x, y, angle, 12)

            self:spawnBullet("axebullet", x, y, angle - math.rad(15), 10)
            self:spawnBullet("axebullet", x, y, angle - math.rad(15), 12)

        end
    end)
end

function Rumia:update()
    super.update(self)
end

return Rumia
