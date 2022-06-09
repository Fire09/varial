RegisterServerEvent('admin:revivePlayer')
AddEventHandler('admin:revivePlayer', function(target)
	if target ~= nil then
		TriggerClientEvent('admin:revivePlayerClient', target)
		TriggerClientEvent('varial-hospital:client:RemoveBleed', target) 
        TriggerClientEvent('varial-hospital:client:ResetLimbs', target)
	end
end)

RegisterServerEvent('varial-ems:heal')
AddEventHandler('varial-ems:heal', function(target)
	TriggerClientEvent('varial-ems:heal', target) 	
end)

RegisterServerEvent('varial-ems:heal2')
AddEventHandler('varial-ems:heal2', function(target)
	TriggerClientEvent('varial-ems:big', target)
end)