return {
    bridge = function(cutscene, event)
        local kogasa = Game.world.player
        local seija = cutscene:getCharacter("seija")
        local koakuma = cutscene:getCharacter("koakuma")
        local rumia = cutscene:getCharacter("rumia")
        local rin = cutscene:getCharacter("rin")

        if kogasa and seija and koakuma and rumia then
            cutscene:setSpeaker("koakuma")
            cutscene:text("* Hehehe!\n[wait:5]Isn\'t that the Terror Gang?", "smile_left")
        
            local x = event.x + event.width / 2 + 10
            local y = event.y + event.height * 0.75
            local cx, cy, data = cutscene:getMarker("camera")

            cutscene:detachFollowers()
            cutscene:detachCamera()
            cutscene:walkTo(kogasa, x + 80, y + 12, 1, "up")
            cutscene:walkTo(seija, x + 20, y + 12, 1, "up")
            cutscene:walkTo(rin, x - 40, y + 12, 1, "up")
            cutscene:wait(1.2)

            cutscene:text("* Girls, [wait:5]hurry up and run while you still have the chance!", "smile_right")
            cutscene:text("* Ahead, [wait:5]a[color:yellow][wave:2,30,20][sound:ominous]great terror[color:reset][wave:0] awaits you!", "smile_left")
            cutscene:text("* Koakuma,\n[wait:5]what are you up to this time?!", "angry", "rin")
            cutscene:text("* Hehehe!", "smile_left")
            cutscene:text("* I\'m merely giving you a warning!", "smile_right")
            cutscene:text("* I\'m so scared that I can\'t even go back to the Scarlet Mansion!", "neutral")
            cutscene:text("* Wh... [wait:5]What the heck is that!", "neutral", "seija")

            cutscene:walkTo(kogasa, x + 240, y - 20, 2, "right")
            cutscene:walkTo(seija, x + 180, y - 20, 2, "right")
            cutscene:walkTo(rin, x + 120, y - 20, 2, "right")
            cutscene:panToSpeed(cx, cy)
            cutscene:wait(4)

            cutscene:text("* Oh hey, little guy!", "smile", "rin")
            cutscene:text("* You\'re afraid of this thing?", "neutral", "seija")
            cutscene:text("* Wow! [wait:5]Amanojaku!\nYou\'re not scared at all?", "excited")
            cutscene:text("* Why would I be scared?", "neutral", "seija")
            cutscene:text("* What can she do?\n[wait:5]Jump up and bite your face?", "neutral", "seija")
            cutscene:text("* Well... [wait:5]usually...", "afraid")

            local rx = rumia.x
            cutscene:walkTo(rumia, rx - 80, rumia.y, 1)
            cutscene:wait(3)
            cutscene:setAnimation(rumia, "attack")

            cutscene:text("* It make whoever holds it unable to suppress their desire to kill?", "explain")

            cutscene:startEncounter("rumia", true, rumia, {on_start = function()
                rumia:setFlag("dont_load", true)
                rumia:remove()
            end})
        
            cutscene:text("* We... we made it?", "neutral", "seija")

            cutscene:wait(cutscene:walkTo(koakuma, rx - 120, koakuma.y, 1))
            cutscene:text("* Wow!! [wait:5]I can\'t believe you guys actually\ndealed with it!!", "koakuma")
            cutscene:text("* You guys are heroes!!", "koakuma")
            cutscene:text("* Don\'t have to take that 20-minute detour back to the Mansion anymore!!", "koakuma")
            cutscene:text("* Yeah, yeah, [wait:5]I know I did a pretty good job, right...?", "neutral", "seija")

            cutscene:setSpeaker("rin")
            cutscene:text("* Uh, [wait:5]Seija...?", "angry")
            cutscene:text("* Actually, [wait:5]uh...", "angry")
            cutscene:text("* You didn\'t help out at all just now.", "angry")
            cutscene:text("* Not only that, [wait:5]your attacks actually made things worse.", "angry")
            cutscene:text("* If you had been kind to her from the start...", "angry")
            cutscene:text("* This battle wouldn\'t have happened at all.", "angry")
            cutscene:text("* Huh? [wait:5]Are you serious?", "neutral", "seija")
            cutscene:text("* That thing is a bloodthirsty monster!", "neutral", "seija")
            cutscene:text("* The kind you can\'t stop without giving her a good beating!", "neutral", "seija")
            cutscene:text("* Also, [wait:5]earlier, you scared those fairies...", "angry")
            cutscene:text("* Those fairies are enemies! [wait:5]They only exist to be scared!", "neutral", "seija")
            cutscene:text("* Yeah! [wait:5]She\'s right!!", "koakuma", "koakuma")
            cutscene:text("* And before that, [wait:5]you ate a person\'s Moonlight Grass Onigiri...", "angry")
            cutscene:text("* Onigiri... [wait:10]are my enemy, too.", "neutral", "seija")
            cutscene:text("* ...", "angry")
            cutscene:text("* Seija... [wait:10]whether you like it or not...", "angry")
            cutscene:text("* You are a hero.", "angry")
            cutscene:text("* A hero capable of creating a peaceful future.", "angry")
            cutscene:text("* Can you at least act... [wait:10]like a hero?", "angry")

            cutscene:setSpeaker("seija")
            cutscene:text("* Wow, when you put it that way...", "neutral")
            cutscene:text("* I\'m really a pretty pathetic hero, aren\'t I?", "neutral")
            cutscene:text("* Alright, human.\n[wait:5]I understand.\n[wait:5]I\'ll change myself.", "neutral")

            local seija_y = seija.y + 20
            cutscene:walkTo(seija, seija.x, seija.y + 20, 1, "up", true)
            cutscene:text("* From now on, [wait:5]I\'ll be a hero like a goody two-shoes...", "neutral")

            cutscene:wait(function() return seija_y == seija.y end)
            cutscene:wait(cutscene:walkTo(seija, seija.x + 300, seija.y, 1, "left"))

            cutscene:text("* ...Just kidding!", "neutral")
            cutscene:text("* I'm an Amanojaku! [wait:5]Did you really think I'd change?", "neutral")
            cutscene:text("* You're dead wrong!", "neutral")
            cutscene:text("* Since you want me to be a hero, [wait:5]I\'ll just be a villain instead!", "neutral")
            cutscene:text("* R-Really!?", "koakuma", "koakuma")
            cutscene:text("* You want to team up with me?", "koakuma", "koakuma")
            cutscene:text("* Yeah, [wait:5]to be honest,\n[wait:5]this is exactly where I belong.", "neutral")
            cutscene:text("* Seija, you...", "angry", "rin")
            cutscene:text("* Shut up, creepy woman! [wait:5]Seija is my partner now!", "koakuma", "koakuma")
            cutscene:text("* Hahaha, [wait:5]that\'s right, creepy woman!", "neutral")
            cutscene:text("* We\'ll wear ties embroidered with both of our names!", "koakuma", "koakuma")
            cutscene:text("* Right!", "neutral")
            cutscene:text("* Then we\'ll stay over at each other\'s houses!\n[wait:5]And share secrets!", "koakuma", "koakuma")
            cutscene:text("* Mm, [wait:5]right?", "neutral")
            cutscene:text("* Anyway, [wait:5]uh, [wait:5]guys,\n[wait:5]see you never.", "neutral")
            cutscene:text("* Haha!! [wait:10]But first, [wait:5]you guys have to actually live that long!", "koakuma", "koakuma")

            cutscene:walkTo(koakuma, koakuma.x + 300, koakuma.y, 1)
            cutscene:walkTo(seija, seija.x + 300, seija.y, 1)
            Assets.playSound("ominous")
            cutscene:wait(2)
            koakuma:setFlag("dont_load", true)
            koakuma:remove()
            Game:removePartyMember("seija")
            Game:removeFollower("seija")
            seija:remove()

            cutscene:wait(cutscene:walkTo(rin, rx - 320, rin.y, 2, "left"))
            cutscene:setSpeaker("rin")
            cutscene:text("* Kogasa...", "sad")
            cutscene:text("* Maybe I shouldn\'t have been so strict with her just now.", "sad")
            cutscene:text("* After all, [wait:5]she is an Amanojaku...", "sad")
            cutscene:text("* But, [wait:5]I\'m worried that if Seija is too eager to fight...", "sad")
            cutscene:text("* I\'m afraid she might...", "sad")
            cutscene:text("* Anyway, [wait:5]let\'s just be good to her, [wait:5]okay, Kogasa?", "sad")
            cutscene:text("* I\'m sure Seija will be back very soon.", "sad")

            cutscene:alignFollowers()
            cutscene:attachFollowers()
            cutscene:attachCamera()
        end
    end
}
