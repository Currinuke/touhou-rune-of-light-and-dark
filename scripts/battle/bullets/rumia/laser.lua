local laser, super = Class(Bullet)

function laser:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/rumia/laserbullet")
    self:setScale(0.5)
    self.scale_x=1
    self.destroy_on_hit=false

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function laser:update()
    super.update(self)
end

return laser