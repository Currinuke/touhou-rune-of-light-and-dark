local diamondform, super = Class(Bullet)

function diamondform:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/diamondbullet_form")
    self:setScale(1)

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function diamondform:update()
    super.update(self)
end

return diamondform