local item, super = Class(Item, "moon_pin")

function item:init()
    super.init(self)
    self.name = "MoonPin"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "An abnormally cold, moon shaped brooch.\nBe careful of its sharp part."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 4,
        graze_tp = 0.15
    }
    self.bonus_name = "{bonus_tp_gain_plus}"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {}

    self.reactions = {
        kogasa = "So elegant!",
        seija = "The moon, hum?",
        rin = "You should return it to her...",
        reisen = "(Th-this was mine...)"
    }
end

return item
