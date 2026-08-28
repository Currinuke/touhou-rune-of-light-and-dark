local item, super = Class(Item, "halloween_sleeve")

function item:init()
    super.init(self)

    -- Display name
    self.name = "HweenSleeve"

    self.type = "weapon"
    self.icon = "ui/menu/icon/sword"

    self.effect = ""
    self.shop = "Spooky\nsleeve"
    self.description = "A mischievous blade. Attacks with this\nweapon are easier to make critical."

    self.price = 1000
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 2
    }
    self.bonus_name = "{bonus_spookiness_down}"
    self.bonus_icon = "ui/menu/icon/down"

    self.can_equip = {
        kogasa = true
    }

    self.reactions = {
        seija = "Too small. Kris-size.",
        rin = "Umm, I might hurt myself...",
        rensei = "That\'s, um, nostalgic."
    }
end

function item:convertToLightEquip(chara)
    return "light/halloween_pencil"
end

return item
