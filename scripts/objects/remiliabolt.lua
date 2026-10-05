local remiliabolt, super = Class(Sprite, "RemiliaBolt")

function remiliabolt:init(x, y)
	super.init(self, "bullets/remilia/cutscene_bolt", x, y)
    self:setOrigin(0.5, 1)
    self:setScale(0.25, 0.25)
	self:play(1/15, true)
    self.alpha = 1
    self.layer = 0.7
    self:fadeOutSpeedAndRemove(0.06)
end

return remiliabolt