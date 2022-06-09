local playerInjury = {}

function GetCharsInjuries(source)
    return playerInjury[source]
end

RegisterServerEvent('varial-hospital:server:SyncInjuries')
AddEventHandler('varial-hospital:server:SyncInjuries', function(data)
    playerInjury[source] = data
end)