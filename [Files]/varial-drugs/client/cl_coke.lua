local CokePlaneSpawnsEvanRP = {		
	[1] =  { ['x'] = -1648.8000488281, ['y'] = -3144.8703613281, ['z'] = 13.980224609375, ['h'] = 328.81890869141, ['info'] = ' Cocaine Plane Spawn Location 1' },
    [2] =  { ['x'] = -984.75164794922, ['y'] = -3016.1538085938, ['z'] = 14.283569335938, ['h'] = 53.858268737793, ['info'] = ' Cocaine Plane Spawn Location 2' },
    [3] =  { ['x'] = 1732.3121337891, ['y'] = 3311.3669433594, ['z'] = 41.563354492188, ['h'] = 192.75592041016, ['info'] = ' Cocaine Plane Spawn Location 2' },
}

function EvanCokeCreatingPlane()
	if DoesEntityExist(EvanCokePlane) then
	    SetVehicleHasBeenOwnedByPlayer(EvanCokePlane,false)
		SetEntityAsNoLongerNeeded(EvanCokePlane)
		DeleteEntity(EvanCokePlane)
	end

    local plane = GetHashKey("duster")
    RequestModel(plane)
    while not HasModelLoaded(plane) do
        Citizen.Wait(0)
    end

    SpawnPlane = math.random(1,#CokePlaneSpawnsEvanRP)
    local x = CokePlaneSpawnsEvanRP[SpawnPlane]["x"]
    local y = CokePlaneSpawnsEvanRP[SpawnPlane]["y"]
    local z = CokePlaneSpawnsEvanRP[SpawnPlane]["z"]
    local h = CokePlaneSpawnsEvanRP[SpawnPlane]["h"]
    print(SpawnPlane)
    SetNewWaypoint(x, y)

    EvanCokePlane = CreateVehicle(plane, x, y, z, h, true, false)

	local pos = GetEntityCoords(EvanCokePlane, false)
    Citizen.CreateThread(function()
        while true do
          Citizen.Wait(5)
          if GetVehiclePedIsIn(PlayerPedId(), false) == EvanCokePlane then
            VoidCocaineDropLocation()
            return
          end
        end
    end)
end

local EvanRPCanDropOffPlane = false

function VoidCocaineDropLocation()
    TriggerEvent('varial-dispatch:unauthorised_aircraft')
    TriggerEvent('phone:addJobNotify', "Get in the plane head to the drop location.")
    Citizen.Wait(math.random(20000, 30000))
    TriggerEvent('phone:addJobNotify', "I marked the spot make sure the police aint around.")
    EvanRPCanDropOffPlane= true
    SetNewWaypoint(-2235.8901367188, 3273.1647949219)
end

--// Polyzones

EvanCokePlaneDrop = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_cocaine_plane_drop_off", vector3(-2238.35, 3274.98, 32.81), 20, 21.8, {
        name="varial_cocaine_plane_drop_off",
        heading=330,
        --debugPoly=true,
        minZ=31.61,
        maxZ=35.61
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_cocaine_plane_drop_off" and EvanRPCanDropOffPlane and GetVehiclePedIsIn(PlayerPedId(), false) == EvanCokePlane then
        EvanCokePlaneDrop = true     
        EvanCocaineDrop()
		exports['varial-interaction']:showInteraction("[E] Drop Off Plane")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_cocaine_plane_drop_off" then
        EvanCokePlaneDrop = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function EvanCocaineDrop()
	Citizen.CreateThread(function()
        while EvanCokePlaneDrop do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local finishedcoke = exports['varial-taskbar']:taskBar(7500, 'Dropping off plane')
                if (finishedcoke == 100) then
                    exports['varial-interaction']:hideInteraction()
                    DeleteEntity(EvanCokePlane)
                    TriggerEvent('phone:addJobNotify', "Drop Off Successful Take this - Anon")
                    TriggerEvent('player:receiveItem', 'coke50g', math.random(1, 3))
                    EvanRPCanDropOffPlane = false
                    EvanCokePlaneDrop = false
                    Citizen.Wait(3.6e+6)
                    TriggerServerEvent('varial-cocaine:plane:shit')
                end
			end
		end
	end)
end

--// Start Location

EvanCocaineStart = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_cocaine_plane_start", vector3(839.42, 2176.75, 52.29), 1, 1.2, {
        name="varial_cocaine_plane_start",
        heading=330,
        --debugPoly=true,
        minZ=49.69,
        maxZ=53.69
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_cocaine_plane_start" then
        EvanCocaineStart = true     
        EvanCocaineStart2()
		exports['varial-interaction']:showInteraction("[E] Talk")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_cocaine_plane_start" then
        EvanCocaineStart = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function EvanCocaineStart2()
	Citizen.CreateThread(function()
        while EvanCocaineStart do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                TriggerServerEvent('varial-cocaine:plane:start', 25000)
			end
		end
	end)
end

RegisterNetEvent('varial-cocaine:shitfuckoff')
AddEventHandler('varial-cocaine:shitfuckoff', function()
    TriggerEvent('phone:addJobNotify', "Ive updated your GPS Head over there !")
    EvanCokeCreatingPlane()
end)

RegisterNetEvent('sellcoketemp')
AddEventHandler('sellcoketemp', function()
    if exports["varial-inventory"]:hasEnoughOfItem("coke5g",5,false) then
        local finished = exports["varial-taskbar"]:taskBar(3000,"selling coke you criminal SHAME")
        if finished == 100 then
            TriggerEvent('inventory:removeItem', 'coke5g', 5)
            TriggerServerEvent( 'zyloz:payout', math.random(3750,3751))
            TriggerEvent('DoLongHudText', 'You successfully sold a baggie', 1)
        else
            TriggerEvent('DoLongHudText', 'Cancelled', 2)
        end

    else
        TriggerEvent('DoLongHudText', 'You dont have coke', 2)
    end
end)

