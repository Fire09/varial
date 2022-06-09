--[[

    Variables

]]

local activeCallsByNumber = {}
local activeCallsBySource = {}

--[[

    Events

]]

AddEventHandler("playerDropped", function(pData)
    if activeCallsBySource[pData.source] then
        if activeCallsByNumber[activeCallsBySource[pData.source]].caller == pData.source then
            activeCallsByNumber[activeCallsBySource[pData.source]].caller = nil
        else
            activeCallsByNumber[activeCallsBySource[pData.source]].receiver = nil
        end
        endCall(activeCallsBySource[pData.source])
    end
end)

RegisterNetEvent("varial-newphone:callStart")
AddEventHandler("varial-newphone:callStart", function(pCaller, pTarget)
    local caller = source
    -- local target = exports["caue-base"]:getSidWithPhone(pTarget)
    local targetIdentifier = getIdentifierByPhoneNumber(pTarget)
    TriggerClientEvent("phone:call:dialing", caller, pTarget, target)
    for _, player in ipairs(GetPlayers()) do
        local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(player))
        local char = user:getVar("character")
        if char.id == targetIdentifier then
            if player ~= 0 and not activeCallsBySource[player] then
                TriggerClientEvent("phone:call:receive", player, pCaller, caller)
            end
        end
    end
    
end)

RegisterNetEvent("varial-newphone:callAccept")
AddEventHandler("varial-newphone:callAccept", function(callerID)
    local receiverID = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(callerID))
    local char = user:getVar("character")
    local player = exports["varial-base"]:getModule("Player"):GetUser(tonumber(receiverID))
    local zchar = player:getVar("character")
    local receiverPhoneNumber = getNumberPhone(zchar.id)
    local callerPhoneNumber = getNumberPhone(char.id)

    activeCallsByNumber[receiverPhoneNumber] = {caller = callerID, receiver = receiverID}
    activeCallsBySource[callerID] = receiverPhoneNumber
    activeCallsBySource[receiverID] = receiverPhoneNumber
    TriggerEvent("rp:voice:server:phone:startCall", receiverPhoneNumber, receiverID, callerID)

    TriggerClientEvent("phone:call:in-progress", receiverID, callerPhoneNumber, receiverPhoneNumber)
    TriggerClientEvent("phone:call:in-progress", callerID, receiverPhoneNumber, receiverPhoneNumber)
end)

RegisterNetEvent("varial-newphone:callDecline")
AddEventHandler("varial-newphone:callDecline", function(pCallId)
    local src = source
    TriggerClientEvent("phone:call:inactive", src)

    if pCallId ~= nil and pCallId ~= false and pCallId ~= 0 then
        TriggerClientEvent("phone:call:inactive", pCallId)
    end
end)

RegisterNetEvent("varial-newphone:callEnd")
AddEventHandler("varial-newphone:callEnd", function(pCallId)
    local src = source

    local phoneNumber = pCallId
    local callerID = activeCallsByNumber[phoneNumber]["caller"]
    local receiverID = activeCallsByNumber[phoneNumber]["receiver"]
    TriggerEvent("rp:voice:server:phone:endCall", phoneNumber, callerID, receiverID)

    TriggerClientEvent("phone:call:inactive", callerID)
    TriggerClientEvent("phone:call:inactive", receiverID)

    activeCallsBySource[callerID] = nil
    activeCallsBySource[receiverID] = nil
end)

RPC.register("varial-newphone:getNumber", function(source)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local cid = user:getVar("character").id
    local phoneNumber = MySQL.scalar.await([[
        SELECT phone_number FROM characters
        WHERE id = ?
    ]],{cid})
    return phoneNumber
end)