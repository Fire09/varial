RegisterNetEvent('Evan:peds:rogue')
AddEventHandler('Evan:peds:rogue', function(pRoguePeds)
    if pRoguePeds then
        for _, ped in ipairs(pRoguePeds) do
            if ped.owner ~= -1 and ped.owner ~= 0 then
                TriggerClientEvent('Evan:peds:rogue:delete', ped.owner, ped.netId)
            end
        end
    end
end)

RegisterNetEvent('Evan:peds:decor')
AddEventHandler('Evan:peds:decor', function(pServerId, pNetId)
    if pServerId ~= -1 or pServerId ~= 0 then
        TriggerClientEvent('Evan:peds:decor:set', pServerId, pNetId, 2, 'ScriptedPed', true)
    end
end)