local darkeffect, super = Class(Object)

function darkeffect:init(x, y, angle)
	super.init(self, x, y, angle)
	self:setSprite("enemies/rumia/darkness")
	self.alpha = 0
	self:setScale(2,2)
end

function darkeffect:update()
	super.update(self)
end

function darkeffect:draw()
    love.graphics.setColor(1,1,1,self.alpha)
    love.graphics.draw(Assets.getTexture('enemies/rumia/darkness'),0,0,0,1)
end

function darkeffect:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

return darkeffect