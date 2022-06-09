Citizen.CreateThread(function()
    TriggerEvent("inv:playerSpawned");
end)

RegisterServerEvent("inventory:check:items")
AddEventHandler("inventory:check:items", function(item_id, creationDate)
    local pData = {
        ["itemid"] = item_id,
        ["creation"] = creationDate
    }

    TriggerEvent("inventory:scan", pData.itemid, pData.creation)
end)

RegisterServerEvent("inventory:del:shit")
AddEventHandler("inventory:del:shit", function(item_id, creationDate)
    exports.oxmysql:execute("DELETE FROM user_inventory2 WHERE item_id = @item_id AND creationDate = @creationDate", {['item_id'] = item_id, ['creationDate'] = creationDate})
end)

RegisterServerEvent('people-search')
AddEventHandler('people-search', function(target)
    local source = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(target)
    local characterId = user:getVar("character").id
	TriggerClientEvent("server-inventory-open", source, "1", 'ply-'.. characterId)
    print('User : '..source.. 'Is attemping to search someone')
end)

RegisterServerEvent('Stealtheybread')
AddEventHandler('Stealtheybread', function(target)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local targetply = exports["varial-base"]:getModule("Player"):GetUser(target)
    if (targetply:getCash() >= 1) then
        user:addMoney(targetply:getCash())
        targetply:removeMoney(targetply:getCash())
    end
end)

RegisterServerEvent("inventory:deg:item", function(pItem)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
    local pInventoryName = "ply-"..char.id

    if not pItem then
        return
    end

    exports.oxmysql:execute('SELECT creationDate FROM user_inventory2 WHERE item_id = ? AND name = ?',{pItem, pInventoryName}, function(data)
        if data[1] ~= nil then
            local pOldCreation = data[1].creationDate
            exports.oxmysql:execute('UPDATE user_inventory2 SET creationDate = @cd WHERE name = @name', {
                ['@name'] = pInventoryName,
                ['@cd'] = pOldCreation - 5000000
            }, function()
            end)
        else
            return                          
        end
    end)
end)