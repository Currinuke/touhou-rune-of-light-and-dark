local item, super = Class(Item, "hippeastrum")

function item:init()
    super.init(self)

    self.name = "Hippeastrum"

    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"

    self.effect = ""
    self.shop = ""
    self.description = "A rugged scarf that cuts enemies like a dagger."

    self.price = 200
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        magic = 2
    }
    self.bonus_name = "{bonus_poisonousness}"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {
        rin = true
    }

    self.reactions = {
        kogasa = "",
        seija = "Ow! That can't be comfy!",
        rin = "Feels prickly... Nice!",
        reisen = "Ouch! ... kind of nice"
    }
end

return item