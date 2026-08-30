local item, super = Class(Item, "s_shaped_stick")

function item:init()
    super.init(self)

    self.name = "S-ShapedStick"

    self.type = "weapon"
    self.icon = "ui/menu/icon/axe"

    self.effect = ""
    self.shop = ""
    self.description = "Skull-emblazoned scythe-ax.\nReduces Rule Burster's cost by 10"

    self.price = 0
    self.can_sell = false

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 7,
        magic = 1
    }
    self.bonus_name = "{bonus_burster_damage_up}"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {
        seija = true
    }

    self.reactions = {
        kogasa = "",
        seija = "Let the games begin!",
        rin = "It's too, um, evil.",
        reisen = "...? It smiled at me?"
    }
end

return item