local item, super = Class(HealItem, "jvav_cawfee")

function item:init()
    super.init(self)

    -- 注：刻意的拼写错误
    self.name = "Jvav Cawfee"
    self.use_name = "JVAV CAWFEE"

    self.type = "item"

    self.heal_amount = 140

    self.effect = "Heals\n140HP"
    self.shop = ""
    self.description = "某种“进口”的高级咖啡,热腾腾的。"

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