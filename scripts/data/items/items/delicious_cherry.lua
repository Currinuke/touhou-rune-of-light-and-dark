local item, super = Class(HealItem, "delicious_cherry")

function item:init()
    super.init(self)

    self.name = "D. Cherry"
    self.use_name = "Delicious Cherry"

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    self.heal_amount = 25

    -- Battle description
    self.effect = "Heals\n 25HP"
    -- Shop description
    self.shop = "Star-shape\ncandy that\nheals 25HP"
    self.description = "A cherry as big as an apple. Even when fully ripe, it won\'t fall from the tree. Heals 25 HP."

    self.price = 120
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
        kogasa = "Whoa! This cherry is sour!",
        seija = "Tastes pretty good.",
        rin = {
            seija = "Really?",
            rin = "Why is it so sour?!"
        },
        reisen = "Is this some special variety?"
    }
end

return item