Void.Events = Void.Events or {}
Void.Events.Registered = Void.Events.Registered or {}

RegisterServerEvent("varial-events:listenEvent")
AddEventHandler("varial-events:listenEvent", function(id, name, args)
    local src = source

    if not Void.Events.Registered[name] then return end

    Void.Events.Registered[name].f(Void.Events.Registered[name].mod, args, src, function(data)
        TriggerClientEvent("varial-events:listenEvent", src, id, data)
    end)
end)

function Void.Events.AddEvent(self, module, func, name)
    Void.Events.Registered[name] = {
        mod = module,
        f = func
    }
end