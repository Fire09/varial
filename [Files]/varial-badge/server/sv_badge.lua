RegisterServerEvent("varial-police:showBadge", function(pInventoryData)
	local src = source

	local coords = GetEntityCoords(GetPlayerPed(src))
	local players = exports["varial-infinity"]:GetNerbyPlayers(coords, 5)

	for i, v in ipairs(players) do
        TriggerClientEvent("varial-police:showBadge", v, src, pInventoryData)
    end
end)
