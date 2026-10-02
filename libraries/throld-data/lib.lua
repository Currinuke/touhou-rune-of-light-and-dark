local Lib = {}

function Lib:init()
	YinYangOrb = libRequire(self.info.id, "scripts.effects.yinyangorb")
	SeijaVictory = libRequire(self.info.id, "scripts.effects.seijavictory")
end

return Lib