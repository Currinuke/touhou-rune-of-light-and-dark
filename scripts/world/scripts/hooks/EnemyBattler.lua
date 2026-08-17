local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

function EnemyBattler:init(...)
    super.init(self, ...)
    self.is_flandre = false
end

function EnemyBattler:hurt(amount, battler, on_defeat, color, show_status, attacked)
    if amount == 0 or (amount < 0 and Game:getConfig("damageUnderflowFix")) then
        if show_status ~= false then
            self:statusMessage("msg", "miss", color or (battler and { battler.chara:getDamageColor() }))
        end

        self:onDodge(battler, attacked)
        return
    end

    if not self.is_flandre then
        self.health = self.health - amount
    else
        for _, enemy in ipairs(Game.battle.enemies) do
            enemy.health = enemy.health - amount
        end
    end

    if show_status ~= false then
        self:statusMessage("damage", amount, color or (battler and { battler.chara:getDamageColor() }))
    end

    if amount > 0 then
        self.hurt_timer = 1
        self:onHurt(amount, battler)
    end

    self:checkHealth(on_defeat, amount, battler)
end
--[[
function EnemyBattler:hurt(...)
    -- Code above the original function runs before it:
    Kristal.Console:log("Enemy " .. self.name .. " has " .. self.health .. " HP.")

    super.hurt(self, ...)

    -- Code below the original function runs after it:
    Kristal.Console:log("Enemy " .. self.name .. " has " .. self.health .. " HP.")

    Kristal.Console:log("-------------") -- Draw a big line at the end so we can easily see where each Hurt ends
    lobal table = ...
    for _, enemy in ipairs(Game.battle.enemies) do
        -- Make the enemy tired
        enemy.health = enemy.health - table
    end
end]]

return EnemyBattler