local item, super = Class(Item, "saf_red_rose")

function item:init()
    super.init(self)

    self.name = "SafRedRose"

    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"

    self.effect = ""
    self.shop = ""
    self.description = "Flower that sharp spikes.\nLet your enemies' heart be filled with thorns."

    self.price = 200
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 5,
        magic = -1
    }
    self.bonus_name = "{bonus_prickly}"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {
        rin = true
    }

    self.reactions = {
        kogasa = "Ouch!",
        seija = "Stop pricking holes in my clothes!",
        rin = "Filled with thorns? Too hurtful!",
        reisen = "This is a prank, isn't it?"
    }
end

return item