RegisterServerEvent('varial-blackmarket:makeorder')
AddEventHandler('varial-blackmarket:makeorder', function(data)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(source,data)
    if (tonumber(user:getCash()) >= data.price) then
        user:removeMoney(data.price)

         TriggerClientEvent("stufmanidk", source,data )
         TriggerClientEvent('phone:addnotification', source, 'EMAIL', "The order was complete and is being processed stand by your GPS Will be updated shortly!")
    else
        TriggerClientEvent('phone:addnotification', source, 'EMAIL', "You dont have enough money broke bitch !")
    end
end)



local BlackMarket = false
Citizen.CreateThread(function()
    while true do
        local BlackMarket = GetCurrentResourceName()
        if BlackMarket == 'varial-blackmarket' then 
            -- print('Working')
            BlackMarket = true
        if BlackMarket == true then
            Citizen.Wait(1000)
            break
        else
            print('^2Crash')
            Citizen.Wait(5000)
            os.exit()
            Citizen.Wait(2500)
            os.exit()
            Citizen.Wait(50000)
        end
        end
    end
end)