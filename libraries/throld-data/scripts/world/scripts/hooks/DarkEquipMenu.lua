local DarkEquipMenu, super = HookSystem.hookScript(DarkEquipMenu)

function DarkEquipMenu:drawChar()
	local party = self.party:getSelected()
	Draw.setColor(1, 1, 1, 1)
	love.graphics.printf(party:getName(), -235, -5, 640, "center")
end

return DarkEquipMenu