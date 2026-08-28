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

    self.price = 450
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

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
