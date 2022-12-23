--TSU
--PLAYER_LOGIN, PLAYER_REGEN_ENABLED, PLAYER_TARGET_CHANGED, ZONE_CHANGED_AREA_NEW, ZONE_CHANGED, VARIABLES_LOADED, ZONE_CHANGED_NEW_AREA, ZONE CHANGED INDOORS, VIGNETTE_MINIMAP_UPDATED
function(states, event, ...)
    if event == "VIGNETTE_MINIMAP_UPDATED" then
        local vignette_GUID = select(1, ...)
        local on_minimap = select(2, ...)
        
        if on_minimap then
            local vignette_info = C_VignetteInfo.GetVignetteInfo(vignette_GUID)
            aura_env.vignettes[vignette_GUID] = vignette_info
        else
            aura_env.vignettes[vignette_GUID] = nil
        end
    end
    
    for _, state in pairs(states) do
        state.show = false
        state.changed = true
    end
    
    local index = 1
    
    if not aura_env.config["hide_general"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_general, "General", index)
    end
    
    if not aura_env.config["hide_obsidian_citadel"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_obsidian_citadel, "Obsidian Citadel", index)
    end
    
    if not aura_env.config["hide_rares"] then
        local show_all_zones = aura_env.config["show_all_zones"]
        local player_zone = C_Map.GetBestMapForUnit("player")
        
        if show_all_zones or player_zone == 2022 then
            index = aura_env.add_lines(states, aura_env.dragon_isles_the_waking_shores, "The Waking Shores", index, true)
        end
        if show_all_zones or player_zone == 2023 then
            index = aura_env.add_lines(states, aura_env.dragon_isles_ohnahran_plains, "Ohn'ahran Plains", index, true)
        end
        if show_all_zones or player_zone == 2024 then
            index = aura_env.add_lines(states, aura_env.dragon_isles_the_azure_span, "The Azure Span", index, true)
        end
        if show_all_zones or player_zone == 2025 then
            index = aura_env.add_lines(states, aura_env.dragon_isles_thaldraszus, "Thaldraszus", index, true)
        end
    end

    if not aura_env.config["hide_primal_cores"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_primal_cores, "Primal Cores", index)
    end
    
    if not aura_env.config["hide_elementals"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_fire_elementals, "Fire Elementals", index)
        index = aura_env.add_lines(states, aura_env.dragon_isles_water_elementals, "Water Elementals", index)
        index = aura_env.add_lines(states, aura_env.dragon_isles_earth_elementals, "Earth Elementals", index)
        index = aura_env.add_lines(states, aura_env.dragon_isles_air_elementals, "Air Elementals", index)
    end
    
    if not aura_env.config["hide_war_mode"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_war_mode, "War Mode", index)
    end
    
    if not aura_env.config["hide_quests"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_quests, "Quests", index)
    end
    
    if not aura_env.config["hide_professions"] then
        local prof1, prof2, _, _, _ = GetProfessions()
        local name1 = ""
        local skill_level1 = 0
        local name2 = ""
        local skill_level2 = 0
        if (prof1) then
            name1, _, skill_level1 = GetProfessionInfo(prof1)
        end
        if (prof2) then
            name2, _, skill_level2 = GetProfessionInfo(prof2)
        end

        local function add_profession(name, data)
            local required_skill = 25
            if name1 == name and skill_level1 >= required_skill or name2 == name and skill_level2 >= required_skill then
                index = aura_env.add_lines(states, data, name, index)
            end
        end

        add_profession("Inscription", aura_env.dragon_isles_inscription)
        add_profession("Mining", aura_env.dragon_isles_mining)
        add_profession("Herbalism", aura_env.dragon_isles_herbalism)
        add_profession("Alchemy", aura_env.dragon_isles_alchemy)
        add_profession("Blacksmithing", aura_env.dragon_isles_blacksmithing)
        add_profession("Enchanting", aura_env.dragon_isles_enchanting)
        add_profession("Engineering", aura_env.dragon_isles_engineering)
        add_profession("Jewelcrafting", aura_env.dragon_isles_jewelcrafting)
        add_profession("Leatherworking", aura_env.dragon_isles_leatherworking)
        add_profession("Skinning", aura_env.dragon_isles_skinning)
        add_profession("Tailoring", aura_env.dragon_isles_tailoring)
    end

    if not aura_env.config["hide_iskaara_fish"] then
        index = aura_env.add_lines(states, aura_env.dragon_isles_iskaara_fish, "Iskaara Fish", index)
    end
    
    return true
end

