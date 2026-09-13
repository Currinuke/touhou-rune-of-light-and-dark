return {
    tree = function(cutscene, event)
        if Game:getFlag("ch1_found_girl", false) then
            cutscene:text("{world_rm_girl_nogirl}")
        else
            if not event:getFlag("used_once", false) then
                event:setFlag("used_once", true)
                cutscene:text("{world_rm_girl_tree_check_1}")
                cutscene:text("{world_rm_girl_tree_check_2}")
            end

            cutscene:text("{world_rm_girl_tree_behindtree}")
        end
    end,

    girl = function(cutscene, event)
        if Game:getFlag("ch1_found_girl", false) then
            cutscene:text("{world_rm_girl_nogirl}")
        else
            Game:setFlag("ch1_found_girl", true)
            cutscene:text("{world_rm_girl_girl_1}")
            cutscene:text("{world_rm_girl_girl_2}")
            cutscene:text("{world_rm_girl_girl_3}")
            cutscene:text("{world_rm_girl_girl_4}")
            cutscene:text("{world_rm_girl_girl_5}")
            cutscene:text("{world_rm_girl_girl_6}")
            cutscene:text("{world_rm_girl_girl_7}")

            local option = cutscene:choicer({"{yes}", "{no}"})
            if option == 1 then
                Game:setFlag("ch1_got_apple", true)
                Game.inventory:tryGiveItem("bad_apple")
                Assets.playSound("egg")
                cutscene:text("{world_rm_girl_gotapple}")
            else
                -- 原动画没有就自己写吧（
                cutscene:text("{world_rm_girl_whatgirl}")
            end
        end
    end
}
