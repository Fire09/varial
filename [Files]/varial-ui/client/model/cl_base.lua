-- RegisterNetEvent("varial-ui:client:InitUI")
-- AddEventHandler("varial-ui:client:InitUI", function()
--     print("[varial-ui] Initalize Hud")
--     local toggleData = {
--         health = GetResourceKvpString('healthshow'),
--         armor = GetResourceKvpString('armorshow'),
--         hunger = GetResourceKvpString('hungershow'),
--         thirst = GetResourceKvpString('thirstshow'),
--         stamina = GetResourceKvpString('staminashow'),
--         oxygen = GetResourceKvpString('oxyshow'),
--         stress = GetResourceKvpString('stressshow'),
--         voice = GetResourceKvpString('voiceshow'),
--     }

--     local colorData = {
--         health = GetResourceKvpString('#health'),
--         armor = GetResourceKvpString('#armor'),
--         hunger = GetResourceKvpString('#hunger'),
--         thirst = GetResourceKvpString('#thirst'),
--         stamina = GetResourceKvpString('#stamina'),
--         oxygen = GetResourceKvpString('#oxygen'),
--         stress = GetResourceKvpString('#stress'),
--         voice = GetResourceKvpString('#voice'),
--     }

--     Citizen.Wait(500)
--     SendNUIMessage({
--         action = "initialize",
--         toggledata = toggleData,
--         colordata = colorData,
--     })
    
-- end)

function SetUIFocus(hasKeyboard, hasMouse)
    SetNuiFocus(hasKeyboard, hasMouse)
end
    
exports('SetUIFocus', SetUIFocus)

RegisterNUICallback("varial-ui:closeApp", function(data, cb)
    SetNuiFocus(false, false)
    SetUIFocus(false, false)
    cb({data = {}, meta = {ok = true, message = 'done'}})
end)

RegisterNUICallback("varial-ui:applicationClosed", function(data, cb)
    TriggerEvent("varial-ui:application-closed", data.name, data)
    cb({data = {}, meta = {ok = true, message = 'done'}})
    SetNuiFocus(false, false)
end)

-- SMALL MAP
-- RegisterCommand("varial-ui:small-map", function()
--     SetRadarBigmapEnabled(false, false)
-- end, false)

-- RegisterCommand("testbugui", function()
--     SetNuiFocus(true, true)
--     SetUIFocus(true, true)
-- end)



RegisterCommand("clearanim", function()
    exports["varial-interaction"]:showInteraction("Stopping Animation .")
    Wait(1000)
    exports["varial-interaction"]:showInteraction("Stopping Animation ..")
    Wait(1000)
    exports["varial-interaction"]:showInteraction("Stopping Animation ...")
    Wait(1000)
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedTasks(PlayerPedId())
    exports["varial-interaction"]:showInteraction("Animation Cleared !", "success")
    Wait(1000)
    exports["varial-interaction"]:hideInteraction()
    exports["varial-interaction"]:hideInteraction("success")
end)
