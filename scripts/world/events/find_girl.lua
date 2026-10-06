local FindGirl, super = Class(Transition, "find_girl")
local _map = "rm_girl"

function FindGirl:init(x, y, shape, properties)
    super.init(self, x, y, shape, properties)

	local find = ((not Game:getFlag("ch1_found_girl", false)) and MathUtils.random() <= 0.5)

	if find then
		self.target.map = _map
	else
		self.target.map = properties.map
	end
end

function FindGirl:onEnter(chara)
	if chara.is_player then
		if chara:isClimbing() then
			-- TODO: this is some kludge to update the normal direction with the climb direction. maybe find a better way
			chara:setFacing(chara.climb_state.direction)
		end

		local x, y = self.target.x, self.target.y
		local facing = self.target.facing
		local marker = self.target.marker

		if self.sound then
			Assets.playSound(self.sound, 1, self.pitch)
		end

		if self.target.shop then
			self.world:shopTransition(
				self.target.shop,
				{
					x = x,
					y = y,
					marker = marker,
					facing = facing,
					map = self.target.map
				}
			)
		elseif self.target.map then
			local callback = function(map)
				if self.exit_sound then
					Assets.playSound(self.exit_sound, 1, self.exit_pitch)
				end
				Game.world.door_delay = self.exit_delay
				Kristal.Console:push("map: " .. tostring(map))
				if self.target.map == _map then
					local seija = Game.world:removeFollower("seija")
            		if seija then seija:remove() end
            		local rin = Game.world:removeFollower("rin")
            		if rin then rin:remove() end
            		local reisen = Game.world:removeFollower("reisen")
            		if reisen then reisen:remove() end
				end
			end

			if marker then
				self.world:mapTransition(self.target.map, marker, facing or chara.facing, callback)
			else
				self.world:mapTransition(self.target.map, x, y, facing or chara.facing, callback)
			end
		end
	end
end

return FindGirl