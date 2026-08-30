local Dummy, super = Class(Encounter)

function Dummy:init()
    super.init(self)

    self.text = "* The tutorial begins...?"
    self.music = "battle"
    self.background = true

    for i = 1, 2 do
        self:addEnemy("dummy", math.random(400, 600), math.random(20, 260))
    end
end

return Dummy