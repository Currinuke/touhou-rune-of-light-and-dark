local item, super = Class(HealItem, "omelette_roll")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Omelette Roll"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Amount healed (HealItem variable)
    self.heal_amount = 70
    -- Amount healed for anyone other than Kris
    self.heal_amount_reisen = 20

    -- Battle description
    self.effect = "Heals\n70HP"
    -- Shop description
    self.shop = "Master Hong\'s\nspecialty\nHeals 70HP"
    -- Menu description
    self.description = "Large omelette wrapped around flatbread,\nwith special sauce. Heals 70 HP. "

    -- Default shop price (sell price is halved)
    self.price = 400
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
        kogasa = "That\'s a huge omelette!",
        seija = "I like this cooking style.",
        rin = "Isn\'t this a bit too spicy...?",
        reisen = "Hot! Water, give me water!"
    }
end

function item:getHealAmount(id)
    if id == "reisen" then
        return self.heal_amount_reisen
    else
        return self.heal_amount
    end
end

return item