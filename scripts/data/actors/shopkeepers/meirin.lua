local actor, super = Class(Actor, "shopkeepers/meirin")

function actor:init()
	super.init(self)

	self.name = "Meiling"

	self.width = 98
	self.height = 112

	self.path = "shopkeepers/meirin"
	self.default = "idle"

	self.animations = {
		["idle"] = {"idle", function(sprite, wait)
			while true do
				sprite:setFrame(1)
				wait(MathUtils.random(2.6, 4.4))
				sprite:setFrame(2)
				wait(0.1)
				sprite:setFrame(3)
				wait(0.1)
				sprite:setFrame(4)
				wait(0.1)
				sprite:setFrame(3)
				wait(0.1)
				sprite:setFrame(2)
				wait(0.1)
			end
		end},
		["show"] = {"show", function(sprite, wait)
			while true do
				sprite:setFrame(1)
				wait(MathUtils.random(2.6, 4.4))
				sprite:setFrame(2)
				wait(0.1)
				sprite:setFrame(3)
				wait(0.1)
				sprite:setFrame(4)
				wait(0.1)
				sprite:setFrame(3)
				wait(0.1)
				sprite:setFrame(2)
				wait(0.1)
			end
		end}
	}

	self.talk_sprites = {
		["talk"] = 0.125,
		["show_talk"] = 0.125
	}

	self.offsets = {
		["idle"] = {0, 0},
		["show"] = {0, 0},

		["talk"] = {0, 0},
        ["show_talk"] = {0, 0}
	}
end

function actor:onTalkStart(text, sprite)
	if sprite.sprite == "idle" then
		sprite:setSprite("talk")
	elseif sprite.sprite == "show" then
		sprite:setSprite("show_talk")
	end
end

function actor:onTalkEnd(text, sprite)
	if sprite.sprite == "talk" then
		sprite:setAnimation("idle")
	elseif sprite.sprite == "show_talk" then
		sprite:setSprite("show")
	end
end

return actor