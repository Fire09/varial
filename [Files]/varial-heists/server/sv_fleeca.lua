CnaRob = true

RegisterServerEvent("varial-fleeca:laptop1", function()
    if CnaRob then
        TriggerClientEvent("varial-fleeca:laptopused", source, 1)
    else
        TriggerClientEvent("DoLongHudText", source, "The bank has been robbed recently. Try again soon")
    end
end)

RegisterServerEvent("varial-fleeca:laptop1", function()
    if CnaRob then
        TriggerClientEvent("varial-fleeca:laptopused", source, 2)
    else
        TriggerClientEvent("DoLongHudText", source, "The bank has been robbed recently. Try again soon")
    end
end)

RegisterServerEvent("varial-fleeca:laptop1", function()
    if CnaRob then
        TriggerClientEvent("varial-fleeca:laptopused", source, 3)
    else
        TriggerClientEvent("DoLongHudText", source, "The bank has been robbed recently. Try again soon")
    end
end)

RegisterServerEvent("varial-fleeca:laptop1", function()
    if CnaRob then
        TriggerClientEvent("varial-fleeca:laptopused", source, 4)
    else
        TriggerClientEvent("DoLongHudText", source, "The bank has been robbed recently. Try again soon")
    end
end)

RegisterServerEvent("varial-fleeca:laptop1", function()
    if CnaRob then
        TriggerClientEvent("varial-fleeca:laptopused", source, 5)
    else
        TriggerClientEvent("DoLongHudText", source, "The bank has been robbed recently. Try again soon")
    end
end)

RegisterServerEvent('fleeca:recievemoney')
AddEventHandler('fleeca:recievemoney', function()
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(1000, 1500)
        user:addMoney(cash)
end)



RegisterServerEvent("varial-fleeca:startCoolDown", function()
    CnaRob = false
    CreateThread(function()
        while true do
            Citizen.Wait(Config["Cooldown"])
            CnaRob = true
            TriggerClientEvent("varial-fleeca:resetdoors", source)
        end
    end)
end)