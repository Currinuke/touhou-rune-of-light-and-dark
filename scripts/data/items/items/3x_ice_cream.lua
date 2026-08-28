local item, super = Class(HealItem, "3x_ice_cream")

function item:init()
    super.init(self)

    self.name = "3x Ice-cream"
    self.use_name = self.name

    self.type = "item"
    self.icon = nil

    self.effect = "Heals\nteam\n99HP"
    self.shop = ""
    self.description = "Ice cream with three scoops and three cones! Heals 99 HP to the team."

    self.heal_amount = 99

    self.price = 90
    self.can_sell = true

    self.target = "party"
    self.usable_in = "all"
    self.result_item = nil
    self.instant = false

    self.reactions = {
        kogasa = "One for each of us, perfect!",
        seija = "Why not split it sideways?",
        rin = "So cold!",
        reisen = {
            reisen = "Here\'s my extra share, Kogasa.",
            kogasa = "Thanks!"
        }
    }
end

--[[我废了这段代码是因为暂时不想动i18n库的代码
所以就改原文了
function item:getReaction(user_id, reactor_id)
    if user
    local reactions = self:getReactions()
    if reactions[user_id] then
        if type(reactions[user_id]) == "string" then
            if reactor_id == user_id then
                return reactions[user_id]
            else
                return nil
            end
        else
            return reactions[user_id][reactor_id]
        end
    end
end

function item:getReactions()
    local reactions = super.getReactions(self)

    if Game:hasPartyMember("reisen") then
        reactions.kogasa = "Thanks!"
    elseif #Game.party >= 3 then
        reactions.kogasa = "One for each of us, perfect!"
    else
        reactions.kogasa = "I\'m full! Full of joy!"
        reactions.kogasa = "{item_3x_ice_cream_kogasaReaction_alt}"
    end
    
    return reactions
end

function item:onWorldUse(target)
    local consumed = super.onWorldUse(self, target)
    return consumed
end]]


return item