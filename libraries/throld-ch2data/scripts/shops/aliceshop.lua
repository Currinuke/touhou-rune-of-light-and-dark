local AliceShop, super = Class(Shop, "aliceshop")

function AliceShop:init()
    super.init(self)

    self.encounter_text = "{shop_alice_encounter}"
    self.shop_text = "{shop_alice_main}"
    self.shop_music = "hip_shop"
    self.leaving_text = "{shop_alice_leaving}"
    self.buy_menu_text = "{shop_alice_buy_menu}"
    self.buy_confirmation_text = "{shop_alice_buy_confirmation}"
    self.buy_refuse_text = "{shop_alice_buy_refuse}"
    self.buy_text = "{shop_alice_buy}"

    self.buy_too_expensive_text = "{shop_alice_buy_too_expensive}"
    self.buy_no_space_text = "{shop_alice_buy_no_space}"
    
    self.sell_no_price_text = "{shop_alice_sell_no_price}"
    self.sell_menu_text = "{shop_alice_sell_menu}"
    self.sell_nothing_text = "{shop_alice_sell_nothing}"
    self.sell_confirmation_text = "{shop_alice_sell_confirmation}"
    self.sell_refuse_text = "{shop_alice_sell_refuse}"
    self.sell_text = "{shop_alice_sell}"
    self.sell_everything_text = "{shop_alice_sell_everything}"
    self.sell_no_storage_text = "{shop_alice_sell_no_storage}"

    self.sell_options_text["items"] = "{shop_alice_sell_items_prompt}"
    self.sell_options_text["weapons"] = "{shop_alice_sell_weapons_prompt}"
    self.sell_options_text["armors"] = "{shop_alice_sell_armors_prompt}"
    self.sell_options_text["storage"] = "{shop_alice_sell_storage_prompt}"

    self.talk_text = "{shop_alice_talk_menu}"

    self.background = "ui/shop/bg_meirin"
    self.background_speed = 5/30

    self.shopkeeper:setActor("shopkeepers/amelia")
    self.shopkeeper.sprite:setPosition(0, 8)
    self.shopkeeper.slide = true

    self:registerItem("tanghulu", {stock = 14})
    self:registerItem("omelette_roll", {stock = 10})
    self:registerItem("halloween_sleeve", {name = Game:loc("{item_halloween_sleeve_useName}"), stock = 4})
    self:registerItem("bat_pendant", {stock = 8})

    self:registerTalk("{shop_alice_talk_about}")
    self:registerTalk("{shop_alice_talk_saigyouji}")
    self:registerTalk("{shop_alice_talk_sakuya}")
    self:registerTalkAfter("{shop_alice_talk_sakuya_defeated}", 3)
    self:registerTalk("{shop_alice_talk_station}")
    self:registerTalkAfter("{shop_alice_talk_abandoned}", 4)
end

function AliceShop:postInit()
    super.postInit(self)
    self.shopkeeper:setLayer(SHOP_LAYERS["above_boxes"])
end

function AliceShop:startTalk(talk)
    if talk == Game:loc("shop_alice_talk_about") then
        self:startDialogue({
            "{shop_alice_about_1}",
            "{shop_alice_about_2}",
            "{shop_alice_about_3}",
            "{shop_alice_about_4}",
            "{shop_alice_about_5}",
            "{shop_alice_about_6}"
        })
    elseif talk == Game:loc("shop_alice_talk_saigyouji") then
        self:startDialogue({
            "{shop_alice_saigyouji_1}",
            "{shop_alice_saigyouji_2}",
            "{shop_alice_saigyouji_3}",
            "{shop_alice_saigyouji_4}",
            "{shop_alice_saigyouji_5}",
            "{shop_alice_saigyouji_6}",
            "{shop_alice_saigyouji_7}",
            "{shop_alice_saigyouji_8}",
            "{shop_alice_saigyouji_9}"
        })
    elseif talk == Game:loc("shop_alice_talk_sakuya") then
        self:startDialogue({
            "{shop_alice_sakuya_1}",
            "{shop_alice_sakuya_2}",
            "{shop_alice_sakuya_3}",
            "{shop_alice_sakuya_4}",
            "{shop_alice_sakuya_5}",
            "{shop_alice_sakuya_6}",
            "{shop_alice_sakuya_7}"
        })
    elseif talk == Game:loc("shop_alice_talk_sakuya_defeated") then
        self:startDialogue({
            "{shop_alice_sakuya_defeated_1}",
            "{shop_alice_sakuya_defeated_2}",
            "{shop_alice_sakuya_defeated_3}",
            "{shop_alice_sakuya_defeated_4}",
            "{shop_alice_sakuya_defeated_5}",
            "{shop_alice_sakuya_defeated_6}",
            "{shop_alice_sakuya_defeated_7}"
        })
    elseif talk == Game:loc("shop_alice_talk_station") then
        self:startDialogue({
            "{shop_alice_station_1}",
            "{shop_alice_station_2}",
            "{shop_alice_station_3}"
        })
    elseif talk == Game:loc("shop_alice_talk_abandoned") then
        self:startDialogue({
            "{shop_alice_abandoned_1}",
            "{shop_alice_abandoned_2}",
            "{shop_alice_abandoned_3}",
            "{shop_alice_abandoned_4}",
            "{shop_alice_abandoned_5}",
            "{shop_alice_abandoned_6}",
            "{shop_alice_abandoned_7}",
            "{shop_alice_abandoned_8}",
            "{shop_alice_abandoned_9}",
            "{shop_alice_abandoned_10}",
            "{shop_alice_abandoned_11}"
        })
    end
end

return AliceShop