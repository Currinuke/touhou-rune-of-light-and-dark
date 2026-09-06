local item, super = Class(Item, "purified_ocular")

function item:init()
    super.init(self)

    self.name = "PurifiedOc"

    self.type = "weapon"
    self.icon = "ui/menu/icon/ring"

    self.effect = ""
    self.shop = ""
    self.description = "A Ocular with a fox mark on it."

    self.price = 100
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 4,
        magic = 4
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {
        reisen = true
    }

    self.reactions = {
        kogasa = "...",
        seija = "Did you get scammed?",
        rin = "Hum, is this...?",
        reisen = "..."
    }
end

return item