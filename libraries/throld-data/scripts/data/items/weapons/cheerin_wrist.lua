local item, super = Class(Item, "cheerin_wrist")

function item:init()
    super.init(self)

    self.name = "CheerinWrist"

    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"

    self.effect = ""
    self.shop = "OFFENSIVE\nUsed to heat up\nthe atmosphere"
    self.description = "Make sure to replace the battery for it."

    self.price = 150
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 4
    }
    self.bonus_name = "{bonus_cheering}"
    self.bonus_icon = nil

    self.can_equip = {
        seija = true
    }

    self.reactions = {
        kogasa = "Yeah!!!",
        seija = "I cheer for myself!",
        rin = "(My throat is hoarse from shouting...)",
        reisen = "Uh, cheer for opponent?"
    }
end

return item