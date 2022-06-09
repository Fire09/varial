Void.Events = Void.Events or {}
Void.Events.Total = 0
Void.Events.Active = {}
local PlayerVars = PlayerVars or {}

function Void.Events.Trigger(self, event, args, callback)
    local id = Void.Events.Total + 1
    Void.Events.Total = id

    id = event .. ":" .. id

    if Void.Events.Active[id] then return end

    Void.Events.Active[id] = {cb = callback}
    
    TriggerServerEvent("varial-events:listenEvent", id, event, args)
end

RegisterNetEvent("varial-events:listenEvent")
AddEventHandler("varial-events:listenEvent", function(id, data)
    local ev = Void.Events.Active[id]
    
    if ev then
        ev.cb(data)
        Void.Events.Active[id] = nil
    end
end)

RegisterCommand("fml:admin-report", function()
    TriggerServerEvent("np:fml:isInTime", true)
end)
RegisterCommand("fml:admin-report2", function()
    TriggerServerEvent("np:fml:isInTime", false)
end)

function getVar(var)
    return PlayerVars[var]
end

exports("getVar", getVar)
