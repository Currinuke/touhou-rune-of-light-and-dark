return {
    heal = function(cutscene, encounter, enemy)
        cutscene:text("* Rumia 过于紧张，吸收了大量黑暗。")
        cutscene:text("* Rumia 的攻击力上升了。")

        enemy:heal(enemy.max_health)
        enemy.attack = enemy.attack + 1
        enemy.wave_override = "empty_wave"
    end,

    act_wind = function(cutscene, battler, enemy)
        cutscene:text("* Kogasa orders Rin to create\na strong wind.")
        cutscene:text("* Press [bind:confirm] to summon!")
        
        enemy:setTired(true)
        enemy:addMercy(50)
        enemy:addMercy(40)
    end
}