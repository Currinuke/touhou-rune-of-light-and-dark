local AxeBullet, super = Class(Bullet)
function AxeBullet:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/rumia/axebullet")
    self.physics.direction = dir
    self.physics.speed = speed
end

function AxeBullet:update()

    super.update(self)
end

return AxeBullet
