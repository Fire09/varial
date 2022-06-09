
--// Post OP Server Side
RegisterServerEvent('varial-civjobs:post-op-payment')
AddEventHandler('varial-civjobs:post-op-payment', function()
    local src = tonumber(source)
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local payment = math.random(100, 160)
    user:addBank(payment)
    TriggerEvent('varial-base:postopLog', src, payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the delivery and got $'..payment , 1)
end)

--// Water & Power Server Side
RegisterServerEvent('varial-civjobs:water-power-payme')
AddEventHandler('varial-civjobs:water-power-payme', function()
    local src = tonumber(source)
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local payment = math.random(100, 150)
    user:addBank(payment)
    TriggerEvent('varial-base:waterpowerLog', src, payment)
    TriggerClientEvent('DoLongHudText', src, 'You completed the job and got $'..payment , 1)
end)

--// Chicken Server Side

local DISCORD_WEBHOOK5 = ""
local DISCORD_NAME5 = "Chicken Selling Logs"

local STEAM_KEY = "0C007CC382AB06D1D99D9B45EC3924B1"
local DISCORD_IMAGE = "https://i.imgur.com/zviw6oW.png"

PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })

local cachedData = {}

RegisterServerEvent('chickenpayment:pay')
AddEventHandler('chickenpayment:pay', function(money)
    local source = source
    local player = GetPlayerName(source)
    local user = exports["varial-base"]:getModule("Player"):GetUser(source)
    if money ~= nil then
        user:addMoney(money)
	end
end)


function sendToDiscord5(name, message, color)
    local connect = {
      {
        ["color"] = color,
        ["title"] = "**".. name .."**",
        ["description"] = message,
      }
    }
    PerformHttpRequest(DISCORD_WEBHOOK5, function(err, text, headers) end, 'POST', json.encode({username = DISCORD_NAME5, embeds = connect, avatar_url = DISCORD_IMAGE}), { ['Content-Type'] = 'application/json' })
end

--// Fishing Server Side

RegisterServerEvent('varial-fishing:PayPlayer')
AddEventHandler('varial-fishing:PayPlayer', function(money)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    user:addMoney(money)
    TriggerEvent('varial-base:fishingLog', src, money)
end)

--// Garbage Server Side

RegisterNetEvent('varial-garbage:pay')
AddEventHandler('varial-garbage:pay', function(jobStatus)
    local _source = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(_source)
    if jobStatus then
        if user ~= nil then
            local randomMoney = math.random(200, 350)
            user:addMoney(randomMoney)
            TriggerEvent('varial-base:garbageLog', src, randomMoney)
        end
    else
        print("^2[Evan Garbage] Cheater | Caught in 4K Ultra HD ^0",_source, user) 
    end
end)


RegisterNetEvent('varial-garbage:reward')
AddEventHandler('varial-garbage:reward', function(rewardStatus)
    local _source = source
    local matherino = math.random(0, 6)
    if rewardStatus then
        if matherino == 2 then
            TriggerClientEvent('player:receiveItem', _source, 'plastic', math.random(3,9))
            TriggerClientEvent('player:receiveItem', _source, 'rubber', math.random(3,9))
        end
    else
        print("^2[Evan Garbage] Cheater | Caught in 4K Ultra HD ^0") 
    end
end)



--// Hunting Server Side

RegisterServerEvent('varial-hunting:skinReward')
AddEventHandler('varial-hunting:skinReward', function()
  local _source = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(source)
  local randomAmount = math.random(1,30)
  if randomAmount > 1 and randomAmount < 15 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass1', 1)
  elseif randomAmount > 15 and randomAmount < 23 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass2', 1)
  elseif randomAmount > 23 and randomAmount < 29 then
    TriggerClientEvent('player:receiveItem', _source, 'huntingcarcass3', 1)
  else 
    TriggerClientEvent('player:receiveItem', _source, "huntingcarcass4", 1)
  end
end)

RegisterServerEvent('varial-hunting:removeBait')
AddEventHandler('varial-hunting:removeBait', function()
  local _source = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(source)
  TriggerClientEvent('inventory:removeItem', _source, "huntingbait", 1)
end)

RegisterServerEvent('complete:job')
AddEventHandler('complete:job', function(totalCash)
  local _source = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(source)
  user:addMoney(totalCash)
  TriggerEvent('varial-base:huntingLog', _source, totalCash)
end)

--// Rentals Server Side

RegisterServerEvent('varial-rentals:attemptPurchase')
AddEventHandler('varial-rentals:attemptPurchase', function(car)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    if car == "bison" then
        if user:getCash() >= 500 then
            user:removeMoney(500)
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "futo" then
        if user:getCash() >= 450 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(450)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "buffalo" then
        if user:getCash() >= 750 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(750)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "jackal" then
        if user:getCash() >= 625 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(625)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "sultan" then
        if user:getCash() >= 1000 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(1000)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "youga" then
        if user:getCash() >= 400 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(400)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    elseif car == "faggio" then
        if user:getCash() >= 350 then
            TriggerClientEvent('varial-rentals:vehiclespawn', source, car)
            user:removeMoney(350)
        else
            TriggerClientEvent('varial-rentals:attemptvehiclespawnfail', source)
        end
    end
end)

-- Diving Job

RegisterServerEvent('varial-scuba:checkAndTakeDepo')
AddEventHandler('varial-scuba:checkAndTakeDepo', function()
local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
if user:getCash() >= 400 then
    TriggerClientEvent('getDiveingjob',src)
    user:removeMoney(400)
else
    TriggerClientEvent('DoShortHudText',src, 'Not enough you need 400 $!',2)
    return end
end)

-- RegisterServerEvent('varial-scuba:returnDepo')
-- AddEventHandler('varial-scuba:returnDepo', function()
-- local src = source
-- local user = exports["varial-base"]:getModule("Player"):GetUser(src)
--     user:addMoney(200)
-- end)


RegisterServerEvent('varial-scuba:findTreasure')
AddEventHandler('varial-scuba:findTreasure', function()
local source = source
    local roll = math.random(1,8)
    print(roll)
    if roll == 1 then
        TriggerClientEvent('player:receiveItem', source, "corpsefeet", math.random(2,5))
    end
    if roll == 2 then
        TriggerClientEvent('player:receiveItem', source, 'stolen8ctchain', math.random(2,6))
    end
    if roll == 3 then
        TriggerClientEvent('player:receiveItem', source, 'stolen2ctchain', math.random(2,5))
    end
    if roll == 5 then
        TriggerClientEvent('player:receiveItem', source, "starrynight", math.random(1,2))
    end
    if roll == 6 then
        TriggerClientEvent('player:receiveItem', source, "shitlockpick", math.random(1,5))
    end
    if roll == 7 then
        TriggerClientEvent('player:receiveItem', source, "russian", math.random(1,1))
    end
    if roll == 8 then
        TriggerClientEvent('player:receiveItem', source, "ruby", math.random(1,1))
    end
end)

RegisterServerEvent('varial-scuba:paySalvage')
AddEventHandler('varial-scuba:paySalvage', function(money)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    if money ~= nil then
        user:addMoney(tonumber(money))
    end
end)

RegisterServerEvent('varial-scuba:makeGold')
AddEventHandler('varial-scuba:makeGold', function()
 local source = source
 TriggerClientEvent('inventory:removeItem', source, 'umetal', 10)
 TriggerClientEvent("player:receiveItem", source, "goldbar", 1)
end)

-- Carwash

RegisterServerEvent('varial-carwash:checkmoney')
AddEventHandler('varial-carwash:checkmoney', function()
	local src = source
	local player = exports["varial-base"]:getModule("Player"):GetUser(src)
	local costs = 70

	if player:getCash() >= costs then
		TriggerClientEvent("varial-carwash:success", src, costs)
		player:removeMoney(costs)
	else
		moneyleft = costs - player:getCash()
		TriggerClientEvent('varial-carwash:notenoughmoney', src, moneyleft)
	end
end)

-- Fishing

RegisterServerEvent('varial-fishing:attempt_buy_rod')
AddEventHandler('varial-fishing:attempt_buy_rod', function()
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    if user:getCash() >= 100 then
        user:removeMoney(100)
        TriggerClientEvent('player:receiveItem', src, 'fishingrod', 1)
    else
        TriggerClientEvent('DoLongHudText', src, 'You dont got enough money', 2)
    end
end)

--// Farming Server Side

RegisterServerEvent('varial-farming:PayForWheat')
AddEventHandler('varial-farming:PayForWheat', function(money)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    user:addMoney(money)
    TriggerEvent('varial-base:fishingLog', src, money)
end)
