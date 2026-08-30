local Meirin, super = Class(Shop, "meirin")

function Meirin:init()
    super.init(self)
    
    self.encounter_text = "* Welcome to Master Hong\'s Grocery.\n[wait:5]* How can I help you?"
    self.shop_text = "* Thanks for visiting my little old place."
    self.shop_music = "shop1"
    self.leaving_text = "* Come back any time!"
    self.buy_menu_text = "Just buy anything you want."
    self.buy_confirmation_text = "Buy it for\n%s ?"
    self.buy_refuse_text = "Just buy anything you want."
    self.buy_text = "Thank you for shopping!"
    
    self.buy_too_expensive_text = "Sorry, no discount."
    self.buy_no_space_text = "You're\ncarrying\ntoo much."
    
    self.talk_text = "Feel free to ask anything."

    self.background = "ui/shop/bg_meirin"
    self.background_speed = 5/30

    self.shopkeeper:setActor("shopkeepers/amelia")
    self.shopkeeper.sprite:setPosition(0, 8)
    self.shopkeeper.slide = true

    self:registerItem("tanghulu", {stock = 14})
    self:registerItem("omelette_roll", {stock = 10})
    self:registerItem("halloween_sleeve", {name = Game:loc("{item_halloween_sleeve_useName}"), stock = 4})
    self:registerItem("bat_pendant", {stock = 8})

    self:registerTalk("About Yourself")
    self:registerTalk("Scarlet Devil Mansion")
    self:registerTalk("Bandage on the head...")
    self:registerTalkAfter("Why not hate her?", 3)
    self:registerTalk("We are the chosen ones")
end

function Meirin:postInit()
    super.postInit(self)
    self.shopkeeper:setLayer(SHOP_LAYERS["above_boxes"])
end

function Meirin:startTalk(talk)
    if talk == "About Yourself" then
        self:startDialogue({
            "[emote:idle]* Me?[wait:5] My name\'s Hong Meirin,\n[wait:5]the gatekeeper at\nScarlet Devil Mansion.",
            "[emote:left]* At least I was one.\n[wait:5]* Now I\'m just a nameless youkai running a small shop."
        })
    elseif talk == "Scarlet Devil Mansion" then
        self:startDialogue({
            "[emote:idle]* The Scarlet Devil Mansion, the residence of Lady Remilia Scarlet.\n[wait:5]* It\'s also where I used to work.",
            "[emote:idle]* Now it has become a heavily fortified castle,\n[wait:5]whose danger level has gone up by about 70% higher than before.",
            "[emote:idle]* As the former gatekeeper,\n[wait:5]I feel deeply sorry about that.\n[wait:5]* After all, you\'ll never see those fairies playing at the Mansion\'s gate again."
        })
    elseif talk == "Bandage on the head..." then
        self:startDialogue({
            "[emote:left]* Are you talking about the bandages wrapped around my head?\n[wait:5]* Those were pierced through by Lady Remilia Scarlet herself.",
            "[emote:idle]* If I weren\'t so resilient, I\'d have been dead for good.",
            "[emote:idle]* But even so, I won\'t hate Lady Remilia anyway."
        })
    elseif talk == "Why not hate her?" then
        self:startDialogue({
            "[emote:left]* To say there\'s none at all would be a lie. But I know Lady Remilia wasn\'t always like that.\n[wait:5]* And this is certainly not her fault.",
            "[emote:left]* A while ago, [wait:5]something unusual suddenly occurred inside the Mansion...\n[wait:10]* A dark fountain appeared.",
            "* Lady Patchouli was drawn to it and decided to keep it for study.",
            "* But as time went on, [wait:5]everyone in the Mansion started acting strangely.\n[wait:5]* Even I, who usually live outside, was somewhat affected.",
            "* Just as I was heading to the grand library to ask Lady Patchouli to stop her research and explain the effects, Lady Remilia stopped me.",
            "* After an argument, [wait:5]she summoned Gungnir and pierced my head right through...\n[wait:10][emote:idle]* Sorry, I got a bit off track, didn\'t I?",
            "* Anyway, [wait:5]Lady Remilia isn\'t bad by nature.\n[wait:5]* She only became this way because of the influence of that so-called dark fountain."
        })
    elseif talk == "We are the chosen ones" then
        self:startDialogue({
            "[emote:happy]* So that rumor is true, huh?\n[wait:5]* You guys do seem to have some heroic streak.",
            "[emote:idle]* Sorry, but the only help I can offer is to sell you some stuff that could be useful.",
            "* And I can\'t give you a discount either.\n[wait:5]* I've got to make a living myself, you know?"
        })
    end
end

function Meirin:onSellMenuState(old)
    self:startDialogue({
        "[emote:idle]* Huh?\n[wait:5]You have something to sell me?",
        "[emote:left]* Sorry, but here\'s no scrapyard.\n[wait:5]* I\'m trying to make a living by stuff-selling,\nnot junk-buying."
    })
end

return Meirin
