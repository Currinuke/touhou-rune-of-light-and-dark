local item, super = Class(Item, "lunatic_ocular")

function item:init()
    super.init(self)

    self.name = "LunaticOc"

    self.type = "weapon"
    self.icon = "ui/menu/icon/ring"

    self.effect = ""
    self.shop = ""
    self.description = "戴在眼上时会因疼痛而受到伤害。降低所有法术的TP消耗。"

    self.price = 0
    self.can_sell = false

    self.target = "none"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.bonuses = {
        attack = 16,
        magic  = 16
    }
    self.bonus_name = "{bonus_blindness}"
    self.bonus_icon = "ui/menu/icon/ring"

    self.can_equip = {
        reisen = true
    }

    self.reactions = {
        kogasa = "",
        seija = "Ah! My eyes!",
        rin = "...",
        reisen = ""
    }
end

--[[
function item:onEquip(character, replacement)
    for _, spell in ipairs(character.spells) do
        function spell:getTPCost(chara)
            return MathUtils.round(super.getTPCost(spell, chara) / 2 or spell.cost / 2)
        end
    end

    return true
end

function item:onUnequip(character, replacement)
    for _, spell in ipairs(character.spells) do
        function spell:getTPCost(chara)
            return super.getTPCost(spell, chara) or spell.cost
        end
    end
    return true
end--]]

function item:onBattleUpdate(battler)
    battler.thorn_ring_timer = (battler.thorn_ring_timer or 0) + DTMULT

    if battler.thorn_ring_timer >= 6 then
        battler.thorn_ring_timer = battler.thorn_ring_timer - 6

        if battler.chara:getHealth() > MathUtils.round(battler.chara:getStat("health") / 3) then
            battler.chara:setHealth(battler.chara:getHealth() - 1)
        end
    end
end

return item
