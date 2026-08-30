local item, super = Class(HealItem, "miracle_onigiri")

function item:init()
    super.init(self)

    self.name = "MiracOnigiri"
    self.use_name = "Miracle Onigiri"

    self.type = "item"

    self.effect = "Heals\nteam\n240HP"
    self.shop = ""
    self.description = "Born from a legendary chef and master blacksmith. Heals 240 HP to the team."

    self.heal_amount = 240

    self.price = 150
    self.can_sell = true

    self.target = "party"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "So... so good!",
        seija = "Isn\'t it just a regular onigiri?",
        rin = "Such a unique flavor!",
        reisen = "Such a comforting taste..."
    }
end

return item