local spell, super = Class(Spell, "wind_flower_data_falsifier")

function spell:init()
    super.init(self)

    self.name = "D.Falsifier"
    self.cast_name = "Wind Flower [Data Falsifier]"

    self.effect = "Change\nHP stats"
    self.description = ""

    self.cost = 50
    self.target = "party"
    self.tags = {"heal"}
end

function spell:onCast(user, target)
    --[[
    local battler = target[MathUtils.randomInt(1, 1 + #target)]
    Assets.playSound("smile")
    battler:heal(battler.chara:getBaseStat("health"))--]]

    local heal = {}
    local percentage = 1
    local per_changed = false

    for index, battler in ipairs(target) do
        -- 获取各队员的剩余HP百分比
        local max_health = battler.chara:getStat("health")
        local health = battler.chara:getHealth()
        local _per = health / max_health
        heal[index] = _per
        if _per < percentage then
            percentage = _per
            per_changed = true
        end
    end

    if per_changed then
        local real_target = {}

        for index, battler in ipairs(target) do
            -- 选中最低百分比的队员
            if heal[index] <= percentage then
                table.insert(real_target, battler)
            end
        end

        if #real_target > 0 then
            local battler = real_target[MathUtils.randomInt(1, #real_target)]
            battler.chara:setHealth(battler.chara:getStat("health"))
            battler:checkHealth(false)
            battler:flash()
            Assets.playSound("falsifier")
        end
    end

    --[[
    local battler = target[MathUtils.randomInt(1, 1 + #target)]
    Assets.playSound("smile")
    battler:heal(battler.chara:getBaseStat("health"))--]]

    --[[
    for _, battler in ipairs(target) do
        local base_health = battler.chara:getStat("health")
        -- battler.chara:setHealth(math.floor(base_health * 1.5))
        battler:heal(math.floor(base_health / 2))
    end--]]
end

return spell
