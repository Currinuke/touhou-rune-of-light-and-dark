local item, super = Class(HealItem, "3x_ice_cream")

function item:init()
    super.init(self)

    -- Display name
    self.name = "3x Ice-cream"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heals\nteam\n99HP"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Ice cream with three scoops and three cones! Heals 99 HP to the team."

    -- Amount healed (HealItem variable)
    self.heal_amount = 99

    -- Default shop price (sell price is halved)
    self.price = 90
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

    self.reactions = {
        kogasa = "One for each of us, perfect!",
        seija = "Why not split it sideways?",
        rin = "So cold!",
        reisen = "Here\'s my extra share, Kogasa."
    }
end

function item:onWorldUse(target)
    local consumed = super.onWorldUse(self, target)

    if Game:hasPartyMember("reisen") then
        self.reactions.kogasa = "Thanks!"
    elseif #Game.party >= 3 then
        self.reactions.kogasa = "One for each of us, perfect!"
    else
        self.reactions.kogasa = "I\'m full! Full of joy!"
    end

    return consumed
end

return item