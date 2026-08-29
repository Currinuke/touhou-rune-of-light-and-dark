local character, super = Class(PartyMember, "reisen")

function character:init()
    super.init(self)

    self.name = "Reisen"

    self:setActor("reisen")
    self:setLightActor("noelle_lw")

    self.level = Game.chapter

    if Game.chapter <= 4 then
        self.title = "Snowcaster\nMight be able to\nuse some cool moves."
    elseif Game.chapter >= 5 then
        self.title = "Mistletoe\nThings got\nserious today."
    end

    self.soul_priority = 1
    self.soul_color = {1, 0, 0}

    self.has_act = false
    self.has_spells = true

    self.has_xact = true
    self.xact_name = "U-Action"

    self:addSpell("peerless_patriots_elixir")
    self:addSpell("mind_shaker")
    self:addSpell("evil_undulation")
    self:addSpell("lunatic_gun")
    self:addSpell("lunatic_shot")

    self.health = 170

    self.stats = {
        health = 170,
        attack = 8,
        defense = 0,
        magic = 12
    }

    self.max_stats = {
        health = 250,
        attack = 13,
        magic = 17
    }

    self.stronger_absent = {}

    self.weapon_icon = "ui/menu/equip/ring"

    self:setWeapon("old_ocular")
    self:setArmor(1, "silver_watch")
    if Game.chapter >= 2 then
        self:setArmor(2, "royalpin")
    end

    -- Default light world equipment item IDs (saves current equipment)
    self.lw_weapon_default = "light/pencil"
    self.lw_armor_default = "light/bandage"

    -- Character color (for action box outline and hp bar)
    self.color = {1, 1, 0}
    -- Damage color (for the number when attacking enemies) (defaults to the main color)
    self.dmg_color = {1, 1, 0.3}
    -- Attack bar color (for the target bar used in attack mode) (defaults to the main color)
    self.attack_bar_color = {1, 1, 153/255}
    -- Attack box color (for the attack area in attack mode) (defaults to darkened main color)
    self.attack_box_color = {1, 1, 0}
    -- X-Action color (for the color of X-Action menu items) (defaults to the main color)
    self.xact_color = {1, 1, 0.5}

    -- Head icon in the equip / power menu
    self.menu_icon = "party/noelle/head"
    -- Path to head icons used in battle
    self.head_icons = "party/noelle/icon"
    -- Name sprite (optional)
    self.name_sprite = "party/reisen/name"

    -- Effect shown above enemy after attacking it
    self.attack_sprite = "effects/attack/slap_n"
    -- Sound played when this character attacks
    self.attack_sound = "laz_c"
    -- Pitch of the attack sound
    self.attack_pitch = 1.5

    -- Battle position offset (optional)
    self.battle_offset = {0, 0}
    -- Head icon position offset (optional)
    self.head_icon_offset = nil
    -- Menu icon position offset (optional)
    self.menu_icon_offset = nil

    -- Message shown on gameover (optional)
    self.gameover_message = nil

    -- Character flags (saved to the save file)
    self.flags = {
        ["lunaticguns_used"] = 0,
        ["boldness"] = (Game.chapter >= 2 and 100 or -12),
        ["weird"] = false
    }
end

function character:getTitle()
    if self:checkWeapon("lunatic_ocular") then
        return "LV" .. self:getLevel() .. " " .. "{chara_reisen_title_lunatic}"
    elseif self:getFlag("lunaticguns_used", 0) > 0 then
        return "LV" .. self:getLevel() .. " " .. "{chara_reisen_title_purified}"
    else
        return super.getTitle(self)
    end
end

function character:onLevelUp(level)
    self:increaseStat("health", 4)
    if level % 4 == 0 then
        self:increaseStat("attack", 1)
        self:increaseStat("magic", 1)
    end
end

function character:drawPowerStat(index, x, y, menu)
    if index == 1 then
        local icon = Assets.getTexture("ui/menu/icon/snow")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Purified:", x, y)
        local coldness = MathUtils.clamp(47 + (self:getFlag("lunaticguns_used", 0) * 7), 47, 100)
        coldness = self:getFlag("lunaticguns_used", 0)
        love.graphics.print(coldness, x+130, y)
        return true
    elseif index == 2 then
        local icon = Assets.getTexture("ui/menu/icon/exclamation")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Boldness", x, y, 0, 0.8, 1)
        love.graphics.print(self:getFlag("boldness", -12), x+130, y)
        return true
    elseif index == 3 then
        local icon = Assets.getTexture("ui/menu/icon/fire")
        Draw.draw(icon, x-26, y+6, 0, 2, 2)
        love.graphics.print("Guts:", x, y)
        return true
    end
end

return character
