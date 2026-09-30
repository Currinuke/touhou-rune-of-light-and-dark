local bat, super = Class(Bullet)

function bat:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/remilia/chainarrow")
    self:setScale(1)

    self.physics.direction = dir
    self.physics.speed = speed
end

function bat:update()
    
    super.update(self)
end

return bat
