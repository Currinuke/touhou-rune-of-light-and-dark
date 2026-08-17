local item, super = Class(HealItem, "halfraw_steak")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Halfraw Steak"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Amount healed (HealItem variable)
    self.heal_amount = 70
    self.heal_amounts["rin"] = 10

    -- Battle description
    self.effect = "Bleeding\nsteak"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "A medium-rare steak prepared by the Head Maid\nin her spare time... It\'s still bleeding."

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

    -- Character reactions (key = party member id)
    self.reactions = {
        kogasa = "Is this undercooked?",
        seija = "It\'s meat!",
        rin = "...What kind of meat is this?",
        reisen = "Can\'t handle this... fancy kind."
    }
end

return item