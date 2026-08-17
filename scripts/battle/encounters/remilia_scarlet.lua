local RemiliaScarlet, super = Class(Encounter)

function RemiliaScarlet:init()
    super.init(self)

    -- Text displayed at the bottom of the screen at the start of the encounter
    self.text = "* The Scarlet Devil blocked your way!"

    -- Battle music ("battle" is rude buster)
    self.music = "kingboss"
    -- Enables the purple grid battle background
    self.background = false

    self:addEnemy("remilia_scarlet")
    -- skip the YOU WON! text
    self.no_end_message = true
end

return RemiliaScarlet
