local item, super = Class(HealItem, "prickly_milk")

function item:init()
    super.init(self)

    self.name = "Prickly Milk"
    self.use_name = "PRICKLY MILK"

    self.type = "item"

    self.effect = "Healing\nvaries"
    self.shop = ""
    self.description = "It's own-flavored tea.\nThe flavor just says \"Kris.\""

    self.heal_amount = 180
    self.heal_amounts = {
        ["reisen"] = 100
    }
    self.world_heal_amounts = {
        ["seija"] = 10
    }
    self.battle_heal_amounts = {
        ["seija"] = 40
    }

    self.price = 10
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "",
        seija = {
            seija = "Hell yeah, apple juice!!",
            rin = "Don't drink so fast!!"
        },
        rin = {
            rin = "Tastes like blueberries!",
            seija = "Huh? Really?"
        },
        reisen = "Tastes like cinnamon! (What is this aftertaste...?)"
    }
end

return item