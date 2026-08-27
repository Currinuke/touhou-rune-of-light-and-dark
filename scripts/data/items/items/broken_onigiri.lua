local item, super = Class(Item, "broken_onigiri")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Broken Onigiri"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "key"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Not\ntasty"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Lacking the Moonlight Grass makes it rather ordinary. A workbench might be able to fix it."

    -- Amount healed (HealItem variable)
    self.heal_amount = 20

    -- Default shop price (sell price is halved)
    self.price = 6
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
    self.reactions = {}
end

function item:onMenuOpen(menu)
    if menu and Game.inventory:getItemIndex(self) == "key_items" then
        self.target = "none"
        self.usable_in = "none"
    end
end

return item