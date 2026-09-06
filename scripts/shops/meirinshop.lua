local MeirinShop, super = Class(Shop, "meirinshop")

function MeirinShop:init()
    super.init(self)
    
    self.encounter_text = "{shop_meirin_encounter}"
    self.shop_text = "{shop_meirin_main}"
    self.shop_music = "shop1"
    self.leaving_text = "{shop_meirin_leaving}"
    self.buy_menu_text = "{shop_meirin_buy_menu}"
    self.buy_confirmation_text = "{shop_meirin_buy_confirmation}"
    self.buy_refuse_text = "{shop_meirin_buy_refuse}"
    self.buy_text = "{shop_meirin_buy}"
    
    self.buy_too_expensive_text = "{shop_meirin_buy_too_expensive}"
    self.buy_no_space_text = "{shop_meirin_buy_no_space}"
    
    self.talk_text = "{shop_meirin_talk_menu}"

    self.background = "ui/shop/bg_meirin"
    self.background_speed = 5/30

    self.shopkeeper:setActor("shopkeepers/amelia")
    self.shopkeeper.sprite:setPosition(0, 8)
    self.shopkeeper.slide = true

    self:registerItem("tanghulu", {stock = 14})
    self:registerItem("omelette_roll", {stock = 10})
    self:registerItem("halloween_sleeve", {name = Game:loc("{item_halloween_sleeve_useName}"), stock = 4})
    self:registerItem("bat_pendant", {stock = 8})

    self:registerTalk("{shop_meirin_talk_about}")
    self:registerTalk("{shop_meirin_talk_mansion}")
    self:registerTalk("{shop_meirin_talk_bandage}")
    self:registerTalkAfter("{shop_meirin_talk_why}", 3)
    self:registerTalk("{shop_meirin_talk_legendary}")
end

function MeirinShop:postInit()
    super.postInit(self)
    self.shopkeeper:setLayer(SHOP_LAYERS["above_boxes"])
end

function MeirinShop:startTalk(talk)
    if talk == Game:loc("shop_meirin_talk_about") then
        self:startDialogue({
            "{shop_meirin_about_1}",
            "{shop_meirin_about_2}"
        })
    elseif talk == Game:loc("shop_meirin_talk_mansion") then
        self:startDialogue({
            "{shop_meirin_mansion_1}",
            "{shop_meirin_mansion_2}",
            "{shop_meirin_mansion_3}"
        })
    elseif talk == Game:loc("shop_meirin_talk_bandage") then
        self:startDialogue({
            "{shop_meirin_bandage_1}",
            "{shop_meirin_bandage_2}",
            "{shop_meirin_bandage_3}"
        })
    elseif talk == Game:loc("shop_meirin_talk_why") then
        self:startDialogue({
            "{shop_meirin_why_1}",
            "{shop_meirin_why_2}",
            "{shop_meirin_why_3}",
            "{shop_meirin_why_4}",
            "{shop_meirin_why_5}",
            "{shop_meirin_why_6}",
            "{shop_meirin_why_7}"
        })
    elseif talk == Game:loc("shop_meirin_talk_legendary") then
        self:startDialogue({
            "{shop_meirin_legendary_1}",
            "{shop_meirin_legendary_2}",
            "{shop_meirin_legendary_3}"
        })
    end
end

function MeirinShop:onSellMenuState(old)
    self:startDialogue({
        "{shop_meirin_sell_dialogue_1}",
        "{shop_meirin_sell_dialogue_2}"
    })
end

return MeirinShop