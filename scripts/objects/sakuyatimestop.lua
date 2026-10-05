local SakuyaTimeStop, super = Class(Event, "SakuyaTimeStop")

function SakuyaTimeStop:init(x, y, shape)
    super.init(self, x, y, shape)
end

function SakuyaTimeStop:onInteract(player, dir)
    Assets.playSound("squeak")
    return true
end

return SakuyaTimeStop