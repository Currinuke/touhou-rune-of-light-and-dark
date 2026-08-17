local item, super = Class(Item, "ex_life")

function item:init()
    super.init(self)

    -- Display name
    self.name = "Ex-Life"
    -- Name displayed when used in battle (optional)
    self.use_name = self.name

    -- Item type (item, key, weapon, armor)
    self.type = "item"
    -- Item icon (for equipment)
    self.icon = nil

    -- Battle description
    self.effect = "Heal\nDowned\nAlly"
    -- Shop description
    self.shop = ""
    -- Menu description
    self.description = "Heals a fallen ally to MAX HP.\nA heart-shaped crystal with an indescribable taste."

    -- Default shop price (sell price is halved)
    self.price = 400
    -- Whether the item can be sold
    self.can_sell = true

    -- Consumable target mode (ally, party, enemy, enemies, or none)
    self.target = "ally"
    -- Where this item can be used (world, battle, all, or none)
    self.usable_in = "all"
    -- Item this item will get turned into when consumed
    self.result_item = nil
    -- Will this item be instantly consumed in battles?
    self.instant = false

    -- Character reactions
    self.reactions = {
        kogasa = {
            kogasa = "I\'m full!!!",
            seija = "Did you even eat anything?",
            rin = "Does it actually do that?"
        },
        seija = {
            kogasa = "You don\'t know?",
            seija = "What is this?",
            rin = "Don\'t waste it!"
        },
        rin = {
            kogasa = "I don\'t see any difference.",
            seija = "(You weren\'t dead yet)",
            rin = "I\'m alive again!"
        },
        reisen = {
            kogasa = "Really?",
            reisen = "I love this stuff!"
        }
    }
end

function item:onWorldUse(target)
    Game.world:heal(target, math.ceil(target:getStat("health") / 2))
    return true
end

function item:onBattleUse(user, target)
    local heal_amount
    if target.chara:getHealth() <= 0 then
        heal_amount = math.abs(target.chara:getHealth()) + target.chara:getStat("health")
    else
        heal_amount = math.ceil(target.chara:getStat("health") / 2)
    end
    target:heal(Game.battle:applyHealBonuses(heal_amount, user.chara, target.chara))
end

return item
