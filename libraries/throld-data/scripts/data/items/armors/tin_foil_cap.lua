local item, super = Class(Item, "tin_foil_cap")

function item:init()
    super.init(self)
    self.name = "TinFoilCap"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "Protect your thoughts from erosion! \nNote: It only has a preventive effect."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 1
    }
    self.bonus_name = "???/???" --将"???/???"属性伤害降低33%
    self.bonus_icon = "ui/menu/icon/armor"

    self.can_equip = {}

    self.reactions = {
        kogasa = "Aliens are coming!",
        seija = "Stupid.",
        rin = "C'mon, Kogasa!",
        reisen = "You're just teasing me, right?"
    }
end

return item
