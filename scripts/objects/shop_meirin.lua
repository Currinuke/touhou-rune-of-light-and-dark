--- The "ShopMeirin" object. On interaction, this will play a squeak sound.
---
--- If the player has a "cheesekey", it will open the mousehole.
---@class ShopMeirin : Event
local ShopMeirin, super = Class(Event, "ShopMeirin")

---@param x number
---@param y number
---@param shape EventShape?
function ShopMeirin:init(x, y, shape)
    super.init(self, x, y, shape)

    self.solid = false

    self.layer = WORLD_LAYERS["bottom"]

    if Game:getFlag("mousehole_open") then
        -- If this is already open, set the sprite and make it non-solid
        self:setSprite("objects/mousehole_entry")
        self.solid = false
    end
end

function ShopMeirin:onInteract(player, dir)
    if true then
        -- If this is already open, don't do anything!
        return false
    end

    if Game.inventory:hasItem("cheesekey") then
        -- We have the key! Let's open the door.

        -- First, make this event non-solid, so the player can reach the transition.
        self.solid = false

        -- Set the sprite, so it looks like the door is open.
        self:setSprite("objects/mousehole_entry")

        Assets.playSound("squeak", 1, 0.5)
        Assets.playSound("locker")

        Game:setFlag("mousehole_open", true)

        Game.inventory:removeItem("cheesekey")
        return true
    end

    -- When we interact with this object, play the squeak sound.
    Assets.playSound("squeak")

    -- We've handled an interaction, so return true! This prevents multiple interactions happening at once.
    return true
end

return ShopMeirin
