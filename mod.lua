function Mod:preInit()
    -- return true
end

function Mod:init()
    Game.skip_dialogue = Game.skip_dialogue or {}
    
    MUSIC_VOLUMES["wind_highplace"] = 0.7
    MUSIC_VOLUMES["gallery"] = 0.7
end