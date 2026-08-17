local item, super = Class(HealItem, "book_page")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Book Page"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Amount healed (HealItem variable)
    self.world_heal_amount = 1
    self.battle_heal_amount = 50

    -- Battle description
    self.effect = "Heals\n50HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A page featuring a self-portrait of Koakuma. Heals 1 HP."

    -- Default shop price (sell price is halved)
    self.price = 250
    -- Whether the item can be sold
    self.can_sell = false

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Equip bonuses (for weapons and armor)
    self.bonuses = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        kogasa = "Uhh...",
        seija = "Sure, why not.",
        rin = "(Uncomfortable)",
        reisen = "You really expect me to eat this?"
    }
end

return item