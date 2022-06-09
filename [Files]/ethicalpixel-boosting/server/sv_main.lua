
local CoreName = nil
ESX = nil

if Config['General']["Core"] == "QBCORE" then
    if Config['CoreSettings']["QBCORE"]["Version"] == "new" then
        CoreName = Config['CoreSettings']["QBCORE"]["Export"]
    elseif Config['CoreSettings']["QBCORE"]["Version"] == "old" then
        TriggerEvent(Config['CoreSettings']["QBCORE"]["Trigger"], function(obj) CoreName = obj end)
    end
elseif Config['General']["Core"] == "ESX" then
    TriggerEvent(Config['CoreSettings']["ESX"]["Trigger"], function(obj) ESX = obj end)
end



SQL = function(query, parameters, cb)
    local res = nil
    local IsBusy = true
    if Config['General']["SQLWrapper"] == "mysql-async" then
        if string.find(query, "SELECT") then
            MySQL.Async.fetchAll(query, parameters, function(result)
                if cb then
                    cb(result)
                else
                    res = result
                    IsBusy = false
                end
            end)
        else
            MySQL.Async.execute(query, parameters, function(result)
                if cb then
                    cb(result)
                else
                    res = result
                    IsBusy = false
                end
            end)
        end
    elseif Config['General']["SQLWrapper"] == "oxmysql" then
        exports.oxmysql:execute(query, parameters, function(result)
            if cb then
                cb(result)
            else
                res = result
                IsBusy = false
            end
        end)
    elseif Config['General']["SQLWrapper"] == "ghmattimysql" then
        exports.ghmattimysql:execute(query, parameters, function(result)
            if cb then
                cb(result)
            else
                res = result
                IsBusy = false
            end
        end)
    end
    while IsBusy do
        Citizen.Wait(0)
    end
    return res
end

if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:GetExpireTime', function(source, cb)
        local shit = (os.time() + 6 * 3600)
        cb(shit)
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:GetExpireTime', function(source, cb)

        local shit = (os.time() + 6 * 3600)
        cb(shit)
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:GetExpireTime", function()
        local shit = (os.time() + 6 * 3600)
        return shit
    end)
end


if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:getCurrentBNE', function(source, cb)
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        if pData ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1] == nil then
                SQL('INSERT INTO boosting (citizenid) VALUES (?)',{cid})
                cb({BNE = 0 , background = tostring(Config['Utils']["Laptop"]["DefaultBackground"]) , vin = nil})
            else
                if sql[1].BNE ~= nil then
                    cb({BNE = sql[1].BNE , background = sql[1].background , vin = sql[1].vin})
                else
                    cb({BNE = 0 , background =  tostring(Config['Utils']["Laptop"]["DefaultBackground"]) , vin = nil})
                end
            end
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:getCurrentBNE', function(source, cb)

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier
    
        if xPlayer ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1] == nil then
                SQL('INSERT INTO boosting (citizenid) VALUES (?)',{cid})
                cb(0)
            else
                if sql[1].BNE ~= nil then
                    cb({BNE = sql[1].BNE , background = sql[1].background , vin = sql[1].vin})
                else
                    cb(0)
                end
            end
        end
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:getCurrentBNE", function()
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1] == nil then
                SQL('INSERT INTO boosting (citizenid) VALUES (?)',{cid})
                value = 0
            else
                if sql[1].BNE ~= nil then
                    value = ({BNE = sql[1].BNE , background = sql[1].background})
                else
                    value = 0
                end
            end
        end
        return value
    end)
end

  




RegisterNetEvent("ethicalpixel-boosting:server:setBacgkround")
AddEventHandler("ethicalpixel-boosting:server:setBacgkround" , function(back)
    local src = source
    if Config['General']["Core"] == "QBCORE" then
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        local sql = SQL('UPDATE boosting SET background=@b WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@b'] = back})
        
    elseif Config['General']["Core"] == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier

        if xPlayer ~= nil then
            local sql = SQL('UPDATE boosting SET background=@b WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@b'] = back})
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('UPDATE boosting SET background=@b WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@b'] = back})
        end 
    end
end)


----------------------- EXP SYSTEM ------------------------

RegisterNetEvent("ethicalpixel-boosting:expreward")
AddEventHandler("ethicalpixel-boosting:expreward" , function(class)
    local src = source
    local amount = Config['EXP']["Rewards"][class] 
    if Config['General']["Core"] == "QBCORE" then
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].exp ~= nil then
            local sql = SQL('UPDATE boosting SET exp=@reward WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@reward'] = amount + sql[1].exp})
        end
    elseif Config['General']["Core"] == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].exp ~= nil then
            local sql = SQL('UPDATE boosting SET exp=@reward WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@reward'] = amount + sql[1].exp})
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].exp ~= nil then
            local sql = SQL('UPDATE boosting SET exp=@reward WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@reward'] = amount + sql[1].exp})
        end
    end

  
end)

if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:getplayerexp', function(source, cb)
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        if pData ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].exp ~= nil then
                cb(sql[1].exp)
            else
                cb(0)
            end
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:getplayerexp', function(source, cb)

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier

        if xPlayer ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].exp ~= nil then
                cb(sql[1].exp)
            else
                cb(0)
            end
            
        end
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:getplayerexp", function(amount)
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].exp ~= nil then
                value = sql[1].exp
            else
                value = 0
            end
        end
        return value
    end)   
end

-----------------------



if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:removeBNE', function(source, cb , amount)
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        if pData ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE - amount})
            else
                cb(0)
            end
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:removeBNE', function(source, cb , amount)

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier
    
        if xPlayer ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE - amount})
            else
                cb(0)
            end
            
        end
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:removeBNE", function(amount)
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE - amount})
            else
                value = 0
            end
        
        end
        return value
    end)   
end


if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:addBne', function(source, cb , amount)
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
        if pData ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE + amount})
            else
                cb(0)
            end
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:addBne', function(source, cb , amount)
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier
        local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
        if sql[1].BNE ~= nil then
            local pBNE = sql[1].BNE
            SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE + amount})
        else
            cb(0)
        end
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:addBne", function(amount)
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if sql[1].BNE ~= nil then
                local pBNE = sql[1].BNE
                SQL('UPDATE boosting SET BNE=@bne WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@bne'] = pBNE + amount})
            else
                value = 0
            end
        end
        return value
    end)
end


if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:server:checkVin', function(source, cb , data)
        local src = source
        local pData = CoreName.Functions.GetPlayer(src)
        local cid = pData.PlayerData.citizenid
    
        if pData ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if(sql[1] ~= nil) then
                if(sql[1].vin == 0) then
                    value = true
                    SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                else
                    local d1 = os.date("*t",   os.time())
                    local d2 = os.date("*t", sql[1].vin)
                    local zone_diff = os.difftime(os.time(d1), os.time(d2))
                    if(math.floor(zone_diff  / 86400) >= Config['Utils']["VIN"] ["VinDays"]) then
                        cb(true)
                        SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                    end
                end
            end
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:server:checkVin', function(source, cb , data)

        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.identifier
    
        if xPlayer ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if(sql[1] ~= nil) then
                if(sql[1].vin == 0) then
                    value = true
                    SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                else
                    local d1 = os.date("*t",   os.time())
                    local d2 = os.date("*t", sql[1].vin)
                    local zone_diff = os.difftime(os.time(d1), os.time(d2))
                    if(math.floor(zone_diff  / 86400) >= Config['Utils']["VIN"] ["VinDays"]) then
                        cb(true)
                        SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                    end
                end
            end
        end
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:server:checkVin", function()
        local src = source
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        local cid = user:getCurrentCharacter().id
        if user ~= nil then
            local sql = SQL('SELECT * FROM boosting WHERE citizenid=@citizenid', {['@citizenid'] = cid})
            if(sql[1] ~= nil) then
                if(sql[1].vin == 0) then
                    value = true
                    SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                else
                    local d1 = os.date("*t",   os.time())
                    local d2 = os.date("*t", sql[1].vin)
                    local zone_diff = os.difftime(os.time(d1), os.time(d2))
                    if(math.floor(zone_diff  / 86400) >= Config['Utils']["VIN"] ["VinDays"]) then
                        value = true
                        SQL('UPDATE boosting SET vin=@vin WHERE citizenid=@citizenid', {['@citizenid'] = cid , ['@vin'] = os.time()})
                    end
                end
            end
        end
        return value
    end)
end


if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:GetTimeLeft', function(source, cb , data)
        local shit = 2
        cb(shit)
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:GetTimeLeft', function(source, cb , data)
        local shit = 2
        cb(shit)
    end)
elseif Config['General']["Core"] == "NPBASE" then
    RPC.register("ethicalpixel-boosting:GetTimeLeft", function()
        local shit = 2
        cb(shit)
    end)
end


  

---------------- Cop Blip Thingy ------------------



RegisterServerEvent('ethicalpixel-boosting:alertcops')
AddEventHandler('ethicalpixel-boosting:alertcops', function(cx,cy,cz)
    if Config['General']["Core"] == "QBCORE" then
        for k, v in pairs(CoreName.Functions.GetPlayers()) do
            local Player = CoreName.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                    TriggerClientEvent('ethicalpixel-boosting:setcopblip', Player.PlayerData.source, cx,cy,cz)
                end
            end
        end
    elseif Config['General']["Core"] == "ESX" then
        local src = source
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
            if xPlayer.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:setcopblip', xPlayers[i], cx,cy,cz)
            end
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in pairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:setcopblip', src, cx,cy,cz)
            end
        end
    end
end)









RegisterServerEvent('ethicalpixel-boosting:removeblip')
AddEventHandler('ethicalpixel-boosting:removeblip', function()
    if Config['General']["Core"] == "QBCORE" then
        for k, v in pairs(CoreName.Functions.GetPlayers()) do
            local Player = CoreName.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                    TriggerClientEvent('ethicalpixel-boosting:removecopblip', Player.PlayerData.source)
                end
            end
        end
    elseif Config['General']["Core"] == "ESX" then
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
            if xPlayer.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:removecopblip', xPlayers[i])
            end
        end    
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in ipairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")

            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:removecopblip', src)
            end
        end
    end
end)

RegisterServerEvent('ethicalpixel-boosting:SetBlipTime')
AddEventHandler('ethicalpixel-boosting:SetBlipTime', function()
    if Config['General']["Core"] == "QBCORE" then
        for k, v in pairs(CoreName.Functions.GetPlayers()) do
            local Player = CoreName.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                    TriggerClientEvent('ethicalpixel-boosting:setBlipTime', Player.PlayerData.source)
                end
            end
        end
    elseif Config['General']["Core"] == "ESX" then
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
            if xPlayer.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:setBlipTime', xPlayers[i])
            end
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in ipairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent('ethicalpixel-boosting:setBlipTime', src)
            end
        end  
    end
end)

  


RegisterNetEvent('ethicalpixel-boosting:finished')
AddEventHandler('ethicalpixel-boosting:finished' , function()
    if Config['General']["Core"] == "QBCORE" then
        local src = source
        local ply = CoreName.Functions.GetPlayer(src)                   
        local worthamount = math.random(13000, 17000)
        local info = {
            worth = worthamount
        }
        if Config['Utils']["Rewards"]["Type"] == 'item' then
            ply.Functions.AddItem(Config['Utils']["Rewards"]["RewardItemName"], 1, false, info)
            TriggerClientEvent("inventory:client:ItemBox", src, CoreName.Shared.Items[Config['Utils']["Rewards"]["RewardItemName"]], "add")
        elseif Config['Utils']["Rewards"]["Type"] == 'money' then
            ply.Functions.AddMoney("bank",Config['Utils']["Rewards"]["RewardMoneyAmount"],"boosting-payment")
        end
    elseif Config['General']["Core"] == "ESX" then
        local src = source
        local ply = ESX.GetPlayerFromId(src)
        local worthamount = math.random(13000, 17000)
        local info = {
          worth = worthamount
        }
        if Config['Utils']["Rewards"]["Type"] == 'item' then
            ply.addInventoryItem(Config['Utils']["Rewards"]["RewardItemName"], 1)
        elseif Config['Utils']["Rewards"]["Type"] == 'money' then
            ply.addMoney(Config['Utils']["Rewards"]["RewardMoneyAmount"])
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        local worthamount = math.random(13000, 17000)
        local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(src)
        if Config['Utils']["Rewards"]["Type"] == 'item' then
            TriggerClientEvent('player:receiveItem', src, Config['Utils']["Rewards"]["RewardItemName"], math.random(10,15))
        elseif Config['Utils']["Rewards"]["Type"] == 'money' then
            if Config['Utils']["Rewards"]["RewardAccount"] == 'cash' then
                user:addMoney(Config['Utils']["Rewards"]["RewardMoneyAmount"])
            elseif Config['Utils']["Rewards"]["RewardAccount"] == 'bank' then
                user:addBank(Config['Utils']["Rewards"]["RewardMoneyAmount"])
            end
            TriggerClientEvent("DoLongHudText", src, "You recieved "..Config['Utils']["Rewards"]["RewardMoneyAmount"].."$ in "..Config['Utils']["Rewards"]["RewardAccount"].." - boosting")
        end 
    end
end)



if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateUseableItem("pixellaptop", function(source, item)
        local Player = CoreName.Functions.GetPlayer(source)
    
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent("ethicalpixel-boosting:DisplayUI", source)
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterUsableItem('pixellaptop', function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent("ethicalpixel-boosting:DisplayUI", source)
    end)
end


RegisterNetEvent('ethicalpixel-boosting:usedlaptop')
AddEventHandler('ethicalpixel-boosting:usedlaptop' , function()
    TriggerClientEvent("ethicalpixel-boosting:DisplayUI", source)
end)

RegisterNetEvent('ethicalpixel-boosting:useddisabler')
AddEventHandler('ethicalpixel-boosting:useddisabler' , function()
    TriggerClientEvent("ethicalpixel-boosting:DisablerUsed", source)
end)


if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateUseableItem("disabler", function(source, item)
        local Player = CoreName.Functions.GetPlayer(source)
        if Player.Functions.GetItemByName(item.name) then
            TriggerClientEvent("ethicalpixel-boosting:DisablerUsed", source)
        end
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterUsableItem('disabler', function(source)
        local xPlayer = ESX.GetPlayerFromId(source)
        TriggerClientEvent("ethicalpixel-boosting:DisablerUsed", source)
    end)
end




if Config['General']["Core"] == "QBCORE" then
    CoreName.Functions.CreateCallback('ethicalpixel-boosting:server:GetActivity', function(source, cb)
        local PoliceCount = 0
        for k, v in pairs(CoreName.Functions.GetPlayers()) do
            local Player = CoreName.Functions.GetPlayer(v)
            if Player ~= nil then 
                if (Player.PlayerData.job.name == Config['General']["PoliceJobName"] and Player.PlayerData.job.onduty) then
                    PoliceCount = PoliceCount + 1
                end
            end
        end
        cb(PoliceCount)
    end)
elseif Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:server:GetActivity', function(source, cb)
        local PoliceCount = 0
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
            if xPlayer.job.name == Config['General']["PoliceJobName"] then
                PoliceCount = PoliceCount + 1
            end
        end
        cb(PoliceCount)
    end)
end


if Config['General']["Core"] == "ESX" then
    ESX.RegisterServerCallback('ethicalpixel-boosting:canPickUp', function(source, cb, item)
        local xPlayer = ESX.GetPlayerFromId(source)
        local xItem = xPlayer.getInventoryItem(item)
    
        if xItem.count >= 1 then
            cb(true)
        else
            cb(false)
        end
    end)
end



RegisterNetEvent('ethicalpixel-boosting:server:transfercontract')
AddEventHandler('ethicalpixel-boosting:server:transfercontract' , function(contract, target)
    local src = source
    TriggerClientEvent('ethicalpixel-boosting:AddContract', target, contract, src)
end)




RegisterServerEvent("ethicalpixel-boosting:CallCopsNotify" , function(plate , model , color , place)
    if Config['General']["Core"] == "QBCORE" then
        for k, v in pairs(CoreName.Functions.GetPlayers()) do
            local Player = CoreName.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == Config['General']["PoliceJobName"] then
                    TriggerClientEvent("ethicalpixel-boosting:SendNotify" ,Player.PlayerData.source , {plate = plate , model = model , color = color , place = place})
                end
            end
        end
    elseif Config['General']["Core"] == "ESX" then
        local src = source
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        
            if xPlayer.job.name == Config['General']["PoliceJobName"] then
                TriggerClientEvent("ethicalpixel-boosting:SendNotify" ,xPlayers[i] , {plate = plate , model = model , color = color , place = place})
            end
        end
    elseif Config['General']["Core"] == "NPBASE" then
        local src = source
        for _, player in pairs(GetPlayers()) do
            local user = exports[Config['CoreSettings']["NPBASE"]["Name"]]:getModule("Player"):GetUser(tonumber(player))
            local job = user:getVar("job")
    
            if job == Config['General']["PoliceJobName"] then
                TriggerClientEvent("ethicalpixel-boosting:SendNotify" ,src , {plate = plate , model = model , color = color , place = place})
            end
        end
    end
end)

