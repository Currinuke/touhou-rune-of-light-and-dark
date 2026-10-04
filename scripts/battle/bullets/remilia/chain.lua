local chain, super = Class(Bullet)

function chain:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/remilia/chain")
    self:setScale(1)

    self.tp = self:getGrazeTension() / 2
    self.physics.direction = dir
    self.physics.speed = speed
    self.destroy_on_hit = false
end

function chain:update()
    super.update(self)
end

return chain