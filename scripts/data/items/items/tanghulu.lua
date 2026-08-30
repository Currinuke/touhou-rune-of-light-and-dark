local item, super = Class(HealItem, "tanghulu")

function item:init()
    super.init(self)

    self.name = "Tanghulu"
    self.use_name = "TANGHULU"

    self.type = "item"

    self.heal_amount = 40

    self.effect = "Heals\n40HP"
    self.shop = "Tasty snack\nfrom Hong\'s\nhomeland\nHeals 40HP"
    self.description = "Tasty snack from Hong\'s homeland.\nMade with cherries. Heals 40 HP. "

    self.price = 250
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

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