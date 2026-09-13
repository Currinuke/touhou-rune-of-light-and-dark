local BattleBackground, super = HookSystem.hookScript(BattleBackground)

function BattleBackground:update()
    super.super.update(self)

    self.position = self.position + self.move_speed * DTMULT

    if self.position >= 40 then
        self.position = self.position - 40
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

    local background_up = Assets.getTexture("ui/battle/background_up")
    local background_down = Assets.getTexture("ui/battle/background_down")
    Draw.setColor(1, 1, 1, self.alpha)
    Draw.drawWrapped(background_up, true, true, 0, MathUtils.round(-40 - self.position))
    Draw.drawWrapped(background_down, true, true, 0, MathUtils.round(-40 + self.position))
end

return BattleBackground