local item, super = Class(Item, "redflower")

function item:init()
    super.init(self)

    self.name = "Redflower"

    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"

    self.effect = ""
    self.shop = ""
    self.description = "A basic scarf made of lightly\nmagical fiber."

    self.price = 100
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.can_equip = {
        rin = true
    }

    self.reactions = {
        kogasa = "",
        seija = "No. Just... no.",
        rin = "Comfy! Touch it, Kris!",
        reisen = "Huh? No, I'm not cold."
    }
end

return item