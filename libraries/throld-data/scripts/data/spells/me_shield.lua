local spell, super = Class(Spell, "me_shield")

function spell:init()
	super.init(self)

	self.name = "Me Shield"
	self.cast_name = self.name

	self.effect = "Take hit\nfor party"
	self.description = ""

	self.cost = 8
	self.target = "party"
	self.tags = {}
end

function spell:getCastMessage(user, target)
	return Game:loc("spell_" .. self.id .. "_castMessage", {
		userName = user.chara:getName(),
		castName = self:getCastName()
	})
end

function spell:onCast(user, target)
	Game.battle.encounter:setFlag("meshield_used", true)
end

return spell