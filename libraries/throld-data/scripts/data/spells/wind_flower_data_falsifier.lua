local spell, super = Class(Spell, "wind_flower_data_falsifier")

function spell:init()
    super.init(self)

    self.name = "D.Falsifier"
    self.cast_name = "W.F.「DATA FALSIFIER」"

    self.effect = "Falsify\nHP stats"
    self.description = ""

    self.cost = 50
    self.target = "party"
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    local magic = user.chara:getStat("magic")
    local heal = {}
    local percentage = 1
    local per_changed = false

    for index, battler in ipairs(target) do
        -- 获取各队员的剩余HP百分比
        local max_health = battler.chara:getStat("health") + magic * 10
        local health = battler.chara:getHealth()
        local _per = health / max_health
        heal[index] = _per
        if _per < percentage then
            percentage = _per
            per_changed = true
        end
    end

    local real_target = {}
    if per_changed then
        for index, battler in ipairs(target) do
            -- 选中最低百分比的队员
            if heal[index] <= percentage then
                table.insert(real_target, battler)
            end
        end
    else
        real_target = target
    end

    if #real_target > 0 then
        local battler = real_target[MathUtils.randomInt(1, #real_target)]
        local max_health = battler.chara:getStat("health") + magic * 10
        local health = battler.chara:getHealth()
        battler.chara:setHealth(math.max(health, max_health))
        battler:checkHealth(false)
        battler:flash()
        Assets.playSound("falsifier")
    end
end

return spell
