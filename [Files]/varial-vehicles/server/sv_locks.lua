RegisterServerEvent('varial-keys:attemptLockSV')
AddEventHandler('varial-keys:attemptLockSV', function(targetVehicle, plate)
    TriggerClientEvent('varial-keys:attemptLock', source, targetVehicle, plate)
end)