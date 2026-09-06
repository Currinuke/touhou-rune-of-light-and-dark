local item, super = Class(Item, "old_sleeve")

function item:init()
    super.init(self)

    self.name = "OldSleeve"

    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"

    self.effect = ""
    self.shop = ""
    self.description = "It's old, but it can still protect your umbrella."

    self.price = 60
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"

    self.can_equip = {
        kogasa = true
    }

    self.reactions = {
        kogasa = "My old clothes!",
        seija = "What's this!? A CHOPSTICK?",
        rin = "That's yours, Kris...",
        reisen = "(It has bite marks...)"
    }
end

function item:convertToLightEquip(chara)
    return "light/pencil"
end

return item