local item, super = Class(HealItem, "tanghulu")

function item:init()
    super.init(self)

    self.name = "Tanghulu"
    self.use_name = self.name

    self.type = "item"
    self.icon = nil

    self.heal_amount = 40

    self.effect = "Heals\n40HP"
    self.shop = "Tasty snack\nfrom Hong\'s\nhomeland\nHeals 40HP"
    self.description = "Tasty snack from Hong\'s homeland.\nMade with cherries. Heals 40 HP. "

    self.price = 250
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "Sweet... and sour!",
        seija = {
            seija = "Ah, \"sweet before bitter\"!",
            rin = "Isn\'t it \"bitter before sweet\"?"
        },
        rin = "Is this really tanghulu?",
        reisen = "It looks so familiar..."
    }
end

return item