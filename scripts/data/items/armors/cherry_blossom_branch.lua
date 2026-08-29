local item, super = Class(Item, "cherry_blossom_branch")

function item:init()
    super.init(self)

    self.name = "CB.Branch"

    self.type = "armor"
    self.icon = "ui/menu/icon/armor"

    self.effect = ""
    self.shop = "Defensive\nBe careful\nwhen carrying it"
    self.description = "A branch of Saigyou Ayakashi. Don\'t treat it like an ordinary cherry blossom tree branch!"

    self.price = 800
    self.can_sell = true

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 3,
        defense = 4,
        magic = 1
    }
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "Feeling strange...",
        seija = "It won't attract butterflies, will it?",
        rin = "It's just a stick.",
        reisen = "Saigyouji gave this to me."
    }
end

return item
