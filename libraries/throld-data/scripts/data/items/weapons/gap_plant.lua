local item, super = Class(Item, "gap_plant")

function item:init()
    super.init(self)

    self.name = "GapPlant"

    self.type = "weapon"
    self.icon = "ui/menu/icon/scarf"

    self.effect = ""
    self.shop = ""
    self.description = "Plants that only grow in special spaces, looks like Bamboo.\nNo more therapy is needed."
    
    self.price = 200
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 16,
        magic = -10
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {
        rin = true
    }

    self.reactions = {
        kogasa = "Uh, this is, way too scary ..",
        seija = "That umbrella is enough.",
        rin = "...",
        reisen = "I think I've seen this before..."
    }
end

return item