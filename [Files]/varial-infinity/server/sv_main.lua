--[[

    Variables

]]

local PlayersCoords = {}

--[[

    Functions

]]

function GetNerbyPlayers(pCoords, pRange)
    local players = {}

    for k, v in pairs(PlayersCoords) do
        if #(v - pCoords) <= pRange then
            table.insert(players, k)
        end
    end

    return players
end

--[[

    Exports

]]

exports("GetNerbyPlayers", GetNerbyPlayers)

--[[

    Events

]]

RegisterServerEvent("caue:infinity:player:ready")
AddEventHandler("caue:infinity:player:ready", function()
    local src = source

    -- local ped = GetPlayerPed(src)
    -- local coords = GetEntityCoords(ped)

    -- PlayersCoords[src] = coords
end)

RegisterServerEvent("caue:infinity:entity:coords")
AddEventHandler("caue:infinity:entity:coords", function(pNetId)
    local src = source

    local entity = NetworkGetEntityFromNetworkId(pNetId)
    local coords = GetEntityCoords(Gentity)

    TriggerClientEvent("caue:infinity:entity:coords", src, coords)
end)

RegisterServerEvent("caue:infinity:player:remove")
AddEventHandler("caue:infinity:player:remove", function(src)
    PlayersCoords[src] = nil
end)

--[[

    Threads

]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(750)

        local players = GetPlayers()
        for idx, player in ipairs(players) do
            local ped = GetPlayerPed(player)
            local coords = GetEntityCoords(ped)

            PlayersCoords[player] = coords
            TriggerClientEvent("caue:infinity:player:coords", -1, PlayersCoords)
        end
    end
end)