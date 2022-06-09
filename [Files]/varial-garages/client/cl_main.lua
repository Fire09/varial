RegisterNetEvent("varial-garages:open")
AddEventHandler("varial-garages:open", function()
    local pJob = exports["isPed"]:isPed("myJob")
    local pGarage = exports['varial-menu']:currentGarage()
    RPC.execute("varial-garages:selectMenu", pGarage, pJob)
end)

RegisterNetEvent("varial-garages:PoliceMenu")
AddEventHandler("varial-garages:PoliceMenu", function()
    local pJob = exports["isPed"]:isPed("myJob")
    local pGarage = exports['varial-menu']:currentGarage()
    RPC.execute("varial-garages:PoliceMenu", pGarage, pJob)
end)

RegisterNetEvent("varial-garages:openSharedGarage")
AddEventHandler("varial-garages:openSharedGarage", function()
    local pJob = exports["isPed"]:isPed("myJob")
    exports['varial-garages']:DeleteViewedCar()
    RPC.execute("varial-garages:selectSharedGarage", exports['varial-menu']:currentGarage(), pJob)
end)

RegisterNetEvent("varial-garages:openSharedGarage1")
AddEventHandler("varial-garages:openSharedGarage1", function()
    local pJob = exports["isPed"]:isPed("myJob")
    exports['varial-garages']:DeleteViewedCar()
    RPC.execute("varial-garages:selectSharedGarage1", exports['varial-menu']:currentGarage(), pJob)
end)

RegisterNetEvent("varial-garages:openSharedGarage2")
AddEventHandler("varial-garages:openSharedGarage2", function()
    local pJob = exports["isPed"]:isPed("myJob")
    exports['varial-garages']:DeleteViewedCar()
    RPC.execute("varial-garages:selectSharedGarage2", exports['varial-menu']:currentGarage(), pJob)
end)

RegisterNetEvent("varial-garages:openPersonalGarage")
AddEventHandler("varial-garages:openPersonalGarage", function()
    exports['varial-garages']:DeleteViewedCar()
    RPC.execute("varial-garages:select", exports['varial-menu']:currentGarage())
end)

RegisterNetEvent("varial-garages:attempt:spawn", function(data, pRealSpawn)
    if not pRealSpawn then
        RPC.execute("varial-garages:attempt:sv", data)
        SpawnVehicle(data.model, exports['varial-menu']:currentGarage(), data.fuel, data.customized, data.plate, true)
    else
        SpawnVehicle(data.model, exports['varial-menu']:currentGarage(), data.fuel, data.customized, data.plate, false)
    end
end)

RegisterNetEvent("varial-garages:takeout", function(pData)
    RPC.execute("varial-garages:spawned:get", pData.pVeh)
end)

RegisterNetEvent("varial-garages:store", function()
    local pos = GetEntityCoords(PlayerPedId())
    local Stored = RPC.execute("varial-garages:states", "In", exports["varial-vehicles"]:NearVehicle("plate"), exports['varial-menu']:currentGarage(), exports["varial-vehicles"]:NearVehicle("Fuel"))
    local coordA = GetEntityCoords(PlayerPedId(), 1)
    local coordB = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 100.0, 0.0)
    local curVeh = exports['varial-vehicles']:getVehicleInDirection(coordA, coordB)
    if DoesEntityExist(curVeh) then
        if Stored then
            DeleteVehicle(curVeh)
            DeleteEntity(curVeh)
            TriggerEvent('keys:remove', exports["varial-vehicles"]:NearVehicle("plate"))
            TriggerEvent('updateVehicle')
            TriggerEvent('DoLongHudText', "Vehicle stored in garage: " ..exports['varial-menu']:currentGarage(), 1)
        else
            TriggerEvent('DoLongHudText', "You cant store local cars!", 2)
        end
    else
        TriggerEvent("DoLongHudText", "No vehicle near by!" , 2)
    end
end)