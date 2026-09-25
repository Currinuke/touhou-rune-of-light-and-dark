local bat, super = Class(Bullet)

function bat:init(x, y, dir, speed)
    super.init(self, x, y, "bullets/remilia/star")
    self:setScale(0.75)
    self.collider=CircleCollider(self,self.width/2+7,self.height/2+8,self.height/2-6)

    self.physics.direction = dir
    self.physics.speed = speed
end

function bat:update()
    
    super.update(self)
end

return bat
