local hmm = vehicleBaseRepairCost

RegisterServerEvent('varial-bennys:attemptPurchase')
AddEventHandler('varial-bennys:attemptPurchase', function(cheap, type, upgradeLevel)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    if type == "repair" then
        if user:getCash() >= hmm then
            user:removeMoney(hmm)
            TriggerClientEvent('varial-bennys:purchaseSuccessful', source)
        else
            TriggerClientEvent('varial-bennys:purchaseFailed', source)
        end
    elseif type == "performance" then
        if user:getCash() >= vehicleCustomisationPrices[type].prices[upgradeLevel] then
            TriggerClientEvent('varial-bennys:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].prices[upgradeLevel])
        else
            TriggerClientEvent('varial-bennys:purchaseFailed', source)
        end
    else
        if user:getCash() >= vehicleCustomisationPrices[type].price then
            TriggerClientEvent('varial-bennys:purchaseSuccessful', source)
            user:removeMoney(vehicleCustomisationPrices[type].price)
        else
            TriggerClientEvent('varial-bennys:purchaseFailed', source)
        end
    end
end)

RegisterServerEvent('varial-bennys:updateRepairCost')
AddEventHandler('varial-bennys:updateRepairCost', function(cost)
    hmm = cost
end)

RegisterServerEvent('varial-bennys:repairciv')
AddEventHandler('varial-bennys:repairciv', function(amount)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    if (user:getCash() >= amount) then
        user:removeMoney(amount)
        TriggerClientEvent("bennys:civ:repair:cl", pSrc)
    end
end)

RegisterNetEvent("caue-bennys:addToInUse")
AddEventHandler("caue-bennys:addToInUse", function(currentBennys)
    local src = source

    inUseBennys[currentBennys] = src
end)