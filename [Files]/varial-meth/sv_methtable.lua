local Close
local closest

RegisterNetEvent('MethTable:new')
AddEventHandler('MethTable:new', function(model, sentCoords)
    print('hi')
    local source = source
    exports.oxmysql:execute("INSERT INTO __methtable (model, x, y, z) VALUES (@model, @x, @y, @z)", { 
        ['model'] = model,
        ['x'] = sentCoords.x, 
        ['y'] = sentCoords.y,
        ['z'] = sentCoords.z,
    }, function()
end)
end) 

RegisterServerEvent('ReceiveMethCoords')
AddEventHandler('ReceiveMethCoords', function()
    exports.oxmysql:execute('SELECT model,x,y,z FROM __methtable', function(data)
        yeshyper = data
        TriggerClientEvent("SpawnMethTable", -1, yeshyper)
    end)
end)