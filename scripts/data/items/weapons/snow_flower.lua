local item, super = Class(Item, "snow_flower")

function item:init()
    super.init(self)

    self.name = "SnowFlower"

    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"

    self.effect = ""
    self.shop = ""
    self.description = "Flowers growing in the snow.\nBalances attack and magic."

    self.price = 200
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 3,
        magic = 3
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {
        rin = true
    }

    self.reactions = {
        kogasa = "What a tough flowers!",
        seija = "Not interested.",
        rin = "I'm balance!",
        reisen = "Medicinal materials?"
    }
end

return item