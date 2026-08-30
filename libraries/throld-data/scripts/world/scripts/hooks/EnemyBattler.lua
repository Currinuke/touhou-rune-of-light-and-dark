local EnemyBattler, super = HookSystem.hookScript(EnemyBattler)

-- new function
function EnemyBattler:registerActIndex(index, name, description, party, tp, highlight, icons)
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

function EnemyBattler:onAct(battler, name)
    if name == "Check" then
        self:onCheck(battler)
        local _text = self:getCheckText(battler)
        local _check = "* " .. battler.chara.name .. " checked the enemy!"
        if type(_text) == "table" then
            table.insert(_text, 1, _check)
            return _text
        else
            return {_check, _text}
        end
    end
end

function EnemyBattler:getCheckText(battler)
    if type(self.check) == "table" then
        local tbl = {}
        for i, check in ipairs(self.check) do
            if i == 1 then
                table.insert(tbl, "* " .. self.name .. " - " .. check)
            else
                table.insert(tbl, "* " .. check)
            end
        end
        return tbl
    else
        return "* " .. self.name .. " - " .. self.check
    end
end

function EnemyBattler:getIndexAct(id, name)
    for index, act in ipairs(self.acts) do
        if act.name == name then
            return index, act
        end
    end
end

return EnemyBattler