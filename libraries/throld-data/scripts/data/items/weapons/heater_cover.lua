local item, super = Class(Item, "heater_cover")

function item:init()
    super.init(self)
    
    self.name = "HeaterCover"

    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"

    self.effect = ""
    self.shop = "OFFENSIVE\nUsed to melt snow"
    self.description = "Automatically melt the accumulated snow on the umbrella surface. Hum!"

    self.price = 1000
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 4
    }
    self.bonus_name = "{bonus_heating}"
    self.bonus_icon = "ui/menu/icon/fire"

    self.can_equip = {
        kogasa = true
    }

    self.reactions = {
        kogasa = "Let's ignite!",
        seija = "How should I wear this?",
        rin = "Gee, it's hot!",
        rensei = "Uh, I'm not THAT cold."
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item
