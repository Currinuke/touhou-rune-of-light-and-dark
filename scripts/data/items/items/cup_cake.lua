local item, super = Class(HealItem, "cup_cake")

function item:init()
    super.init(self)

    self.name = "Cup Cake"
    self.use_name = "CUP CAKE"

    self.type = "item"

    self.effect = "Heals\nteam\n50HP"
    self.shop = ""
    self.description = "一些手工制作的小蛋糕，可供全队享用。"

    self.heal_amount = 50

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