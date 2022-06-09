RegisterNUICallback('callback', function(data, cb)
	SetNuiFocus(false, false)
    Callbackk(data.success)
    cb('ok')
end)

function OpenLockpickGame(callback, target)
  Callbackk = callback
	SetNuiFocus(true, false)
	SendNUIMessage({type = "open", target = target})
end

-- /lockpick [lock count]
RegisterCommand("lockpick",function(source, args, raw)
  exports['varial-lockpick']:OpenLockpickGame(function(success)
    if success then
      print("basarili")
    else
      print("basarisiz")
    end
  end, tonumber(args[1]))
end)