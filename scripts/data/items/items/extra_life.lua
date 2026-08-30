local item, super = Class(Item, "extra_life")

function item:init()
    super.init(self)

    self.name = "Ex-Life"
    self.use_name = "EXTRA LIFE"

    self.type = "item"

    self.effect = "Heal\nDowned\nAlly"
    self.shop = ""
    self.description = "Heals a fallen ally to MAX HP.\nA heart-shaped crystal with an indescribable taste."

    self.price = 400
    self.can_sell = true

    self.target = "ally"
    self.usable_in = "all"

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
