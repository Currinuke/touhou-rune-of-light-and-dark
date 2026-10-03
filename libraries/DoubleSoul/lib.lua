local Lib = {}

function Lib:init()
    DoubleSwapEffect = libRequire(self.info.id, "scripts.effects.doubleswapeffect")
end

return Lib