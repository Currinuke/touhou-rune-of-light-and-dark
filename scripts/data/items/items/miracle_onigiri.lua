local item, super = Class(HealItem, "miracle_onigiri")

function item:init()
    super.init(self)

    -- Display name
    self.name = "MiracOnigiri"
    -- Name displayed when used in battle (optional)
    self.use_name = "Miracle Onigiri"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nteam\n240HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Born from a legendary chef and master blacksmith. Heals 240 HP to the team."

    -- Amount healed (HealItem variable)
    self.heal_amount = 240

    -- Default shop price (sell price is halved)
    self.price = 150
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "party"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions (key = party member id)
    self.reactions = {
        kogasa = "So... so good!",
        seija = "Isn\'t it just a regular onigiri?",
        rin = "Such a unique flavor!",
        reisen = "Such a comforting taste..."
    }
end

return item