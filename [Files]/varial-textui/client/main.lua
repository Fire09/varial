RegisterNetEvent('varial-textui:ShowUI')
AddEventHandler('varial-textui:ShowUI', function(action, text)
	SendNUIMessage({
		action = action,
		text = text,
	})
end)

RegisterNetEvent('varial-textui:HideUI')
AddEventHandler('varial-textui:HideUI', function()
	SendNUIMessage({
		action = 'hide'
	})
end)