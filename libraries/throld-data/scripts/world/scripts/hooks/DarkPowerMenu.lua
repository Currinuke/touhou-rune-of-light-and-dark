local DarkPowerMenu, super = HookSystem.hookScript(DarkPowerMenu)

function DarkPowerMenu:drawChar()
	local party = self.party:getSelected()
	Draw.setColor(PALETTE["world_text"])
	love.graphics.printf(party:getName(), -235, -7, 640, "center")
	love.graphics.print(party:getTitle(), 238, -7)
end

return DarkPowerMenu