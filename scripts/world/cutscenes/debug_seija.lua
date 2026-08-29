return {
    set = function(cutscene, event)
        local has_seija = cutscene:getCharacter("seija")
        if has_seija then
            cutscene:text("* Hey,[wait:5] I\'m Currinuke.")
            local seija = Game:getPartyMember("seija")
            if seija:getFlag("auto_attack", true) then
                cutscene:text("* I\'ve got a way to make [color:yellow]Seija[color:reset] less rude.")
                cutscene:text("* How do you think?")
                local option = cutscene:choicer({"Stay rude", "Make her\npolite"})
                cutscene:text("* Got it.")
                if option == 2 then
                    seija:setFlag("auto_attack", false)
                    Assets.playSound("item")
                    cutscene:text("* ([color:yellow]Seija[color:reset] now listens to your commands!)")
                end
            else
                cutscene:text("* Actually, I also know a way to make [color:yellow]Seija[color:reset] more rude.")
                cutscene:text("* How do you think?")
                local option = cutscene:choicer({"Stay polite", "Make her\nrude"})
                cutscene:text("* Alright.")
                if option == 2 then
                    seija:setFlag("auto_attack", true)
                    Assets.playSound("ominous")
                    cutscene:text("* ([color:yellow]Seija[color:reset] now attacks every enemy on her way!)")
                    cutscene:text("* Hey, [wait:5]what was that look...\n[wait:10]Anything wrong?")
                end

            end
        else
            cutscene:text("* (He\'s just standing here.)")
            cutscene:text("* (If [color:yellow]Seija[color:reset] is here as well...)")
        end
    end,
    anim = function(cutscene, event)
        --[[
        if not event.sprite_fade then
            event.sprite_fade = Sprite("walk/down")
            event.sprite_fade.alpha = 0.3
            event:addChild(event.sprite_fade)
            --event.sprite
        end]]
        local actor = "kogasa"
        event:setActor(actor)
        local kogasa = cutscene:getCharacter(actor)
        if not kogasa then
            Kristal.Console:push("No Kogasa")
            return
        end

        --for key, value in pairs(kogasa.actor.animations) do
        --    Kristal.Console:push(tostring(key) .. ": " .. tostring(value))
        --end

        local anims = {}
        local i = 0
        for key, value in pairs(kogasa.actor.animations) do
            i = i + 1
            anims[i] = value[1]
        end
        
        -- Kristal.Console:push("Animations: " .. tostring(i))
        local num = event:getFlag("anim", 0)

        num = num + 1
        if num > i then
            num = 1
        end
        event:setFlag("anim", num)
        Assets.playSound("noise")
        local anim = anims[num]
        Kristal.Console:push("Animation(" .. tostring(num) .. "): " .. tostring(anim))
        --if event.actor:getAnimation(anim) then
        if event.sprite.name == anim then
            event.sprite:setAnimation({"walk/down", 0.1, true})
        else
            event.sprite:setAnimation({anim, 0.1, true})
        end
    end,
    set_weird = function(cutscene, event)
        local has_reisen = cutscene:getCharacter("reisen")
        if has_reisen then
            cutscene:text("* Hey,[wait:5] I\'m Currinuke.")
            local reisen = Game:getPartyMember("reisen")
            if not reisen:getFlag("weird", false) then
                cutscene:text("* I\'ve heard about that youkai...")
                cutscene:text("* So, [wait:5]how do you like the ocular?")
                local option = cutscene:choicer({"What youkai", "Proceed"})
                if option == 2 then
                    cutscene:text("* ... As you wish.")
                    reisen:setFlag("weird", true)
                    Assets.playSound("ominous")
                    if not reisen:hasSpell("lunatic_shot") then
                        reisen:addSpell("lunatic_shot")
                    end
                else
                    cutscene:text("* ... Nevermind.")
                end
            else
                cutscene:text("* Something weird is happening...")
                cutscene:text("* Do you feel it?")
                local option = cutscene:choicer({"No idea", "Proceed"})
                if option == 2 then
                    cutscene:text("* ...")
                else
                    cutscene:text("* Fine...\n[wait:5]See you later, miss.")
                    Assets.playSound("ominous_cancel")
                    reisen:setFlag("weird", false)
                    -- reisen:removeSpell()
                end
            end
        else
            cutscene:text("* (He\'s just standing here.)")
            cutscene:text("* (Hope [color:yellow]Reisen[color:reset] won\'t be here...)")
        end
    end
}