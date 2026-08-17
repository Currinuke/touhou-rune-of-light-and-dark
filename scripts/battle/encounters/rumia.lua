local Rumia, super = Class(Encounter)

function Rumia:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The axe youkai strikes over."

    -- Battle music ("battle" is rude buster)
    self.music = "checkers"
    -- Enables the purple grid battle background
    self.background = false
    self.hide_world = true

    -- Add the dummy enemy to the encounter
    self:addEnemy("rumia")

    -- skip the YOU WON! text
    self.no_end_message = false
end

return Rumia
