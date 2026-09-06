local item, super = Class(HealItem, "flower_filled_sandwich_biscuit")

function item:init()
    super.init(self)

    self.name = "F.F.S. Biscuit"
    self.use_name = "FLOWER-FILLED SANDWICH BISCUIT"

    self.type = "item"

    self.effect = "Healing\nvaries"
    self.shop = ""
    self.description = "A biscuit packed with plenty of dried and fresh flowers."

    self.heal_amount = 50
    self.world_heal_amounts = {
        ["kogasa"] = 20,
        ["seija"] = 130,
        ["rin"] = 15
    }
    self.battle_heal_amounts = {
        ["kogasa"] = 30,
        ["seija"] = 100,
        ["rin"] = 40
    }

    self.price = 450
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "Not very tasty.",
        seija = "Just like my usual lunch.",
        rin = "Are there flowers inside...?",
        reisen = "Is this really not a prank?"
    }
end

return item
