local item, super = Class(HealItem, "lotusly_milk")

function item:init()
    super.init(self)

    self.name = "Lotusly Milk"
    self.use_name = "LOTUSLY MILK"

    self.type = "item"

    self.effect = "Healing\nvaries"
    self.shop = ""
    self.description = "It's own-flavored tea.\nThe flavor just says \"Kris.\""

    self.heal_amounts = {
        ["kogasa"] = 140,
        ["seija"] = 180,
        ["reisen"] = 0
    }
    self.world_heal_amounts = {
        ["rin"] = 10
    }
    self.battle_heal_amounts = {
        ["rin"] = 40
    }

    self.price = 10
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = {
            kogasa = "",
            seija = "Hell yeah, apple juice!!",
            rin = "Don't drink so fast!!"
        },
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