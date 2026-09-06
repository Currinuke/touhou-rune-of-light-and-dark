local spell, super = Class(Spell, "mind_shaker")

function spell:init()
    super.init(self)

    self.name = "MindShaker"
    self.cast_name = nil

    self.effect = "Heal\nally"
    self.description = "Heavenly light restores a little HP to\none party member. Depends on Magic."

    self.cost = 8
    self.target = "enemy"
    self.tags = {"spare_tired"}
end

function spell:getTPCost(chara)
    local cost = super.getTPCost(self, chara)
    if chara and chara:checkWeapon("lunatic_ocular") then
        cost = MathUtils.round(cost / 2)
    end
    return cost
end

function spell:getCastMessage(user, target)
    local message = super.getCastMessage(self, user, target)
    if target.tired then
        return message
    elseif target.mercy < 100 then
        return message.."\n[wait:0.25s]* But the enemy wasn't [color:blue]TIRED[color:reset]..."
    else
        return message.."\n[wait:0.25s]* But the foe wasn't [color:blue]TIRED[color:reset]... try\n[color:yellow]SPARING[color:reset]!"
    end
end

function spell:onCast(user, target)
    if target.tired then
        target:spare(true)
        if not Game:getConfig("oldPacify") then
            Assets.playSound("spell_pacify")

            local pacify_x, pacify_y = target:getRelativePos(target.width/2, target.height/2)
            local z_count = 0
            local z_parent = target.parent
            Game.battle.timer:every(1/15, function()
                z_count = z_count + 1
                local z = SpareZ(z_count * -40, pacify_x, pacify_y)
                z.layer = target.layer + 0.002
                z_parent:addChild(z)
            end, 8)
        end
    else
        local recolor = target:addFX(RecolorFX())
        Game.battle.timer:during(8/30, function()
            recolor.color = ColorUtils.mergeColor(recolor.color, {0, 0, 1}, 0.12 * DTMULT)
        end, function()
            Game.battle.timer:during(8/30, function()
                recolor.color = ColorUtils.mergeColor(recolor.color, {1, 1, 1}, 0.16 * DTMULT)
            end, function()
                target:removeFX(recolor)
            end)
        end)
    end
end

return spell