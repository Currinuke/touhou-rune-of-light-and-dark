local item, super = Class(Item, "bat_perk_card")

function item:init()
    super.init(self)

    self.name = "Batperkcard"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "Carrying this card can earn a +5% monetary perk."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 2
    }
    self.bonus_name = "$ +5%"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {}

    self.reactions = {
        kogasa = "Bat there's no same perk elsewhere.",
        seija = "Money? The more, the better!",
        rin = "There are no tricks here, right?",
        reisen = "We usually only accept cash..."
    }
end

function item:applyMoneyBonus(gold)
    return gold * 1.05
end

return item
