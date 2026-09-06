local item, super = Class(HealItem, "book_page")

function item:init()
    super.init(self)

    self.name = "Book Page"
    self.use_name = "BOOK PAGE"

    self.type = "item"

    self.world_heal_amount = 1
    self.battle_heal_amount = 50

    self.effect = "Heals\n50HP"
    self.shop = ""
    self.description = "A page featuring a self-portrait of Koakuma. Heals 1 HP."

    self.price = 250
    self.can_sell = false

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "Uhh...",
        seija = "Sure, why not.",
        rin = "(Uncomfortable)",
        reisen = "You really expect me to eat this?"
    }
end

return item