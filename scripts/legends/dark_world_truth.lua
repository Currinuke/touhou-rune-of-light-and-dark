return function(cutscene)
    cutscene:hideCover()
    Game.legend.music:play("flashback_excerpt")
    
    local slide = cutscene:slide("legends/dont_forget")
    slide:setScale(0)
    slide.x = (SCREEN_WIDTH - slide.width * slide.scale_x) / 2
    slide.y = 160

    cutscene:setSpeed(0.25)
    local duration = Game.legend.music.source:getDuration()
    for i = 1, 34 do
        cutscene:text("{legend_dark_world_truth_" .. i .. "}", "far_left").state.typing_sound = "ralsei"
        local wait_time = duration / 8
        local time = (i % 8) * wait_time
        if i == 28 then
            wait_time = duration * 2
        elseif i == 29 then
            time = time + wait_time
            wait_time = duration * 2
        end
        cutscene:wait(function() return Game.legend.music:tell() >= time and Game.legend.music:tell() < time + wait_time end)
        cutscene:removeText()
    end
    Game.legend.music:stop()
    cutscene:text("{legend_dark_world_truth_35}", "far_left")
    cutscene:wait(duration / 8)
    cutscene:removeText()

    cutscene:removeSlides()
    cutscene:showCover()
end