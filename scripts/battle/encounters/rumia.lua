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
        if enemy.name == "Rumia" and enemy.health <= enemy.max_health / 10 then
            Game.battle:startCutscene("rumia", "heal", self, enemy)
            -- Game.battle:setState("DEFENDINGEND", "WAVEENDED")
            return true
        end
    end
end

return Rumia