local scenes = {}

RegisterNetEvent('varial-scenes:fetch', function()
    local src = source
    TriggerClientEvent('varial-scenes:send', src, scenes)
end)

RegisterNetEvent('varial-scenes:add', function(coords, message, color, distance)
    table.insert(scenes, {
        message = message,
        color = color,
        distance = distance,
        coords = coords
    })
    TriggerClientEvent('varial-scenes:send', -1, scenes)
    TriggerEvent('varial-scenes:log', source, message, coords)
end)

RegisterNetEvent('varial-scenes:delete', function(key)
    table.remove(scenes, key)
    TriggerClientEvent('varial-scenes:send', -1, scenes)
end)


RegisterNetEvent('varial-scenes:log', function(id, text, coords)
    local f, err = io.open('sceneLogging.txt', 'a')
    if not f then return print(err) end
    f:write('Player: ['..id..'] Placed Scene: ['..text..'] At Coords = '..coords..'\n')
    f:close()
end)