local item, super = Class(HealItem, "halfraw_steak")

function item:init()
    super.init(self)

    self.name = "Halfraw Steak"
    self.use_name = self.name

    self.type = "item"

    self.heal_amount = 70
    self.heal_amounts = {
        ["rin"] = 10
    }
    
    self.effect = "Bleeding\nsteak"
    self.shop = ""
    self.description = "A medium-rare steak prepared by the Head Maid\nin her spare time... It\'s still bleeding."

    self.price = 250
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "Is this undercooked?",
        seija = "It\'s meat!",
        rin = "...What kind of meat is this?",
        reisen = "Can\'t handle this... fancy kind."
    }
end

return item