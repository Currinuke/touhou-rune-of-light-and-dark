local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

--- Registers a new ACT for this enemy. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onAct()`](lua://EnemyBattler.onAct) - acts that do not return text there will **softlock** Kristal.
---@param name          string          The name of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
---@return table act    The data of the act, also added to the `acts` table
function EnemyBattler:registerAct(name, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = nil,
        ["name"] = name,
        ["index"] = #self.acts + 1,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = false,
        ["icons"] = icons
    }
    table.insert(self.acts, act)
    return act
end

--- Registers an ACT for this enemy. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onAct()`](lua://EnemyBattler.onAct) - acts that do not return text there will **softlock** Kristal.
---@param name          string          The name of the act
---@param index         number          The index of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
---@return table act    The data of the act, also added to the `acts` table
function EnemyBattler:registerIndexAct(name, index, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = nil,
        ["name"] = name,
        ["index"] = index,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = false,
        ["icons"] = icons
    }
    self.acts[index] = act
    return act
end

--- Registers a new Short ACT for this enemy. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onShortAct()`](lua://EnemyBattler.onShortAct) - acts that do not return text there will **softlock** Kristal.
---@param name          string          The name of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
---@return table act    The data of the act, also added to the `acts` table
function EnemyBattler:registerShortAct(name, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = nil,
        ["name"] = name,
        ["index"] = #self.acts + 1,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = true,
        ["icons"] = icons
    }
    table.insert(self.acts, act)
    return act
end

--- Registers a Short ACT for this enemy. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onShortAct()`](lua://EnemyBattler.onShortAct) - acts that do not return text there will **softlock** Kristal.
---@param name          string          The name of the act
---@param index         number          The index of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
---@return table act    The data of the act, also added to the `acts` table
function EnemyBattler:registerShortIndexAct(name, index, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = nil,
        ["name"] = name,
        ["index"] = index,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = true,
        ["icons"] = icons
    }
    self.acts[index] = act
    return act
end

--- Registers a new ACT for this enemy that is usable by a specific character. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onAct()`](lua://EnemyBattler.onAct) - acts that do not return text there will **softlock** Kristal.
---@param char          string          The id of the character that can use this act
---@param name          string          The name of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
function EnemyBattler:registerActFor(char, name, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = char,
        ["name"] = name,
        ["index"] = #self.acts + 1,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = false,
        ["icons"] = icons
    }
    table.insert(self.acts, act)
end

--- Registers an ACT for this enemy that is usable by a specific character. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onAct()`](lua://EnemyBattler.onAct) - acts that do not return text there will **softlock** Kristal.
---@param char          string          The id of the character that can use this act
---@param name          string          The name of the act
---@param index         number          The index of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
function EnemyBattler:registerIndexActFor(char, name, index, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = char,
        ["name"] = name,
        ["index"] = index,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = false,
        ["icons"] = icons
    }
    self.acts[index] = act
end

--- Registers a new Short ACT for this enemy, usable by a specific character. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onShortAct()`](lua://EnemyBattler.onShortAct) - acts that do not return text there will **softlock** Kristal.
---@param char          string          The id of the character that can use this act
---@param name          string          The name of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
function EnemyBattler:registerShortActFor(char, name, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = char,
        ["name"] = name,
        ["index"] = #self.acts + 1,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = true,
        ["icons"] = icons
    }
    table.insert(self.acts, act)
end

--- Registers a Short ACT for this enemy, usable by a specific character. This function is best called in [`EnemyBattler:init()`](lua://EnemyBattler.init) for most acts, unless they only appear under specific conditions. \
--- What happens when this act is used is controlled by [`EnemyBattler:onShortAct()`](lua://EnemyBattler.onShortAct) - acts that do not return text there will **softlock** Kristal.
---@param char          string          The id of the character that can use this act
---@param name          string          The name of the act
---@param index         number          The index of the act
---@param description?  string          The short description of the act that appears in the menu
---@param party?        string[]|string A list of party member ids required to use this act. Alternatively, the keyword `"all"` can be used to insert the entire current party
---@param tp?           number          An amount of TP required to use this act
---@param highlight?    Battler[]       A list of battlers that will be highlighted when the act is used, overriding default highlighting logic
---@param icons?        string[]        A list of texture paths to icons that will display next to the name of this act (party member heads are drawn automatically as required)
function EnemyBattler:registerShortIndexActFor(char, name, index, description, party, tp, highlight, icons)
    if type(party) == "string" then
        if party == "all" then
            party = {}
            if Game.battle ~= nil then
                for _, battler in ipairs(Game.battle.party) do
                    table.insert(party, battler.chara.id)
                end
            else
                for _, chara in ipairs(Game.party) do
                    table.insert(party, chara.id)
                end
            end
        else
            party = { party }
        end
    end
    local act = {
        ["character"] = char,
        ["name"] = name,
        ["index"] = index,
        ["description"] = description,
        ["party"] = party,
        ["tp"] = tp or 0,
        ["highlight"] = highlight,
        ["short"] = true,
        ["icons"] = icons
    }
    self.acts[index] = act
end

--- *(Override)* Called when an ACT (including X-Acts, excluding short acts, see [`EnemyBattler:onShortAct()`](lua://EnemyBattler.onShortAct)) is used on this enemy - This function should be overriden to define behaviour for every act \
--- *By default, manages the `"Check"` act - call `super.onAct(self, battler, name, index)` in any override to ensure Check is still handled* \
--- *Acts will **softlock** Kristal if a string value or table is not returned by this function when they are used*
---@param battler   PartyBattler
---@param name      string
---@param index     number
---@return string[]|string? text
function EnemyBattler:onAct(battler, name, index)
    if name == Game:loc("act_check") or name == "Check" then
        self:onCheck(battler)
        local _text = self:getCheckText(battler)
        -- 还原原动画“小伞查看了敌人！”
        local _check = Game:loc("act_check_message", {
            charaName = battler.chara:getName()
        })
        if type(_text) == "table" then
            table.insert(_text, 1, _check)
            return _text
        else
            return {_check, _text}
        end
    end
end

--- Retrieves the data of an act on this enemy by its `index`
---@param index number
---@return table?
function EnemyBattler:getIndexAct(index)
    return self.acts[index]
end

return EnemyBattler