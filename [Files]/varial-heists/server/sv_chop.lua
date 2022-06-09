RegisterServerEvent("varial-chopshop:vehicle_loot")
AddEventHandler("varial-chopshop:vehicle_loot", function(string)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cashPaymentBad = math.random(250,500)
    local cashPaymentGood = math.random(500,750)
    if string == "tyre" then
        TriggerClientEvent("player:receiveItem", src, "recyclablematerial", math.random(8, 15), false)
    elseif string == "door" then
        TriggerClientEvent("player:receiveItem", src, "recyclablematerial", math.random(8, 15), false)
    elseif string == "remains" then
        local roll = math.random(1, 2)
        if roll == 1 then
            TriggerClientEvent('DoLongHudText', src, 'Well this one was bad wasnt it ...', 2)
            TriggerClientEvent('player:receiveItem', src, 'recyclablematerial', math.random(2, 8))
            local cashPaymentBad = math.random(250,500)
        elseif roll == 2 then
            TriggerClientEvent('DoLongHudText', src, 'Well this was good wasnt it ...', 1)
            TriggerClientEvent('player:receiveItem', src, 'recyclablematerial', math.random(20, 35))
            local cashPaymentBad = math.random(250,500)
        end
    end
end)

RegisterServerEvent('mission:finished')
AddEventHandler('mission:finished', function(money)
    local src = source
    local player = GetPlayerName(src)
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    if money ~= nil then
        user:addMoney(money)
        if money > 1000 then
        sendToDiscord5("Mission Finished Logs", "Player ID: ".. src ..", Steam: ".. player ..",  Just Received $".. money .." From Mission Finished Event.")
        end
    end
end)