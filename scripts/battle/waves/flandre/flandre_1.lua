local Flandre, super = Class(Wave)

function Flandre:onArenaEnter()
    -- self:setArenaSize(SCREEN_WIDTH, SCREEN_HEIGHT)
    -- self.collider = ColliderGroup(self)
    --[[
    Game.battle.arena.collider.colliders = ColliderGroup(self, {
        LineCollider(self, 0 - 106.5, 0, 142 - 106.5, 142),
        LineCollider(self, 0 + 106.5, 0, 142 + 106.5, 142)
    })]]
    self:setArenaSize(300, 100)
    self:setArenaPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)
    self:setSoulPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)

    self:spawnSprite("arena_double", SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, BATTLE_LAYERS["arena"])
    -- 200 -> 289 ~ 351 -> 62 -> 70
    -- -> 274 ~ 366 -> 92 -> 100
    -- 8*8

    -- self:setArenaShape({120, 0}, {0, 142}, {142, 142}, {142, 0}, {-142, 0}, {-142, 142}, {0, 142})
end

function Flandre:onStart()
    self.time = 10
    Game.battle.arena.color = {0, 0.75, 0, 0}
    Game.battle.arena.alpha = 0
    Game.battle.arena:setBackgroundColor(0, 0, 0, 0)
    self:setSoulPosition(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2)

    self.timer:every(0.5, function()
        local rep = 2
        local num = MathUtils.random()

        if num < 0.4 then
            rep = 3
        end

        for i = 1, rep do
            local x = SCREEN_WIDTH + 20
            local y = MathUtils.random(0, SCREEN_HEIGHT)
            local bullet = self:spawnBullet("flandre/scarletbat1", x, y, "left", 8, 4)
            bullet.remove_offscreen = false
        end
    end)
end

function Flandre:update()
    --self:setArenaRotation(self.arena_rotation + math.rad(0.5))
    super.update(self)
end

return Flandre