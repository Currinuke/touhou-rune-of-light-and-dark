local item, super = Class(Item, "spirit_sleeve")

function item:init()
    super.init(self)
    
    self.name = "SpiritSleeve"

    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"

    self.effect = ""
    self.shop = ""
    self.description = "Make your umbrella bounce and scatter all the rainwater and bullets!"

    self.price = 1000
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 2
    }
    self.bonus_name = "{bonus_defense}"
    self.bonus_icon = "ui/menu/icon/fire"

    self.can_equip = {
        kogasa = true
    }

    self.reactions = {
        kogasa = "I, the abandoned UMB's vengeful ghost!",
        seija = "Can't even put it on.",
        rin = "Bounce, bounce, bounce!",
        rensei = "I am not afraid of ghosts."
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item
