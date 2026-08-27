local item, super = Class(HealItem, "flower_filled_sandwich_biscuit")

function item:init()
    super.init(self)

    self.name = "F.F.S. Biscuit"
    self.use_name = "Flower-Filled Sandwich Biscuit"

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A biscuit packed with plenty of dried and fresh flowers."

    -- Amount healed (HealItem variable)
    self.heal_amount = 20

    self.world_heal_amounts = {
        ["kogasa"] = 20,
        ["seija"] = 130,
        ["rin"] = 15,
        ["reisen"] = 50
    }
    self.battle_heal_amounts = {
        ["kogasa"] = 30,
        ["seija"] = 100,
        ["rin"] = 40,
        ["reisen"] = 50
    }

    -- Default shop price (sell price is halved)
    self.price = 450
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none/nil)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        kogasa = "Not very tasty.",
        seija = "Just like my usual lunch.",
        rin = "Are there flowers inside...?",
        reisen = "Is this really not a prank?"
    }
end

return item
