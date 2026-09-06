local item, super = Class(Item, "weird_bowknot")

function item:init()
    super.init(self)
    self.name = "WeirdBowknot"
    self.use_name = "WEIRDBOWKNOT"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.shop = ""
    self.description = "Infinite shaped bowknot. Greatly increase Attack, Defense, and Magic, and...?"

    self.price = 0
    self.can_sell = false

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 4,
        defense = 4,
        magic = 4
    }
    self.bonus_name = "???/???" -- 将"???/???"属性伤害降低33%
    self.bonus_icon = "ui/menu/icon/armor"

    self.can_equip = {}

    self.reactions = {
        kogasa = "I can be a great umbrella, too!",
        seija = "... Has an elderly scent.",
        rin = "Do I look like her?",
        reisen = "I think I've seen this before..."
    }
end

return item