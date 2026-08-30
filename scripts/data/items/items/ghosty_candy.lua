local item, super = Class(HealItem, "ghosty_candy")

function item:init()
    super.init(self)

    self.name = "Ghosty Candy"
    self.use_name = self.name

    self.type = "item"

    self.effect = "Healing\nvaries"
    self.shop = "Sick\njuice that\nheals 160HP"
    self.description = "A peculiar candy that lets out a scream when swallowed."

    self.heal_amount = 15
    self.heal_amounts = {
        ["kogasa"] = 95,
    }
    self.world_heal_amounts = {
        ["seija"] = 30,
        ["rin"] = 30,
        ["reisen"] = 50
    }
    self.battle_heal_amounts = {
        ["seija"] = 40,
        ["rin"] = 40,
        ["reisen"] = 60
    }

    self.price = 450
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

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
        if target.id == "reisen" then
            -- Heal Kogasa triple when used on Reisen
            Game.world:heal("kogasa", self.heal_amount * 3)
        else
            Game.world:heal("kogasa", self.heal_amount)
        end
    end

    return consumed
end

return item
