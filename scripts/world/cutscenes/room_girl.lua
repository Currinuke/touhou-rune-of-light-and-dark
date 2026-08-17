return {
    tree = function(cutscene, event)
        if Game:getFlag("found_girl", false) then
            cutscene:text("* There\'s no girl.")
        else
            if not event:getFlag("used_once", false) then
                event:setFlag("used_once", true)
                cutscene:text("* It\'s an apple tree.")
                cutscene:text("* However, [wait:5]there isn\'t any apple on the tree.")
            end

            cutscene:text("* She is behind the tree.")
        end
    end,

    girl = function(cutscene, event)
        if Game:getFlag("found_girl", false) then
            cutscene:text("* There\'s no girl.")
        else
            Game:setFlag("found_girl", true)
            cutscene:text("* There\'s a girl behind the tree.")
            cutscene:text("* She seems surprised to see you find her.")
            cutscene:text("* She told you a pun about apples.")
            cutscene:text("* ...")
            cutscene:text("* But neither you nor she laughed.")
            cutscene:text("* She offered to give you something as compensation.")
            cutscene:text("* Accept her kindness?")

            local option = cutscene:choicer({"Yes", "No"})
            if option == 1 then
                Game:setFlag("got_apple", true)
                Game.inventory:tryGiveItem("bad_apple")
                Assets.playSound("egg")
                cutscene:text("* You got the [color:yellow]Bad Apple[color:reset].")
            else
                cutscene:text("* You rejected her kindness.") -- 原作没有呢
            end
        end
    end
}
