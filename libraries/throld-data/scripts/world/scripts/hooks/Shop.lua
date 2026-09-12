local Shop, super = HookSystem.hookScript(Shop)

function Shop:drawPartyBonusInfo(box_y, item, item_options)
    for i = 1, #Game.party do
        -- Turn the index into a 2 wide grid (0-indexed)
        local transformed_x = (i - 1) % 2
        local transformed_y = math.floor((i - 1) / 2)

        -- Transform the grid into coordinates
        local offset_x = transformed_x * 100
        local offset_y = transformed_y * 45
        local offset_x_head = 426
        local offset_x_icon = 470
        local offset_y_icon1 = 127
        local offset_y_icon2 = 147
        local rate_y = 1

        local party_member = Game.party[i]
        local can_equip = party_member:canEquip(item)
        local head_path

        if party_member.id == "seija" then
            --offset_x_head = 470
            --offset_x_icon = 426
            --offset_y_icon1 = 147
            --offset_y_icon2 = 127

            offset_x_head, offset_x_icon = offset_x_icon, offset_x_head
            offset_y_icon1, offset_y_icon2 = offset_y_icon2, offset_y_icon1
            rate_y = -1
        end

        Draw.setColor(COLORS.white)

        if can_equip then
            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head")
            if item.type == "armor" then
                Draw.draw(self.stat_icons["defense_1"], offset_x + offset_x_icon, offset_y + offset_y_icon1 + box_y)
                Draw.draw(self.stat_icons["defense_2"], offset_x + offset_x_icon, offset_y + offset_y_icon2 + box_y)

                for j = 1, 2 do
                    self:drawBonuses(party_member, party_member:getArmor(j), item_options["bonuses"], "defense", offset_x + offset_x_icon + 20, offset_y + offset_y_icon1 + ((j - 1) * 20 * rate_y) + box_y)
                end

            elseif item.type == "weapon" then
                Draw.draw(self.stat_icons["attack"], offset_x + offset_x_icon, offset_y + offset_y_icon1 + box_y)
                Draw.draw(self.stat_icons["magic"], offset_x + offset_x_icon, offset_y + offset_y_icon2 + box_y)

                self:drawBonuses(
                    party_member,
                    party_member:getWeapon(),
                    item_options["bonuses"],
                    "attack",
                    offset_x + offset_x_icon + 20,
                    offset_y + offset_y_icon1 + box_y
                )

                self:drawBonuses(
                    party_member,
                    party_member:getWeapon(),
                    item_options["bonuses"],
                    "magic",
                    offset_x + offset_x_icon + 20,
                    offset_y + offset_y_icon2 + box_y
                )
            end
        else
            head_path = Assets.getTexture(party_member:getHeadIcons() .. "/head_error")
        end

        Draw.draw(head_path, offset_x + offset_x_head, offset_y + 132 + box_y)
    end
end

return Shop