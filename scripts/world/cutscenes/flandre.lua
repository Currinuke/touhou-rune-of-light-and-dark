return {
    outside = function(cutscene, event)
        local kogasa = cutscene:getCharacter("kogasa")
        local seija = cutscene:getCharacter("seija")
        local rin = cutscene:getCharacter("rin")
        
        local x = event.x + event.width / 2
        local y = event.y + event.height / 2

        cutscene:detachCamera()
        cutscene:detachFollowers()
        cutscene:walkTo(kogasa, x, y + 60, 1, "up")
        if seija then cutscene:walkTo(seija, x - 40, y + 80, 1, "up") end
        if rin then cutscene:walkTo(rin, x + 40, y + 80, 1, "up") end
        cutscene:wait(1)

        -- 没写钥匙之类的其它东西，所以默认拿到钥匙了
        cutscene:text("* We bring the key.", "smile", "kogasa")
        cutscene:text("* So?\n[wait:5]Are you coming out or what?", "smile", "seija")
        cutscene:wait(0.5)
        cutscene:text("* Out...? [wait:5]Aren't you misunderstanding something?")
        cutscene:text("* It's not about me going out.\n[wait:5]It's about you coming in.")
        cutscene:wait(0.5)
        cutscene:text("* Come in... [wait:10]and play a little game with me.")

        cutscene:mapTransition("room_dw_flandre", "entry", "up", function()end)
        cutscene:wait(1)
        cutscene:startEncounter("flandre", true, nil, {on_start = function()
            -- rumia:setFlag("dont_load", true)
            -- rumia:remove()
        end})
    end
}
