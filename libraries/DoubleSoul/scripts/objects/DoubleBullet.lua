local DoubleBullet, super = Class(Bullet)

---@param x         number
---@param y         number
---@param texture?  string|love.Image
---@param no_damage? "left"|"right"|"none" if the bullet cannot damage the left soul, right soul, or none. Defaults to "none".
function DoubleBullet:init(x, y, texture, no_damage)
    super.init(self, x, y, texture)

    self.no_damage = no_damage or "none"
    
    if self.no_damage == "none" then
        self.color = {1, 1, 1}
    elseif self.no_damage == "left" then
        self.color = {0, 1, 1}
    elseif self.no_damage == "right" then
        self.color = {1, 0, 0}
    end

    self.grazed_left = false
    self.grazed_right = false
end

---@param soul Soul yep, the soul
function DoubleBullet:canGraze(soul)
    if not soul then
        soul = Game.battle.soul
    end
    
    return self.can_graze and (self.no_damage == "none" or self.no_damage ~= soul.can_damage)
end

---@return string
function DoubleBullet:getTarget()
    return self.attacker and self.attacker.current_target or "ANY"
end

---@return number
function DoubleBullet:getDamage()
    return self.damage or (self.attacker and self.attacker.attack * 5) or 0
end

function DoubleBullet:onCollide(soul)
    if self.no_damage == "none" or self.no_damage ~= soul.can_damage then
        super.onCollide(self, soul)
    end
end

---@param wave Wave
function DoubleBullet:onWaveSpawn(wave) end

---@param texture?      string|love.Image   The new texture or path to the texture to set on the sprite (Removes the bullet's sprite if undefined)
---@param speed?        number              The time between frames of the sprite, in seconds (Defaults to 1/30th second)
---@param loop?         boolean             Whether the sprite should continuously loop. (Defaults to `true`)
---@param on_finished?  fun(Sprite)         A function that is called when the animation finishes.
---@return Sprite?
function DoubleBullet:setSprite(texture, speed, loop, on_finished)
    if self.sprite then
        self:removeChild(self.sprite)
    end
    if texture then
        self.sprite = Sprite(texture)
        self.sprite.inherit_color = true
        self:addChild(self.sprite)

        if speed then
            self.sprite:play(speed, loop, on_finished)
        end

        self.width = self.sprite.width
        self.height = self.sprite.height

        return self.sprite
    end
end

--- Checks whether this bullet is an instance or extension of a specific bullet type, specified by `id`.
---@param id string
---@return boolean
function DoubleBullet:isBullet(id)
    return self:includes(Registry.getBullet(id))
end

--- *(Override)* Called when the soul grazes a bullet.
---@param first     boolean     Whether the bullet has been grazed before or not.
function DoubleBullet:onGraze(first) end

return DoubleBullet
