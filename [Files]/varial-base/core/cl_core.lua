Void.Core.hasLoaded = false


function Void.Core.Initialize(self)
    Citizen.CreateThread(function()
        while true do
            if NetworkIsSessionStarted() then
                TriggerEvent("varial-base:playerSessionStarted")
                TriggerServerEvent("varial-base:playerSessionStarted")
                break
            end
        end
    end)
end
Void.Core:Initialize()

AddEventHandler("varial-base:playerSessionStarted", function()
    while not Void.Core.hasLoaded do
        ---- print"waiting in loop")
        Wait(100)
    end
    ShutdownLoadingScreen()
    Void.SpawnManager:Initialize()
end)

RegisterNetEvent("varial-base:waitForExports")
AddEventHandler("varial-base:waitForExports", function()
    if not Void.Core.ExportsReady then return end

    while true do
        Citizen.Wait(0)
        if exports and exports["varial-base"] then
            TriggerEvent("varial-base:exportsReady")
            return
        end
    end
end)

RegisterNetEvent("customNotification")
AddEventHandler("customNotification", function(msg, length, type)

	TriggerEvent("chatMessage","SYSTEM",4,msg)
end)

RegisterNetEvent("base:disableLoading")
AddEventHandler("base:disableLoading", function()
    -- print"player has spawned ")
    if not Void.Core.hasLoaded then
         Void.Core.hasLoaded = true
    end
end)

Citizen.CreateThread( function()
    TriggerEvent("base:disableLoading")
end)


RegisterNetEvent("paycheck:client:call")
AddEventHandler("paycheck:client:call", function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("paycheck:server:send", cid)
end)

RegisterNetEvent("paycheck:collect:log:handler")
AddEventHandler("paycheck:collect:log:handler", function()
    TriggerServerEvent('paycheck:collect:log')
end)