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
        kogasa = "Do I look cute?",
        seija = Game.chapter == 1 and "STOP PUTTING GARBAGE ON MY HEAD!" or "No, I said NO!",
        rin = Game.chapter == 1 and "Double ribbon!" or "Ribbons all over my head!",
        reisen = "It won't bleed onto my hair, right?"
    }

    if Game.chapter >= 5 then
        self.reactions.seija = "Sure, whatever. Happy now?"
    end
end

return item