local Lib = {}

function Lib:init()
	YinYangOrb = libRequire(self.info.id, "scripts.effects.yinyangorb")
end

return Lib