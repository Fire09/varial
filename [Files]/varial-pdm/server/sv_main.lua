local repayTime = 168 * 60 -- hours * 60
local timer = ((60 * 1000) * 10) -- 10 minute timer

local carTable = {
	[1] = { ["model"] = "gauntlet", ["baseprice"] = 100000, ["commission"] = 15 }, 
	[2] = { ["model"] = "dubsta3", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "landstalker", ["baseprice"] = 100000, ["commission"] = 15 },
	[4] = { ["model"] = "bobcatxl", ["baseprice"] = 100000, ["commission"] = 15 },
	[5] = { ["model"] = "surfer", ["baseprice"] = 100000, ["commission"] = 15 },
	[6] = { ["model"] = "glendale", ["baseprice"] = 100000, ["commission"] = 15 },
	[7] = { ["model"] = "washington", ["baseprice"] = 100000, ["commission"] = 15 },
}

-- Update car table to server
RegisterServerEvent('carshop:table')
AddEventHandler('carshop:table', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('varial-vehicleshop:returnTable', -1, carTable)
        updateDisplayVehicles()
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('finance:enable')
AddEventHandler('finance:enable', function(plate)
    if plate ~= nil then
        TriggerClientEvent('finance:enableOnClient', -1, plate)
    end
end)

RegisterServerEvent('buy:enable')
AddEventHandler('buy:enable', function(plate)
    if plate ~= nil then
        TriggerClientEvent('buy:enableOnClient', -1, plate)
    end
end)

-- Check if player has enough money
RegisterServerEvent('CheckMoneyForVeh')
AddEventHandler('CheckMoneyForVeh', function(name, model,price,financed)
    local user = exports["varial-base"]:getModule("Player"):GetUser(source)
    local money = tonumber(user:getCash())
    if financed then
        local financedPrice = math.ceil(price / 3)
        if money >= financedPrice then
            user:removeMoney(financedPrice)
            TriggerClientEvent('FinishMoneyCheckForVeh', user.source, name, model, price, financed)
            TriggerClientEvent('menu:veh:purchase', user.source)
            exports["varial-banking"]:UpdateSociety(financedPrice, "car_shop", "add")
        else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
            TriggerClientEvent('carshop:failedpurchase', user.source)
        end
    else
        if money >= price then
            user:removeMoney(price)
            TriggerClientEvent('FinishMoneyCheckForVeh', user.source, name, model, price, financed)
            TriggerClientEvent('menu:veh:purchase', user.source)
            exports["varial-banking"]:UpdateSociety(price, "car_shop", "add")
        else
            TriggerClientEvent('DoLongHudText', user.source, 'You dont have enough money on you!', 2)
            TriggerClientEvent('carshop:failedpurchase', user.source)
        end
    end
end)


-- Add the car to database when completed purchase
RegisterServerEvent('BuyForVeh')
AddEventHandler('BuyForVeh', function(platew, name, vehicle, price, financed)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(source)
    local char = user:getVar("character")
    local player = user:getVar("hexid")
    exports.oxmysql:execute("SELECT * FROM `characters_cars` WHERE license_plate = @license_plate", {['license_plate'] = platew}, function(result)
        if result[1] then
            dbplate = math.random(10000000,99999999)
            TriggerClientEvent("varial-vehicleshop:update:plate", src, dbplate)
        else
            dbplate = platew
        end
        
        if financed then
            local cols = 'owner, cid, license_plate, name, purchase_price, financed, model, vehicle_state, payments_left'
            local val = '@owner, @cid, @license_plate, @name, @buy_price, @financed, @model, @vehicle_state, @payments_left'
            local downPay = math.ceil(price / 4)
            exports.oxmysql:execute('INSERT INTO characters_cars ( '..cols..' ) VALUES ( '..val..' )',{
                ['@owner'] = player,
                ['@cid'] = char.id,
                ['@license_plate'] = dbplate,
                ['@model'] = vehicle,
                ['@name'] = name,
                ['@buy_price'] = price,
                ['@financed'] = price - downPay,
                ['@payments_left'] = 12,
                ['@vehicle_state'] = "Out",
            })

            Citizen.Wait(2500)
            TriggerClientEvent("garges:update:phone")
        else
            exports.oxmysql:execute('INSERT INTO characters_cars (owner, cid, license_plate, name, model, purchase_price, vehicle_state) VALUES (@owner, @cid, @license_plate, @name, @model, @buy_price, @vehicle_state)',{
                ['@owner'] = player,
                ['@cid'] = char.id,
                ['@license_plate'] = dbplate,
                ['@name'] = name,
                ['@model'] = vehicle,
                ['@buy_price'] = price,
                ['@vehicle_state'] = "Out"
            })

            Citizen.Wait(2500)
            TriggerClientEvent("garges:update:phone")
        end
    end)
end)

    
function updateDisplayVehicles()
    for i=1, #carTable do
        exports.oxmysql:execute("UPDATE vehicle_display SET model=@model, commission=@commission, baseprice=@baseprice WHERE ID=@ID",{
            ['@ID'] = i,
            ['@model'] = carTable[i]["model"],
            ['@commission'] = carTable[i]["commission"],
            ['@baseprice'] = carTable[i]["baseprice"]
        })
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        updateDisplayVehicles()
    end
end)


RegisterServerEvent('car:dopayment')
AddEventHandler('car:dopayment', function(plateNumber)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    exports.oxmysql:execute("SELECT * FROM `characters_cars` WHERE license_plate = ?", {plateNumber}, function(data)
        if data[1] then
            local CurrentPayment = math.floor(data[1].financed/data[1].payments_left)
            if user:getBalance() >= CurrentPayment then
                local total_price = data[1].purchase_price
                exports.oxmysql:execute("UPDATE characters_cars SET finance_time = @finance_time, payments_left = @payments_left, financed = @financed WHERE license_plate = @license_plate",{
                    ['@license_plate'] = plateNumber,
                    ['@payments_left'] =  data[1].payments_left  - 1,
                    ['@finance_time'] = repayTime,
                    ['@financed'] =  data[1].financed - CurrentPayment
                })

                user:removeBank(CurrentPayment)
                TriggerEvent("varial:AddToMoneyLog", pSrc, "personal", -CurrentPayment, "withdraw", "N/A", (note ~= "" and note or "Car payment of $"..math.floor(CurrentPayment).." was taken out."))
            else
                TriggerClientEvent("DoLongHudText", pSrc, "You need $"..CurrentPayment.. " in your bank account to afford this car payment!")
            end                
        end
    end)
end)


RegisterServerEvent("varial-vehicleshop:repo")
AddEventHandler("varial-vehicleshop:repo", function(plate)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cid = user:getVar("character").id

    exports.oxmysql:execute("SELECT `license_plate`, `repoed` FROM `characters_cars` WHERE license_plate = ? AND finance_time = ? AND payments_left >= 1", {plate, "0"}, function(data)
        if data[1] then
            exports.oxmysql:execute("UPDATE characters_cars SET repoed = @repoed WHERE license_plate = @license_plate",
                {['license_plate'] = plate,
                ['@repoed'] = "1"
            })
            TriggerClientEvent("varial-vehicleshop:repo:success", src)
            TriggerEvent("paycheck:server:add", src, cid, 500)
        else
            TriggerClientEvent("DoLongHudText", src, "This vehicle is not owned by anyone", 2)
        end
    end)        
  
end)

RegisterServerEvent("varial-vehicleshop:checkrepo")
AddEventHandler("varial-vehicleshop:checkrepo", function(plate)
    if plate == nil then
        return 
    end

    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cid = user:getVar("character").id

    exports.oxmysql:execute("SELECT * FROM `characters_cars` WHERE license_plate = ? and cid = ?", {plate, cid}, function(data)
        if data[1] ~= nil then
            local pVehID = data[1].id
            local pFinace = data[1].finance_time
            if data[1].repoed == tonumber(1) then
                if pFinace >= 2500 then
                    if user:getBalance() >= 5000 then
                        exports.oxmysql:execute("UPDATE characters_cars SET repoed = @repoed WHERE license_plate = @license_plate",{
                            ['license_plate'] = plate,
                            ['repoed'] = "0"
                        })
                        user:removeBank(5000)
                        data = {
                            pVeh = pVehID
                        }
                        TriggerClientEvent("varial-garages:takeout", src, data)
                        TriggerClientEvent("DoLongHudText", src, "Vehicle released behind the building", 1)
                    else
                        TriggerClientEvent("DoLongHudText", src, "You cant afford the release fee of $5000", 2)
                    end
                else
                    TriggerClientEvent("DoLongHudText", src, "You need to make a payment before your car is released", 2)
                end
            else
                TriggerClientEvent("DoLongHudText", src, "This vehicle is not on the list!", 2)
            end
        end
    end)
end)


function updateFinance()
    exports.oxmysql:execute("SELECT * FROM `characters_cars` WHERE finance_time > 0 AND payments_left >= 1", {}, function(result)
        for i=1, #result do
            local financeTimer = result[i].finance_time
            local license_plate = result[i].license_plate
            local newTimer = financeTimer - 10
            if financeTimer ~= nil then
                MySQL.Sync.execute('UPDATE characters_cars SET finance_time = @timer WHERE license_plate = @license_plate', {
                    ['@license_plate'] = license_plate,
                    ['@timer'] = newTimer
                })
            end
        end
    end)
    SetTimeout(timer, updateFinance)
end
SetTimeout(timer, updateFinance)

