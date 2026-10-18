local Lib = {}

function Lib:init()
	Game.skip_dialogue = Game.skip_dialogue or {}

	function Game:skipCutscene(value, skip)
		local id = value or Game.world.map.id or ""
		local skipping = Game.skip_dialogue[id]
		Game.skip_dialogue[id] = skip or true
		return skipping
	end
end

return Lib