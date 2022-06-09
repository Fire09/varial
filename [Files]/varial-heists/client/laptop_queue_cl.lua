local purpleLap = false
local orangeLap = false

--- Blip shit ---
blip = nil

function AddOrangeBlip()
    blip = AddBlipForCoord(1401.37, -1490.43, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 47)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

function AddPurpleBlip()
    blip = AddBlipForCoord(509.93, 3098.93, 6)
    SetBlipSprite(blip, 306)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, 0.7)
    SetBlipColour(blip, 27)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pickup Location")
    EndTextCommandSetBlipName(blip)
end

--- Green Laptop Fleecas ---

RegisterNetEvent('varial-robberies:purpleQueue')
AddEventHandler('varial-robberies:purpleQueue', function()
    if exports["varial-inventory"]:hasEnoughOfItem("greendongle", 1) then
        TriggerEvent('varial-robberies:getPTablet')
    else
        TriggerEvent('DoLongHudText', "I don't give work out for free!", 2)
    end
end)

RegisterNetEvent('varial-robberies:getPTablet')
AddEventHandler('varial-robberies:getPTablet', function()
    Wait(3000)
    TriggerEvent('DoLongHudText', 'Please allow up to 30 Minutes while we get in contact with our dealer!', 1)
    Citizen.Wait(3000)
    purpleLap = true
    TriggerEvent('DoLongHudText', 'Head to the location we marked on your gps to pick up the tablet.', 1)
    AddPurpleBlip()
    SetNewWaypoint(509.93, 3098.93)
    Citizen.Wait(3000)
end)

RegisterNetEvent('varial-robberies:receivePTablet')
AddEventHandler('varial-robberies:receivePTablet', function()
    if purpleLap == true then 
        if exports["varial-inventory"]:hasEnoughOfItem("greendongle", 1) then
            TriggerEvent('inventory:removeItem', 'greendongle', 1)
            FreezeEntityPosition(PlayerPedId(),true)
            local finished = exports["varial-taskbar"]:taskBar(45000,"Waiting for a response...")
            TriggerServerEvent('varial-robberies:removeQueuePurple')
            TriggerEvent('player:receiveItem', 'heistlaptop3', 1)
            FreezeEntityPosition(PlayerPedId(),false)
            purpleLap = false
            RemoveBlip(blip)
            blip = nil
        else
            TriggerEvent('DoLongHudText', 'You owe me something in return!', 2)
        end
    end
end)

RegisterNetEvent("varial-robberies:leavePurpleQueueClient")
AddEventHandler("varial-robberies:leavePurpleQueueClient", function()
    TriggerServerEvent("varial-robberies:leavePurpleQueueServer")
end)
