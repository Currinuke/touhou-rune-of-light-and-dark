local Flandre, super = Class(EnemyBattler)

function Flandre:init()
    super.init(self)
    self.is_flandre = true

    -- Enemy name
    self.name = "Flandre Scarlet"
    -- Sets the actor, which handles the enemy's sprites (see scripts/data/actors/dummy",")
    self:setActor("dummy")

    -- Enemy health
    self.max_health = 3000
    self.health = 3000
    -- Enemy attack (determines bullet damage)
    self.attack = 12
    -- Enemy defense (usually 0)
    self.defense = 5
    -- Enemy reward
    self.money = 0

    -- Mercy given when sparing this enemy before its spareable (20% for basic enemies)
    self.spare_points = 0
    -- self.exit_on_defeat = false
    self.disable_mercy = true
    -- List of possible wave ids, randomly picked each turn
    self.waves = {}

    -- Dialogue randomly displayed in the enemy's speech bubble
    self.dialogue = {
        "..."
    }

    -- Check text (automatically has "ENEMY NAME - " at the start)
    self.check = "AT 4 DF 0\n* Cotton heart and button eye\n* Looks just like a fluffy guy."
    
    self.text = {
        "* The dummy gives you a soft\nsmile.",
        "* The power of fluffy boys is\nin the air.",
        "* Smells like cardboard.",
    }

    self.tired_percentage = 0
    self.low_health_percentage = 0.15
    self.low_health_text = "* Is it because her HP too low,\nor have Flandres finally become tried?"

    self:registerAct("UMB. Spin", "Unstable\nResult")
    self:registerAct("Group Hypnotize", "Hypnotize\nFlandres\n... a bit.", {"seija", "rin"})
end

function Flandre:onAct(battler, name)
    if name == "UMB. Spin" then
        local occur = function()
            local turn = Game.battle.turn_count
            if turn > 9 then
                turn = turn % 9
                if turn == 0 then
                    turn = 9
                end
            end
            local party = Game.battle.party
            if turn == 1 then
                -- Turn1+9*X：芙兰本回合的攻击与防御降低50%
                self.attack = math.floor(self.attack / 2)
                self.defense = math.floor(self.defense / 2)
            elseif turn==2 then
                -- Turn2+9*X：将多多良小伞的HP设为1,其他团队成员HP设为满
                for _, member in ipairs(party) do
                    if member == battler then
                        member.chara.health = 1
                    else
                        member.chara.health = member.chara:getStat("health")
                    end
                end
            elseif turn==3 then
                -- Turn3+9*X：本场战斗中芙兰的攻击间隔与伤害降低33%且给予的无敌时间降低50%
            elseif turn==4 then
                -- Turn4+9*X：召唤一朵雨云,随后立即被芙兰摧毁
            elseif turn==5 then
                -- Turn5+9*X：本场战斗中芙兰受到的伤害翻倍,所有人的TP消耗翻倍
            elseif turn==6 then
                -- Turn6+9*X：治疗随机一位团队成员75HP
                party[math.random(1, #party)]:heal(75)
            elseif turn==7 then
                -- Turn7+9*X：随机交换所有团队成员的最大生命值
            elseif turn==8 then
                -- Turn8+9*X：芙兰本回合攻击伤害翻倍,给予的TP与无敌时间也翻倍
                self.attack = self.attack * 2
            elseif turn==9 then
                -- Turn9+9*X：所有团队成员回复45HP
                for _, member in ipairs(party) do
                    member:heal(45)
                end
            end
        end
        
        occur()
        return "* Kogasa used Umbrella Spin!\n[wait:5][func:occur][sound:ominous]Something occurred!"
    elseif name == "Group Hypnotize" then
        for _, enemy in ipairs(Game.battle.enemies) do
            -- enemy:setTired(true)
        end
        return "* Everyone hypnotized!"
    end

    return super.onAct(self, battler, name)
end

function Flandre:onTurnStart()
    local turn = MathUtils.clamp(Game.battle.turn_count, 1, 7)

    if turn > 1 then
        turn = "final"
    end

    self.wave_override = "flandre/flandre_" .. tostring(turn)
    -- self.defense = self.defense - 1
end

return Flandre