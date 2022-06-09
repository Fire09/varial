local carTable = { 
	[1] = { ["model"] = "subwrx", ["baseprice"] = 100000, ["commission"] = 15 },
	[2] = { ["model"] = "c7", ["baseprice"] = 100000, ["commission"] = 15 },
	[3] = { ["model"] = "demon", ["baseprice"] = 100000, ["commission"] = 15 },
}
-- Update car table to server
RegisterServerEvent('varial-tuner:CarTabletuner')
AddEventHandler('varial-tuner:CarTabletuner', function(table)
    if table ~= nil then
        carTable = table
        TriggerClientEvent('varial-tuner:ReturntunerTTable', -1, carTable)
        for i=1, #carTable do
            exports.oxmysql:execute("UPDATE vehicle_display_tuner SET model=@model, name=@name, commission=@commission, baseprice=@baseprice WHERE id=@id", {
                ['@id'] = i,
                ['@model'] = table[i]["model"],
                ['@name'] = table[i]["name"],
                ['@commission'] = table[i]["commission"],
                ['@baseprice'] = table[i]["baseprice"]
            })
        end
    end
end)

-- Enables finance for 60 seconds
RegisterServerEvent('varial-tuner:FinaceEnabledSV')
AddEventHandler('varial-tuner:FinaceEnabledSV', function(plate)
    if plate ~= nil then
        TriggerClientEvent('varial-tuner:FinaceEnabledCL', -1, plate)
    end
end)

RegisterServerEvent('varial-tuner:BuyEnabledSV')
AddEventHandler('varial-tuner:BuyEnabledSV', function(plate)
    if plate ~= nil then
        TriggerClientEvent('varial-tuner:BuyEnabledCL', -1, plate)
    end
end)

-- return table
-- TODO (return db table)
RegisterServerEvent('varial-tuner:RequesttunerTTable')
AddEventHandler('varial-tuner:RequesttunerTTable', function()
    local user = source
    exports.oxmysql:execute("SELECT * FROM vehicle_display_tuner", {}, function(display)
        for k,v in pairs(display) do
            carTable[v.id] = v
            v.price = carTable[v.id].baseprice
        end
        TriggerClientEvent('varial-tuner:ReturntunerTTable', user, carTable)
    end)
end)

-- Check if player has enough money
RegisterServerEvent('varial-tuner:ChechMoney')
AddEventHandler('varial-tuner:ChechMoney', function(name, model, price)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local characterId = user:getCurrentCharacter().id
    local cash = user:getCash()
    local plate = GeneratePlate()

    if tonumber(cash) >= price then
        user:removeMoney(price)
        TriggerClientEvent('FinishMoneyCheckForVehtuner', src, name, model, price, plate)
    elseif tonumber(cash) <= price then
        TriggerClientEvent('DoLongHudText', src, "You don't have enough money!", 2)
        TriggerClientEvent('varial-tuner:FailedPurchase', src)
    end
end)

RegisterServerEvent('varial-tuner:BuyVehicle')
AddEventHandler('varial-tuner:BuyVehicle', function(plate, name, vehicle, price, personalvehicle)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local player = user:getVar("hexid")
    local char = user:getVar("character")
    exports.oxmysql:execute('INSERT INTO characters_cars (cid, license_plate, model, data, purchase_price, name, vehicle_state, current_garage) VALUES (@cid, @license_plate, @model, @data, @purchase_price, @name, @vehicle_state, @current_garage)',{
        ['@cid']   = char.id,
        ['@license_plate']  = plate,
        ['@model'] = vehicle,
        ['@data'] = json.encode(personalvehicle),
        ['@name'] = name,
        ['@purchase_price'] = price,
        ['@current_garage'] = "garagec",
        ['@vehicle_state'] = "Out",
    })
end)

function GeneratePlate()
    local plate = math.random(0, 99) .. "" .. GetRandomLetter(3) .. "" .. math.random(0, 999)
    local result = exports.oxmysql:scalarSync('SELECT license_plate FROM characters_cars WHERE license_plate = @license_plate', {['@license_plate'] = plate})
    if result then
        plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    end
    return plate:upper()
end

local NumberCharset = {}
local Charset = {}

for i = 48, 57 do table.insert(NumberCharset, string.char(i)) end
for i = 65, 90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GetRandomLetter(length)
    Citizen.Wait(1)
    math.randomseed(GetGameTimer())
    if length > 0 then
        return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
    else
        return ''
    end
end