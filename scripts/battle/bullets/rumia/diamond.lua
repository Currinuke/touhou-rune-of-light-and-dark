local diamond, super = Class(Bullet)

function diamond:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/diamondbullet")
    self:setScale(1)

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function diamond:update()
    super.update(self)
end

return diamond