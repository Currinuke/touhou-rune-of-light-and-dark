local item, super = Class(HealItem, "sickly_milk")

function item:init()
    super.init(self)

    self.name = "Sickly Milk"
    self.use_name = "SICKLY MILK"

    self.type = "item"

    self.effect = "Heals\n10HP"
    self.shop = ""
    self.description = "因为工艺拙劣而导致变质极快的牛奶。+10HP"

    self.heal_amount = 10

    self.price = 2
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"
    
    self.reactions = {
        kogasa = "也许剩下的能留给别人?",
        seija = "我能吃两份。",
        rin = "分量是不是有点太大了...?",
        reisen = "我...我能拒绝吗?"
    }
end

return item