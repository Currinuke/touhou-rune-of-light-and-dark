local BattleBackground, super = HookSystem.hookScript(BattleBackground)

function BattleBackground:update()
    super.super.update(self)

    self.position = self.position + self.move_speed * DTMULT

    if self.position >= 36 then
        self.position = self.position - 36
    end

    if not self.fading_out then
        self.alpha = MathUtils.approach(self.alpha, 1, 0.1 * DTMULT)
    else
        self.alpha = MathUtils.approach(self.alpha, 0, 0.1 * DTMULT)

        if self.alpha <= 0 then
            self:remove()
        end
    end
end

function BattleBackground:drawBackground()
    Draw.setColor(0, 0, 0, self.alpha)
    love.graphics.rectangle("fill", -10, -10, SCREEN_WIDTH + 20, SCREEN_HEIGHT + 20)

    local background1 = Assets.getTexture("ui/battle/background1")
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background1, true, true)

    local background2 = Assets.getTexture("ui/battle/background2")
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background2, true, true, 0, MathUtils.round(-36 + self.position))

    local background3 = Assets.getTexture("ui/battle/background3")
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background3, true, true, 0, MathUtils.round(-36 - self.position))
end

return BattleBackground
