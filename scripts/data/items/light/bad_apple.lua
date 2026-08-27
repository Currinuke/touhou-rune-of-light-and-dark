local item, super = Class(Item, "light/bad_apple")

function item:init()
    super.init(self)

    self.name = "Bad Apple"

    self.type = "key"
    self.light = true

    self.description = "Not too important, not too unimportant."

    self.check = "Not too important,[wait:5] not\ntoo unimportant."

    self.usable_in = "all"
    self.result_item = nil
end

function item:onWorldUse()
    Assets.playSound("egg")
    Game.world:showText("* You used the Egg.")
    return false
end

function item:onToss()
    Game.world:showText("* What Egg?")
    return true
end

function item:convertToDark(inventory)
    return "bad_apple"
end

return item