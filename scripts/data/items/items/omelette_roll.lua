local item, super = Class(HealItem, "omelette_roll")

function item:init()
    super.init(self)

    self.name = "Omelette Roll"
    self.use_name = self.name

    self.type = "item"
    self.icon = nil

    self.heal_amount = 70
    self.heal_amount_reisen = 20

    self.effect = "Heals\n70HP"
    self.shop = "Master Hong\'s\nspecialty\nHeals 70HP"
    self.description = "Large omelette wrapped around flatbread,\nwith special sauce. Heals 70 HP. "

    self.price = 400
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {}
    self.bonus_name = nil
    self.bonus_icon = nil

    self.can_equip = {}

    self.reactions = {
        kogasa = "That\'s a huge omelette!",
        seija = "I like this cooking style.",
        rin = "Isn\'t this a bit too spicy...?",
        reisen = "Hot! Water, give me water!"
    }
end

function item:getHealAmount(id)
    if id == "reisen" then
        return self.heal_amount_reisen
    else
        return self.heal_amount
    end
end

return item