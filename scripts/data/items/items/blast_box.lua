local item, super = Class(TensionItem, "blast_box")

function item:init()
    super.init(self)

    self.name = "B.Box"
    self.use_name = "Blast Box"

    self.type = "item"
    self.icon = nil

    self.effect = "Raises\nTP\n35%"
    self.shop = ""
    self.description = "Green box explodes when opened. Boosts battle tension. Raises TP by 35% in battle."

    self.tp_amount = 35

    self.price = 100
    self.can_sell = true

    self.target = "party"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = true

    self.reactions = {}
end

return item