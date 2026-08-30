local item, super = Class(Item, "old_ocular")

function item:init()
    super.init(self)

    self.name = "OldOcular"

    self.type = "weapon"
    self.icon = "ui/menu/icon/ring"

    self.effect = ""
    self.shop = ""
    self.description = "Even in complex environments, it can help you see things clearly."

    self.price = 100
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {
        reisen = true
    }

    self.reactions = {
        kogasa = "Can you see ghosts with this?",
        seija = "Not my style.",
        rin = "Wanna ski?",
        reisen = "(What a relief...)"
    }
end

return item