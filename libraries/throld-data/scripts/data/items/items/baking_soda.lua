local item, super = Class(Item, "baking_soda")

function item:init()
    super.init(self)

    self.name = "Baking Soda?"
    self.use_name = "BAKING SODA"

    self.type = "item"

    self.effect = "Hurts\nparty\nmember"
    self.shop = "ITEM\nITEM\nAFFECTS HP\nA LOT!\nTHE SMOOTH\nTASTE OF"
    self.description = "A strange concoction made of\ncolorful squares. Will poison you."

    self.price = 110
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

    self.reactions = {
        kogasa = "也许剩下的能留给别人?",
        seija = "我能吃两份。",
        rin = "分量是不是有点太大了...?",
        reisen = "我...我能拒绝吗?"
    }

    -- Amount the poison damages in the world
    self.world_poison_amount = 50

    -- Amount the poison heals in battle
    self.battle_heal_amount = 150
    -- Amount the poison damages in battle
    self.battle_poison_amount = 200
end

function item:getBattleText(user, target)
    return Game:loc("item_" .. self.id .. "_battleText", {
        userName = user.chara:getName(),
        useName = self:getUseName()
    })
end

function item:onWorldUse(target)
    if target.id == "reisen" then
        return true
    end
    target:setHealth(math.max(1, target:getHealth() - self.world_poison_amount))
    Assets.playSound("hurt")
    return true
end

function item:onBattleUse(user, target)
    target:heal(self.battle_heal_amount, {1, 0, 1})
    Assets.playSound("hurt")

    if target.poison_effect_timer then
        Game.battle.timer:cancel(target.poison_effect_timer)
    end

    local poison_left = self.battle_poison_amount
    target.poison_effect_timer = Game.battle.timer:every(1/5, function()
        if poison_left == 0 then
            return false
        end
        if target.chara:getHealth() > 1 then
            target.chara:setHealth(1)
            poison_left = poison_left - 1
        else
            poison_left = 0
            return false
        end
    end)
end

return item