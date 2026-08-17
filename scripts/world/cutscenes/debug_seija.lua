return {
    set = function(cutscene, event)
        local has_seija = cutscene:getCharacter("seija")
        if has_seija then
            cutscene:text("* Hey,[wait:5] I\'m Currinuke.") --PartyMember
            local seija = Game:getPartyMember("seija")
            if seija:getFlag("auto_attack", true) then
                cutscene:text("* I\'ve got a way to make [color:yellow]Seija[color:reset] less rude.")
                cutscene:text("* How do you think?")
                local option = cutscene:choicer({"Stay rude", "Make her\npolite"})
                cutscene:text("* Got it.")
                if option == 2 then
                    seija:setFlag("auto_attack", false)
                    Assets.playSound("egg")
                    cutscene:text("* ([color:yellow]Seija[color:reset] now listens to your commands!).")
                end
            else
                cutscene:text("* I still know a way to make [color:yellow]Seija[color:reset] more rude.")
                cutscene:text("* How do you think?")
                local option = cutscene:choicer({"Stay polite", "Make her\nrude"})
                cutscene:text("* Alright.")
                if option == 2 then
                    seija:setFlag("auto_attack", true)
                    Assets.playSound("egg")
                    cutscene:text("* ([color:yellow]Seija[color:reset] now attacks every enemy her see!).")
                end

            end
        else
            cutscene:text("* (He\'s just standing here.)")
            cutscene:text("* (If [color:yellow]Seija[color:reset] were also here...)")
        end
    end
}
