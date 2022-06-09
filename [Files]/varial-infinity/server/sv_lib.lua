RegisterServerEvent('lrp:infinity:player:ready')
AddEventHandler('lrp:infinity:player:ready', function()
    local sexinthetube = GetEntityCoords(GetPlayerPed(source))
    
    TriggerClientEvent('lrp:infinity:player:coords', -1, sexinthetube)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(30000)
        local sexinthetube = GetEntityCoords(source)

        TriggerClientEvent('lrp:infinity:player:coords', -1, sexinthetube)
        TriggerEvent("varial-base:updatecoords", sexinthetube.x, sexinthetube.y, sexinthetube.z)
    end
end)