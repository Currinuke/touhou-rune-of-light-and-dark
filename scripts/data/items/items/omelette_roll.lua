local item, super = Class(HealItem, "omelette_roll")

function item:init()
    super.init(self)

    self.name = "Omelette Roll"
    self.use_name = "OMELETTE ROLL"

    self.type = "item"

    self.heal_amount = 70
    self.heal_amounts = {
        reisen = 20
    }

    self.effect = "Heals\n70HP"
    self.shop = "Master Hong\'s\nspecialty\nHeals 70HP"
    self.description = "Large omelette wrapped around flatbread,\nwith special sauce..."

    self.price = 400
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "That\'s a huge omelette!",
        seija = "I like this cooking style.",
        rin = "Isn\'t this a bit too spicy...?",
        reisen = "Hot! Water, give me water!"
    }
end

return item