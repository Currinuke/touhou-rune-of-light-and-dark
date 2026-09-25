local rumiaaxe, super = Class(Object)

function rumiaaxe:init(x, y, angle)
	super.init(self, x, y, angle)
	self:setSprite("enemies/rumia/axe")
	self.layer = 0.5
	self.alpha = 0
	self:setScale(2,2)
end

function rumiaaxe:update()
	super.update(self)
	
end

function rumiaaxe:setSprite(sprite)
    if self.sprite then
        self.sprite:remove()
    end
    self.sprite = Sprite(sprite, 0, 0)
    self:addChild(self.sprite)
    self:setSize(self.sprite:getSize())
end

return rumiaaxe