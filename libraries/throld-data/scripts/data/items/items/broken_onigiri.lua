local item, super = Class(HealItem, "broken_onigiri")

function item:init()
    super.init(self)

    self.name = "Broken Onigiri"
    self.use_name = "BROKEN ONIGIRI"

    self.type = "key"

    self.effect = "Not\ntasty"
    self.shop = ""
    self.description = "Lacking the Moonlight Grass makes it rather ordinary. A workbench might be able to fix it."

    self.heal_amount = 20

    self.price = 0
    self.can_sell = false

    self.target = "ally"
    self.usable_in = "battle"
end

function item:onMenuOpen(menu)
    if menu and Game.inventory:getItemIndex(self) == "key_items" then
        self.target = "none"
        self.usable_in = "none"
    end
end

return item