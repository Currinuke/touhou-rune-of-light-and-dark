local WobbleBullet, super = Class(Bullet)

function WobbleBullet:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/wobblebullet")

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function WobbleBullet:update()
    super.update(self)
end

return WobbleBullet