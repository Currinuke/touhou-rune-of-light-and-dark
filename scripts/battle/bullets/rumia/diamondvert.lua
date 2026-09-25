local diamondvert, super = Class(Bullet)

function diamondvert:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/diamondbullet_vert")
    self:setScale(1)

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function diamondvert:update()
    super.update(self)
end

return diamondvert