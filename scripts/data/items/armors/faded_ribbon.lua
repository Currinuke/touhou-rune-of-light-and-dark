local item, super = Class(Item, "faded_ribbon")

function item:init()
    super.init(self)

    self.name = "FadedRibbon"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "Defensive\ncharm"
    self.description = "A thin square charm that sticks\nto you, increasing defense."

    self.price = 100
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 2
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "",
        seija = "... better than nothing.",
        rin = "It's sticky, huh, Kris...",
        reisen = "It's like a name-tag!",
    }
end

return item