local spell, super = Class(Spell, "rule_burster")

function spell:init()
    super.init(self)

    self.name = "Rule Burster"
    self.cast_name = nil

    self.effect = "Rule\ndamage"
    self.description = "Deals moderate Rude-elemental damage to\none foe. Depends on Attack & Magic."

    self.cost = 50

    self.target = "enemy"

    self.tags = {"rude", "rule", "damage"}
end

function spell:getCastMessage(user, target)
    -- 是特意设置的特殊使用文本，还是经典的“细节不连贯”问题？
    return Game:loc("spell_" .. self.id .. "_castMessage", {
        userName = user.chara:getName():upper(),
        castName = self:getCastName()
    })
end

function spell:onCast(user, target)
    local buster_finished = false
    local anim_finished = false
    local function finishAnim()
        anim_finished = true
        if buster_finished then
            Game.battle:finishAction()
        end
    end
    if not user:setAnimation("battle/rule_burster", finishAnim) then
        anim_finished = false
        user:setAnimation("battle/attack", finishAnim)
    end
    Game.battle.timer:after(15/30, function()
        Assets.playSound("rudebuster_swing")
        local x, y = user:getRelativePos(user.width, user.height/2 - 10, Game.battle)
        local tx, ty = target:getRelativePos(target.width/2, target.height/2, Game.battle)
        local blast = RudeBusterBeam(false, x, y, tx, ty, function(damage_bonus, play_sound)
            local damage = self:getDamage(user, target, damage_bonus)
            if play_sound then
                Assets.playSound("scytheburst")
            end
            target:flash()
            target:hurt(damage, user)
            buster_finished = true
            if anim_finished then
                Game.battle:finishAction()
            end
        end)
        blast.layer = BATTLE_LAYERS["above_ui"]
        Game.battle:addChild(blast)
    end)
    return false
end

function spell:getDamage(user, target, damage_bonus)
    local _, yellowhat_count = user.chara:checkArmor("yellowhat")

    local magic_part = user.chara:getStat("magic") * (5 + (yellowhat_count * 0.5))
    local attack_part = user.chara:getStat("attack") * (11 + yellowhat_count)

    local damage = math.ceil(magic_part + attack_part - (target.defense * 3)) + damage_bonus

    if user.chara:checkWeapon("s_shaped_stick") then
        damage = damage + 66
    end

    return damage
end

return spell
