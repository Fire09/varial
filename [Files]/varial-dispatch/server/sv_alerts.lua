RegisterServerEvent("varial-dispatch:teenA")
AddEventHandler("varial-dispatch:teenA",function(targetCoords)
    TriggerClientEvent('varial-dispatch:policealertA', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:teenB")
AddEventHandler("varial-dispatch:teenB",function(targetCoords)
    TriggerClientEvent('varial-dispatch:policealertB', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:teenpanic")
AddEventHandler("varial-dispatch:teenpanic",function(targetCoords)
    TriggerClientEvent('varial-dispatch:panic', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:empanic")
AddEventHandler("varial-dispatch:empanic",function(targetCoords)
    TriggerClientEvent('varial-dispatch:epanic', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:gaexplosion")
AddEventHandler("varial-dispatch:gaexplosion",function(targetCoords)
    TriggerClientEvent('varial-dispatch:gexplosion', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:fourA")
AddEventHandler("varial-dispatch:fourA",function(targetCoords)
    TriggerClientEvent('varial-dispatch:tenForteenA', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:fourB")
AddEventHandler("varial-dispatch:fourB",function(targetCoords)
    TriggerClientEvent('varial-dispatch:tenForteenB', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:downperson")
AddEventHandler("varial-dispatch:downperson",function(targetCoords)
    TriggerClientEvent('varial-dispatch:downalert', -1, targetCoords)
	return
end)

-- RegisterServerEvent("varial-dispatch:assistancen")
-- AddEventHandler("varial-dispatch:assistancen",function(targetCoords)
--     TriggerClientEvent('varial-dispatch:assistance', -1, targetCoords)
-- 	return
-- end)


RegisterServerEvent("varial-dispatch:sveh")
AddEventHandler("varial-dispatch:sveh",function(targetCoords)
    TriggerClientEvent('varial-dispatch:vehiclesteal', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:svCarBoost")
AddEventHandler("varial-dispatch:svCarBoost", function(targetCoords)
    TriggerClientEvent("varial-dispatch:carBoostBlip", -1, targetCoords)
end)

RegisterServerEvent("varial-dispatch:svCarBoostTracker")
AddEventHandler("varial-dispatch:svCarBoostTracker", function(targetCoords)
    TriggerClientEvent("varial-dispatch:carBoostBlipTracker", -1, targetCoords)
end)

RegisterServerEvent("varial-dispatch:shoot")
AddEventHandler("varial-dispatch:shoot",function(targetCoords)
    TriggerClientEvent('varial-dispatch:gunShot', -1, targetCoords)
	return
end)

-- RegisterServerEvent("varial-dispatch:figher")
-- AddEventHandler("varial-dispatch:figher",function(targetCoords)
--     TriggerClientEvent('vrp-outlawalert:combatInProgress', -1, targetCoords)
-- 	return
-- end)

RegisterServerEvent("varial-dispatch:storerob")
AddEventHandler("varial-dispatch:storerob",function(targetCoords)
    TriggerClientEvent('varial-dispatch:storerobbery', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:houserob")
AddEventHandler("varial-dispatch:houserob",function(targetCoords)
    TriggerClientEvent('varial-dispatch:houserobbery2', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:tbank")
AddEventHandler("varial-dispatch:tbank",function(targetCoords)
    TriggerClientEvent('varial-dispatch:banktruck', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:robjew")
AddEventHandler("varial-dispatch:robjew",function()
    TriggerClientEvent('varial-dispatch:jewelrobbey', -1)
	return
end)

RegisterServerEvent("varial-dispatch:bjail")
AddEventHandler("varial-dispatch:bjail",function()
    TriggerClientEvent('varial-dispatch:jewelrobbey', -1)
    return
end)


RegisterServerEvent("varial-dispatch:bankrobberyfuck")
AddEventHandler("varial-dispatch:bankrobberyfuck",function(targetCoords)
    TriggerClientEvent('varial-dispatch:bankrob', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:drugg23")
AddEventHandler("varial-dispatch:drugg23",function(targetCoords)
    TriggerClientEvent('varial-dispatch:drugdealreport', -1, targetCoords)
	return
end)


RegisterServerEvent("varial-dispatch:bobbycat")
AddEventHandler("varial-dispatch:bobbycat",function(targetCoords)
    TriggerClientEvent('varial-dispatch:bobcatreport', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:unauth_plane")
AddEventHandler("varial-dispatch:unauth_plane",function(targetCoords)
    TriggerClientEvent('varial-dispatch:coke_plane', -1, targetCoords)
	return
end)

RegisterServerEvent("varial-dispatch:vaulttt")
AddEventHandler("varial-dispatch:vaulttt",function(targetCoords)
    TriggerClientEvent('varial-dispatch:vaultreport', -1, targetCoords)
	return
end)