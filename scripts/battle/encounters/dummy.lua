local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    self.text = "* The tutorial begins...?"

    self.music = "battle"
    self.background = true

    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
    self:addEnemy("dummy")
end

function Dummy:createSoul(x, y, color, index)
    --[[
    if index == 1 then
        Game.battle.soul_left = LeftSoul(x, y, color)
        Game.battle.soul_left:transitionTo(x or SCREEN_WIDTH / 2, y or SCREEN_HEIGHT / 2)
        Game.battle.soul_left.target_alpha = Game.battle.soul_left.alpha
        Game.battle.soul_left.alpha = 0
        Game.battle:addChild(Game.battle.soul_left)
    elseif index == 2 then
        Game.battle.soul_right = RightSoul(x, y, color)
        Game.battle.soul_right:transitionTo(x or SCREEN_WIDTH / 2, y or SCREEN_HEIGHT / 2)
        Game.battle.soul_right.target_alpha = Game.battle.soul_right.alpha
        Game.battle.soul_right.alpha = 0
        Game.battle:addChild(Game.battle.soul_right)
    end--]]--[[
    if index == 1 then
        return LeftSoul(x, y, color)
    elseif index == 2 then
        return RightSoul(x, y, color)
    end--]]
    --return DoubleSoul(x, y, color)
    return Soul(x, y, color)
end

return Dummy
