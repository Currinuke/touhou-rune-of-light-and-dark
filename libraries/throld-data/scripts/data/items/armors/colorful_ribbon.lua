local item, super = Class(Item, "colorful_ribbon")

function item:init()
    super.init(self)
    self.name = "ColorfulRBN"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = ""
    self.description = "A ribbon with exceptionally bright colors.\nGain 10% more tension from grazing bullets."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 1,
        graze_tp = 0.1
    }
    self.bonus_name = "{bonus_tp_gain}"
    self.bonus_icon = "ui/menu/icon/up"

    self.can_equip = {}

    self.reactions = {
        kogasa = "Do I look cute?",
        seija = Game.chapter == 1 and "STOP PUTTING GARBAGE ON MY HEAD!" or "No, I said NO!",
        rin = Game.chapter == 1 and "Double ribbon!" or "Ribbons all over my head!",
        reisen = "It won't bleed onto my hair, right?"
    }

    if Game.chapter >= 5 then
        self.reactions.seija = "Fine. On my arm."
    end
end

return item
