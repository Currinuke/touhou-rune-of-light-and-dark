local item, super = Class(Item, "ax010_pendant")

function item:init()
    super.init(self)
    self.name = "Ax010Pendant"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "Defensive\nCute accessories"
    self.description = "Cute decorations. Looks like that the original animals have been forcibly changed into Yuyuko."

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        defense = 2,
        magic = 1
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "It is so cute!",
        seija = "Six braids?",
        rin = "Looks strange.",
        reisen = "Kinda funny."
    }
end

return item
