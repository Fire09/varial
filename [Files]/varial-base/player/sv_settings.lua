RegisterServerEvent("varial-base:sv:player_settings_set")
AddEventHandler("varial-base:sv:player_settings_set", function(settingsTable)
    local src = source
    Void.DB:UpdateSettings(src, settingsTable, function(UpdateSettings, err)
            if UpdateSettings then
                -- we are good here.
            end
    end)
end)

RegisterServerEvent("varial-base:sv:player_settings")
AddEventHandler("varial-base:sv:player_settings", function()
    local src = source
    Void.DB:GetSettings(src, function(loadedSettings, err)
        if loadedSettings ~= nil then 
            TriggerClientEvent("varial-base:cl:player_settings", src, loadedSettings) 
        else 
            TriggerClientEvent("varial-base:cl:player_settings",src, nil) 
        end
    end)
end)
