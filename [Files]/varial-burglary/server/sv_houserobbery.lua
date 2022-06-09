local robbableItems = {
    [1] = {chance = 3, id = 0, quantity = math.random(300, 500)}, -- really common
    [2] = {chance = 3, id = 'recyclablematerial', quantity = math.random(1, 8)}, -- rare
    [3] = {chance = 5, id = 'rolexwatch', quantity = math.random(1, 2)},
    [4] = {chance = 4, id = 'stolen2ctchain', quantity = math.random(1, 2)},
    [5] = {chance = 5, id = 'stolenBrokenGoods', quantity = math.random(1, 2)},
    [6] = {chance = 5, id = 'stolens8', quantity = math.random(1, 2)},
    [7] = {chance = 5, id = 'stolenraybans', quantity = math.random(1, 2)},
    [8] = {chance = 5, id = 'stolenpsp', quantity = math.random(1, 2)},
    [9] = {chance = 5, id = 'stolencasiowatch', quantity = math.random(1, 2)},
    [10] = {chance = 10, id = 'stolen10ctchain', quantity = math.random(1, 2)},
    [11] = {chance = 10, id = 'rolexwatch', quantity = math.random(1, 2)},
    [12] = {chance = 10, id = 'registerkey', quantity = math.random(1, 1)},
    [13] = {chance = 5, id = 'cleaninggoods', quantity = math.random(1, 2)},
    [14] = {chance = 7, id = 'maleseed', quantity = math.random(1, 2)},
    [15] = {chance = 7, id = 'femaleseed', quantity = math.random(1, 2)},
}

RegisterServerEvent('houseRobberies:removeLockpick')
AddEventHandler('houseRobberies:removeLockpick', function()
    local src = tonumber(source)
    TriggerClientEvent('inventory:removeItem', src, 'lockpick', 1)
    TriggerClientEvent('DoLongHudText', src, 'The lockpick bent out of shape!', 2)
end)

RegisterServerEvent('houseRobberies:giveMoney')
AddEventHandler('houseRobberies:giveMoney', function()
    local src = tonumber(source)
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cash = math.random(50, 100)
    user:addMoney(cash)
    TriggerClientEvent('DoLongHudText', src, 'You found $'..cash, 1)
end)

RegisterServerEvent('houseRobberies:searchItem')
AddEventHandler('houseRobberies:searchItem', function()
 local src = tonumber(source)
 local cash = math.random(50, 100)
 local item = {}
 local gotID = {}
 local mathfunc = math.random(130)
 local user = exports["varial-base"]:getModule("Player"):GetUser(src)

 for i=1, math.random(1, 2) do
  item = robbableItems[math.random(1, #robbableItems)]
  if math.random(1, 14) >= item.chance then
    if tonumber(item.id) == 0 and not gotID[item.id] then
        gotID[item.id] = true
        user:addMoney(cash)
        TriggerClientEvent('DoLongHudText', src, 'You found $'.. cash, 1)
      elseif not gotID[item.id] then
        gotID[item.id] = true
        if mathfunc < 25 then
          TriggerEvent("player:receiveItem","registerkey",1)
        end
        TriggerClientEvent('player:receiveItem', src, item.id, item.quantity)
        TriggerClientEvent('DoLongHudText', src, 'Item Added!', 1)
      end
    else
      TriggerClientEvent('DoLongHudText', src, 'You found nothing!', 2)
    end
  end
end)
