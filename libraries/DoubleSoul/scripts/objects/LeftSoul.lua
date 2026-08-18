local LeftSoul, super = Class(Soul)

function LeftSoul:init(x, y, color)
    super.init(self, x, y, color)
    self.color = {0, 1, 1}

    self.sprite:setSprite("player/heart_dodge_left")
    self.sprite.inherit_color = false

    self.can_move = false

    self.mask_sprite = Sprite("player/heart_dodge_right")
    self.mask_sprite.inherit_color = false
    self:addChild(self.mask_sprite)

    self.sync_inv = Kristal.getLibConfig("throld-doublesoul", "sameInv") or true
    self.can_damage = "left"
end

function LeftSoul:onDamage(bullet, amount)
    super.onDamage(self, bullet, amount)
    if self.sync_inv then
        Game.battle.soul.double_right.inv_timer = self.inv_timer
    end
end

function Soul:update()
    if self.transitioning then
        if self.timer >= 7 then
            Input.clear("cancel")
            self.timer = 0
            if self.transition_destroy then
                Game.battle:addChild(HeartBurst(self.target_x, self.target_y, { Game:getSoulColor() }))
                self:remove()
            else
                self.transitioning = false
                self:setExactPosition(self.target_x, self.target_y)
            end
        else
            self:setExactPosition(
                MathUtils.lerp(self.original_x, self.target_x, MathUtils.clamp(self.timer / 7, 0, 1)),
                MathUtils.lerp(self.original_y, self.target_y, MathUtils.clamp(self.timer / 7, 0, 1))
            )
            self.alpha = MathUtils.lerp(0, self.target_alpha or 1, MathUtils.clamp(self.timer / 3, 0, 1))
            self.sprite:setColor(self.color[1], self.color[2], self.color[3], self.alpha)
            self.timer = self.timer + (1 * DTMULT)
        end
        return
    end

    -- Input movement
    if self.can_move then
        self:doMovement()
    end

    -- Bullet collision !!! Yay
    if self.inv_timer > 0 then
        self.inv_timer = MathUtils.approach(self.inv_timer, 0, DT)
    end

    local collided_bullets = {}
    Object.startCache()
    for _, bullet in ipairs(Game.stage:getObjects(Bullet)) do
        if bullet:collidesWith(self.collider) then
            -- Store collided bullets to a table before calling onCollide
            -- to avoid issues with cacheing inside onCollide
            table.insert(collided_bullets, bullet)
        end
        if self.inv_timer == 0 then
            if bullet:canGraze(self) and bullet:collidesWith(self.graze_collider) then
                local old_graze = bullet.grazed_left
                if bullet.grazed_left then
                    Game:giveTension(bullet:getGrazeTension() * DT * self.graze_tp_factor)
                    if Game.battle.wave_timer < Game.battle.wave_length - (1 / 3) then
                        Game.battle.wave_timer = Game.battle.wave_timer + (bullet.time_bonus * (DT / 30) * self.graze_time_factor)
                    end
                    if self.graze_sprite.timer < 0.1 then
                        self.graze_sprite.timer = 0.1
                    end
                    bullet:onGraze(false)
                else
                    Assets.playSound("graze")
                    Game:giveTension(bullet:getGrazeTension() * self.graze_tp_factor)
                    if Game.battle.wave_timer < Game.battle.wave_length - (1 / 3) then
                        Game.battle.wave_timer = Game.battle.wave_timer + ((bullet.time_bonus / 30) * self.graze_time_factor)
                    end
                    self.graze_sprite.timer = 1 / 3
                    bullet.grazed_left = true
                    bullet:onGraze(true)
                end
                self:onGraze(bullet, old_graze)
            end
        end
    end
    Object.endCache()
    for _, bullet in ipairs(collided_bullets) do
        self:onCollide(bullet)
    end

    if self.inv_timer > 0 then
        self.inv_flash_timer = self.inv_flash_timer + DT
        local amt = math.floor(self.inv_flash_timer / (4 / 30))
        if (amt % 2) == 1 then
            self.sprite:setColor(0.5, 0.5, 0.5)
        else
            self.sprite:setColor(1, 1, 1)
        end
    else
        self.inv_flash_timer = 0
        self.sprite:setColor(1, 1, 1)
    end

    super.super.update(self)
end

function LeftSoul:onSwap(swapped)
    self.mask_sprite:setColor(1, 1, 1, 0)
    
    if swapped then
        self.color = {1, 0, 0}
        self.sprite:setSprite("player/heart_dodge_right")
        self.mask_sprite:setSprite("player/heart_dodge_left")
        self.can_damage = "right"
    else
        self.color = {0, 1, 1}
        self.sprite:setSprite("player/heart_dodge_left")
        self.mask_sprite:setSprite("player/heart_dodge_right")
        self.can_damage = "left"
    end
end

return LeftSoul