local Close
local closest

RegisterNetEvent('craftbench:new')
AddEventHandler('craftbench:new', function(model, sentCoords)
    local source = source
    exports.oxmysql:execute("INSERT INTO __craftbench (model, x, y, z) VALUES (@model, @x, @y, @z)", { 
        ['model'] = model,
        ['x'] = sentCoords.x, 
        ['y'] = sentCoords.y,
        ['z'] = sentCoords.z,
    }, function()
end)
end) 

RegisterServerEvent('ReceiveCoords')
AddEventHandler('ReceiveCoords', function()
    exports.oxmysql:execute('SELECT model,x,y,z FROM __craftbench', function(data)
        yessk1c2 = data
        TriggerClientEvent("SpawnCraftBench", -1, yessk1c2)
    end)
end)

