local SmallBullet, super = Class(Bullet)

function SmallBullet:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/smallbullet")

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function SmallBullet:update()
    super.update(self)
end

return SmallBullet
