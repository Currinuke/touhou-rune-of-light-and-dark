--[[
function Mod:init()
    Game:registerEvent("squeak", function(data)
        return Squeak(data.x, data.y, {data.width, data.height, data.polygon})
    end)
    Game:registerEvent("meirin", function(data)
        return ShopMeirin(data.x, data.y, { data.width, data.height })
    end)
    print("Loaded " .. self.info.name .. "!")
end]]
return {}