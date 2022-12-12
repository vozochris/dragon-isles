--TSU
--PLAYER_LOGIN, PLAYER_REGEN_ENABLED, PLAYER_TARGET_CHANGED, ZONE_CHANGED_AREA_NEW, ZONE_CHANGED, VARIABLES_LOADED, ZONE_CHANGED_NEW_AREA, ZONE CHANGED INDOORS, VIGNETTE_MINIMAP_UPDATED
function(allStates, event, ...)
    if event == "VIGNETTE_MINIMAP_UPDATED" then
        local vignetteGUID = select(1, ...)
        local onMinimap = select(2, ...)
        
        if onMinimap then
            local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
            aura_env.vignettes[vignetteGUID] = vignetteInfo
        else
            aura_env.vignettes[vignetteGUID] = nil
        end
    end
    
    for _, state in pairs(allStates) do
        state.show = false
        state.changed = true
    end
    
    local index = 1
    
    if not aura_env.config["hide_general"] then
        index = aura_env.add_lines(allStates, aura_env.dragon_isles_general, "General", index)
    end
    
    if not aura_env.config["hide_obsidian_citadel"] then
        index = aura_env.add_lines(allStates, aura_env.dragon_isles_obsidian_citadel, "Obsidian Citadel", index)
    end
    
    if not aura_env.config["hide_war_mode"] then
        index = aura_env.add_lines(allStates, aura_env.dragon_isles_war_mode, "War Mode", index)
    end
    
    if not aura_env.config["hide_rares"] then
        local showAllZones = aura_env.config["show_all_zones"]
        local player_zone = C_Map.GetBestMapForUnit("player")
        
        if showAllZones or player_zone == 2022 then
            index = aura_env.add_lines(allStates, aura_env.dragon_isles_the_waking_shores, "The Waking Shores", index, true)
        end
        if showAllZones or player_zone == 2023 then
            index = aura_env.add_lines(allStates, aura_env.dragon_isles_ohnahran_plains, "Ohn'ahran Plains", index, true)
        end
        if showAllZones or player_zone == 2024 then
            index = aura_env.add_lines(allStates, aura_env.dragon_isles_the_azure_span, "The Azure Span", index, true)
        end
        if showAllZones or player_zone == 2025 then
            index = aura_env.add_lines(allStates, aura_env.dragon_isles_thaldraszus, "Thaldraszus", index, true)
        end
    end
    
    if not aura_env.config["hide_quests"] then
        index = aura_env.add_lines(allStates, aura_env.dragon_isles_quests, "Quests", index)
    end
    
    if not aura_env.config["hide_professions"] then
        local prof1, prof2, _, _, _ = GetProfessions()
        local name1 = ""
        local skillLevel1 = 0
        local name2 = ""
        local skillLevel2 = 0
        if (prof1) then
            name1, _, skillLevel1 = GetProfessionInfo(prof1)
        end
        if (prof2) then
            name2, _, skillLevel2 = GetProfessionInfo(prof2)
        end
        
        local function addProfession(name, data)
            local requiredSkill = 25
            if name1 == name and skillLevel1 >= requiredSkill or name2 == name and skillLevel2 >= requiredSkill then
                index = aura_env.add_lines(allStates, data, name, index)
            end
        end
        
        addProfession("Inscription", aura_env.dragon_isles_inscription)
        addProfession("Mining", aura_env.dragon_isles_mining)
        addProfession("Herbalism", aura_env.dragon_isles_herbalism)
        addProfession("Alchemy", aura_env.dragon_isles_alchemy)
        addProfession("Blacksmithing", aura_env.dragon_isles_blacksmithing)
        addProfession("Enchanting", aura_env.dragon_isles_enchanting)
        addProfession("Engineering", aura_env.dragon_isles_engineering)
        addProfession("Jewelcrafting", aura_env.dragon_isles_jewelcrafting)
        addProfession("Leatherworking", aura_env.dragon_isles_leatherworking)
        addProfession("Skinning", aura_env.dragon_isles_skinning)
        addProfession("Tailoring", aura_env.dragon_isles_tailoring)
    end
    
    return true
end

