local item, super = Class(HealItem, "special_onigiri")

function item:init()
    super.init(self)

    self.name = "Spec. Onigiri"
    self.use_name = "Special Onigiri"

    self.type = "item"

    self.effect = "Heals\nteam\n120HP"
    self.shop = ""
    self.description = "An onigiri with extra ingredients. Heals 120 HP to the team."

    self.heal_amount = 120

    self.price = 100
    self.can_sell = true

    self.target = "party"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "Smells great!",
        seija = "It\'s alright, I guess.",
        rin = "What\'s inside this?",
        reisen = "Many medicinal ingredients..."
    }
end

return item