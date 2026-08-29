local item, super = Class(Item, "pop_chain")

function item:init()
    super.init(self)
    self.name = "PopChain"
    self.use_name = "POPCHAIN"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "Armor that enhances defense through popularity. Vote for Yuyuko in toho-vote or it'll lose its defensive rating."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 3
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "Vote for Kogasa, too!",
        seija = "Don't vote for her anyway.",
        rin = "Hum.",
        reisen = "Isn't this breaking the rules?"
    }
end

return item
