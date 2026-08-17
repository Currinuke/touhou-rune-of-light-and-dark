local ActionBox, super = HookSystem.hookScript(ActionBox)

function ActionBox:init(x, y, index, battler)
    if battler.chara.id ~= "seija" then
        super.init(self, x, y, index, battler) -- 不是正邪就应用原函数
    else
        -- 212 * 44
        -- love.graphics.line(1  , 2, 1,   36)
        -- love.graphics.line(212, 2, 212, 36)

        -- -212,325 -> 0,0
        -- 0,0 -> 213,325

        super.super.init(self, x, y)

        self.selection_siner = 0

        self.index = index
        self.battler = battler

        self.selected_button = 1

        self.revert_to = 40

        self.data_offset = 0

        self.box = ActionBoxDisplay(self)
        self.box.layer = 1
        self:addChild(self.box)

        self.head_offset_x, self.head_offset_y = battler.chara:getHeadIconOffset()

        -- self.head_sprite = Sprite(battler.chara:getHeadIcons().."/"..battler:getHeadIcon(), 13 + self.head_offset_x, 11 + self.head_offset_y)
        -- 34*25
        -- 212 = 13 + 165 + 34
        -- 36 = 11 + 0 + 25
        self.head_sprite = Sprite(battler.chara:getHeadIcons().."/"..battler:getHeadIcon(), 165 + self.head_offset_x, 8 + self.head_offset_y)
        if not self.head_sprite:getTexture() then
            self.head_sprite:setSprite(battler.chara:getHeadIcons().."/head")
        end
        self.force_head_sprite = false

        if battler.chara:getNameSprite() then
            -- self.name_sprite = Sprite(battler.chara:getNameSprite(), 51, 14)
            -- 48*15 51 + 24 36 = 14 + 15 + 7
            self.name_sprite = Sprite(battler.chara:getNameSprite(), 113, 15)
            self.box:addChild(self.name_sprite)
        end

        -- self.hp_sprite = Sprite("ui/hp", 109, 22)
        -- 16*11 36 = 11 + 22 + 3
        self.hp_sprite = Sprite("ui/hp", 87, 11)

        self.box:addChild(self.head_sprite)
        self.box:addChild(self.hp_sprite)

        self:createButtons()
    end
end

function ActionBox:createButtons()
    if self.battler.chara.id ~= "seija" then
        super.createButtons(self) -- 不是正邪就应用原函数
    else
        -- 基于v0.10.0修改
        for _, button in ipairs(self.buttons or {}) do
            button:remove()
        end

        self.buttons = {}
        btn_types = { "defend", "spare", "item", "magic", "act", "fight" }

        if not self.battler.chara:hasAct() then TableUtils.removeValue(btn_types, "act") end
        if not self.battler.chara:hasSpells() then TableUtils.removeValue(btn_types, "magic") end

        for lib_id, _ in Kristal.iterLibraries() do
            btn_types = Kristal.libCall(lib_id, "getActionButtons", self.battler, btn_types) or btn_types
        end
        btn_types = Kristal.modCall("getActionButtons", self.battler, btn_types) or btn_types

        local start_x = (213 / 2) - ((#btn_types - 1) * 35 / 2) - 1

        if (#btn_types <= 5) and Game:getConfig("oldUIPositions") then
            start_x = start_x - 5.5
        end

        for i, btn in ipairs(btn_types) do
            if type(btn) == "string" then
                local button = ActionButton(btn, self.battler, math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
                button.actbox = self
                table.insert(self.buttons, button)
                self:addChild(button)
            elseif type(btn) ~= "boolean" then -- nothing if a boolean value, used to create an empty space
                btn:setPosition(math.floor(start_x + ((i - 1) * 35)) + 0.5, 21)
                btn.battler = self.battler
                btn.actbox = self
                table.insert(self.buttons, btn)
                self:addChild(btn)
            end
            self.selected_button = self.selected_button + 1
            -- 让正邪的初始按钮改成最后一个（攻击）
            -- 别问我为什么这么写，能跑就行
        end
    
        self.selected_button = MathUtils.clamp(self.selected_button, 1, #self:getSelectableButtons())
    end
end

function ActionBox:update()
    if self.battler.chara.id ~= "seija" then
        super.update(self) -- 不是正邪就应用原函数
    else
        
        self.selection_siner = self.selection_siner + 2 * DTMULT

        self:animateBox()

        --[[
        self.head_sprite.y = 11 - self.data_offset + self.head_offset_y
        if self.name_sprite then
            self.name_sprite.y = 14 - self.data_offset
        end
        self.hp_sprite.y = 22 - self.data_offset]]

        self.head_sprite.y = 8 - self.data_offset + self.head_offset_y
        if self.name_sprite then
            self.name_sprite.y = 15 - self.data_offset
        end
        self.hp_sprite.y = 11 - self.data_offset

        if not self.force_head_sprite then
            local current_head = self.battler.chara:getHeadIcons() .. "/" .. self.battler:getHeadIcon()
            if not self.head_sprite:hasSprite(current_head) then
                current_head = self.battler.chara:getHeadIcons() .. "/head"
            end

            if not self.head_sprite:isSprite(current_head) then
                self.head_sprite:setSprite(current_head)
            end
        end

        for i, button in ipairs(self:getSelectableButtons()) do
            if (Game.battle.current_selecting == self.index) then
                button.selectable = true
                button.hovered = (self.selected_button == i)
            else
                button.selectable = false
                button.hovered = false
            end
        end

        super.super.update(self)
    end
end

function ActionBox:draw()
    if self.battler.chara.id ~= "seija" then
        super.draw(self) -- 不是正邪就应用原函数
    else
        self:drawSelectionMatrix()
        self:drawActionBox()

        super.super.draw(self)

        if not self.name_sprite then
            local font = Assets.getFont("name")
            love.graphics.setFont(font)
            Draw.setColor(1, 1, 1, 1)

            local name = self.battler.chara:getName():upper()
            local spacing = 5 - StringUtils.len(name)

            local off = 60
            for i = 1, StringUtils.len(name) do
                local letter = StringUtils.sub(name, i, i)
                love.graphics.print(letter, self.box.x + 51 + off, self.box.y + 14 - self.data_offset - 1)
                off = off + font:getWidth(letter) + spacing
            end
        end
    end
end

return ActionBox