return function(event, player, facing)
    if (not Game:getFlag("ch1_found_girl", false)) and MathUtils.random() <= 0.02 then
        Game.world:mapTransition("rm_girl", "entry", "up", function()
            local seija = Game.world:removeFollower("seija")
            if seija then seija:remove() end
            local rin = Game.world:removeFollower("rin")
            if rin then rin:remove() end
            local reisen = Game.world:removeFollower("reisen")
            if reisen then reisen:remove() end
        end)
    else
        Game.world:mapTransition("rm_manor_basement", "entry", "down")
    end
end