local BigRound, super = Class(Bullet)

function BigRound:init(x, y, speed_x, speed_y)
    super.init(self, x, y, "bullets/remilia/biground")
    self.collider = CircleCollider(self, self.width / 2, self.height / 2, self.height / 5)
    self.layer = BATTLE_LAYERS['above_bullets']

    self.physics.speed_x = speed_x
    self.physics.speed_y = speed_y
end

function BigRound:update()
    super.update(self)
end

return BigRound