return function(cutscene)
    cutscene:hideCover()
    Game.legend.music:play("man")
    cutscene:wait(10)
    cutscene:showCover()
end