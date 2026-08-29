local item, super = Class(HealItem, "all_melette")

function item:init()
    super.init(self)

    self.name = "All-melette"
    self.use_name = "ALL-MELETTE"

    self.type = "item"

    self.heal_amount = 80
    self.heal_amounts = {
        reisen = 20
    }

    self.effect = "Heals\n80HP"
    self.shop = ""
    self.description = "用一个超巨大的煎蛋将煎蛋卷饼卷起来,再在上面加上更多特制酱料..."

    self.price = 400
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