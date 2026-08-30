local item, super = Class(Item, "rusty_wrist")

function item:init()
    super.init(self)

    self.name = "R. Wrist"

    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"

    self.effect = ""
    self.shop = ""
    self.description = "Beginner's ax forged from the\nmane of a dragon whelp."

    self.price = 80
    self.can_sell = true
    
    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.can_equip = {}

    self.reactions = {
        kogasa = "",
        seija = "I'm too GOOD for that.",
        rin = "Ummm... it's a bit big.",
        reisen = "It... smells nice..."
    }
end

return item