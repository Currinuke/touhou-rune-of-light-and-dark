local item, super = Class(HealItem, "3x_ice_cream")

function item:init()
    super.init(self)

    self.name = "3x Ice-cream"
    self.use_name = self.name

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n99HP"
    self.shop = ""
    self.description = "Ice cream with three scoops and three cones! Heals 99 HP to the team."

    self.heal_amount = 99

    self.price = 90
    self.can_sell = true

    self.target = "party"
    self.usable_in = "all"
    self.result_item = nil
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