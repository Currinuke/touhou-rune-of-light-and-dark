local item, super = Class(TensionItem, "b_box")

function item:init()
    super.init(self)

    -- Display name
    self.name = "B.Box"
    -- Name displayed when used in battle (optional)
    self.use_name = "Blast Box"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Raises\nTP\n35%"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Green box explodes when opened. Boosts battle tension. Raises TP by 35% in battle."

    -- Amount of TP this item gives (TensionItem variable)
    self.tp_amount = 35

    -- Default shop price (sell price is halved)
    self.price = 100
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = true

    -- Character reactions
    self.reactions = {}
end

return item