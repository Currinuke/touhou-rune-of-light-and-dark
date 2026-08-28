local item, super = Class(Item, "ag_bracelet")

function item:init()
    super.init(self)

    self.name = "AgBracelet"

    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"

    self.effect = ""
    self.shop = "Heroic &\nCool"
    self.description = "A glossy ax from a block warrior.\nSuitable for heroes."

    self.price = 150
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 2
    }

    self.bonus_name = "Weight Up"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {
        seija = true
    }

    -- Character reactions
    self.reactions = {
        susie = "Well, if I have to.",
        ralsei = "It's a bit too heavy...",
        noelle = "(W-wow, what presence...)"
    }
end

return item