local item, super = Class(Item, "bat_pendant")

function item:init()
    super.init(self)

    self.name = "BatPendant"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "Unknown\nSpell Card"
    self.description = "A spell card of unknown origin that summons protective bats."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 1
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "",
        seija = "Money, that's what I need.",
        rin = "Do they take credit?",
        reisen = "It goes with my watch!"
    }
end

return item
