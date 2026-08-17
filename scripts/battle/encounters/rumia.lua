local Rumia, super = Class(Encounter)

function Rumia:init()
    super.init(self)
    self.text = "* The night youkai axe-identally strikes over."
    self.music = "checkers"
    self.background = false
    self.hide_world = true
    self:addEnemy("rumia")
    self.no_end_message = false
end

function Rumia:onActionsEnd()
    for _, enemy in ipairs(Game.battle.enemies) do
        if enemy.health <= enemy.max_health / 10 then
            -- enemy:event_heal()
            enemy:heal(enemy.max_health)
            -- Game.battle:startActCutscene("rumia", "heal")
            break
        end
    end
end

return Rumia