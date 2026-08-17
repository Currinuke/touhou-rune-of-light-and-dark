local item, super = Class(HealItem, "tanghulu")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Tanghulu"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Amount healed (HealItem variable)
    self.heal_amount = 40

    -- Battle description
    self.effect = "Heals\n40HP"
    -- Shop description
    self.shop = "Tasty snack\nfrom Hong\'s\nhomeland\nHeals 40HP"
    -- Menu description
    self.description = "Tasty snack from Hong\'s homeland.\nMade with cherries. Heals 40 HP. "

    -- Default shop price (sell price is halved)
    self.price = 250
    -- Whether the item can be sold
    self.can_sell = true

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
    -- Bonus name and icon (displayed in equip menu)
    self.bonus_name = nil
    self.bonus_icon = nil

    -- Equippable characters (default true for armors, false for weapons)
    self.can_equip = {}

    -- Character reactions (key = party member id)
    self.reactions = {
        kogasa = "Sweet... and sour!",
        seija = {
            seija = "Ah, \"sweet before bitter\"!",
            rin = "Isn\'t it \"bitter before sweet\"?"
        },
        rin = "Is this really tanghulu?",
        reisen = "It looks so familiar..."
    }
end

return item