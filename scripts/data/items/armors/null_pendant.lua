local item, super = Class(Item, "null_pendant")

function item:init()
    super.init(self)
    self.name = "NullPendant"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "U-CARY\n0FF1C1AL\nMERCHAND15E"
    self.description = "The originally decorated part has fallen off. It seems to have lost much of its stats."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 2, 
        defense = 1, -- 99
        magic = 1
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "Doesn't seem as good as she said...",
        seija = "Gross! I'm NOT wearing this!",
        rin = "Looks even stranger.",
        reisen = "Kinda off."
    }
end

return item
