local item, super = Class(HealItem, "delicious_cherry")

function item:init()
    super.init(self)

    self.name = "D.Cherry"
    self.use_name = "DELICIOUS CHERRY"

    self.type = "item"

    self.heal_amount = 25

    self.effect = "Heals\n 25HP"
    self.shop = "Giant\ncheery\nheals 25HP"
    self.description = "A cherry as big as an apple. Even when fully ripe, it won\'t fall from the tree. Heals 25 HP."

    self.price = 120
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "Whoa! This cherry is sour!",
        seija = "Tastes pretty good.",
        rin = {
            rin = "Why is it so sour?!",
            seija = "Really?"
        },
        reisen = "Is this some special variety?"
    }
end

return item