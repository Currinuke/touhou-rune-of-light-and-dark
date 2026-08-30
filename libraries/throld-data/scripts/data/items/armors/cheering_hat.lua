local item, super = Class(Item, "cheering_hat")

function item:init()
    super.init(self)

    self.name = "CheeringHat"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "Defensive\nThank you for\nyour support"
    self.description = "A hat with the words \"I <3 Prismriver\" written on it."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 2
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "Strongly supported.",
        seija = "Not their fans, but...",
        rin = "Ain't it nice?",
        reisen = "My ears..."
    }
end

return item
