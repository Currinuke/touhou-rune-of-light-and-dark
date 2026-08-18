local item, super = Class(HealItem, "ghosty_candy")

function item:init()
    super.init(self)

    self.name = "Ghosty Candy"
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"

    -- Battle description
    self.effect = "Healing\nvaries"
    -- Shop description
    self.shop = "Sick\njuice that\nheals 160HP"
    -- Menu description
    self.description = "A peculiar candy that lets out a scream when swallowed."

    -- Amount healed (HealItem variable)
    self.heal_amount = 15

    self.world_heal_amounts = {
        ["kogasa"] = 95,
        ["seija"] = 30,
        ["rin"] = 30,
        ["reisen"] = 50
    }
    self.battle_heal_amounts = {
        ["kogasa"] = 95,
        ["seija"] = 40,
        ["rin"] = 40,
        ["reisen"] = 60
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
        kogasa = "Ah! You scared me!",
        seija = "What the heck?!",
        rin = "Uwaah!",
        reisen = {
            reisen = "Uweeh!!! Don\'t scare me like that!",
            kogasa = "Gotcha! Did I scare you?"
        }
    }
end

function item:onWorldUse(target)
    local consumed = super.onWorldUse(self, target)

    -- Heal Kogasa too when used on others
    if target.id ~= "kogasa" and Game:hasPartyMember("kogasa") then
        Game.world:heal("kogasa", self.heal_amount)
    end

    return consumed
end

return item
