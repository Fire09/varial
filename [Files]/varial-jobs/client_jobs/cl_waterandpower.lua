local DepoLocation = {x = -424.33847045898, y = -2789.8154296875, z = 6.5157470703125}

local ElectricalLocation = {
    [1] = {name = "Capital Boulevard",x = 1219.8198242188, y = -1462.9187011719 , z = 34.84033203125},
    [2] = {name = "Capital Boulevard",x = 976.49670410156, y = -1388.8879394531 , z = 31.537719726562},
    [3] = {name = "Popular Street",x = 817.9912109375, y = -493.1340637207 , z = 30.526733398438},
    [4] = {name = "Bridge Street",x = 1114.6812744141, y = -335.36703491211 , z = 67.0908203125},
    [5] = {name = "Alta Street",x = 86.742858886719, y = -236.63735961914 , z = -236.63735961914},
    [6] = {name = "Portola Drive",x = -765.89013671875, y = -218.03076171875 , z = 37.283569335938},
    [7] = {name = "Cougar Avenue",x = -1563.5999755859, y = -233.6967010498 , z = 49.465942382812},
    [8] = {name = "West Eclipse Boulevard",x = -2064.5275878906, y = -312.89669799805, z = 13.272583007812},
    [9] = {name = "Bay City Ave",x = -1817.7098388672, y = -342.51428222656, z = 49.12890625},
}

local isCurrentlyWorkingOnElectrical = false
local ElectricalPoint = 0
local isOnTheWayToWaterNPowerJob = false
local isOnWaterNPowerJob = false
local NeedsToReturnTruck = false

local px = 0
local py = 0
local pz = 0

local JobAmount = 0

--// Shit

function EvanCoolHaha(ElectricalLocation,ElectricalPoint)
    JobBlip = AddBlipForCoord(ElectricalLocation[ElectricalPoint].x,ElectricalLocation[ElectricalPoint].y, ElectricalLocation[ElectricalPoint].z)
    SetBlipSprite(JobBlip, 1)
    SetNewWaypoint(ElectricalLocation[ElectricalPoint].x,ElectricalLocation[ElectricalPoint].y)
end

RegisterNetEvent('varial-civjobs:waternpower:givejob')
AddEventHandler('varial-civjobs:waternpower:givejob', function()
    isCurrentlyWorkingOnElectrical = true
    isOnTheWayToWaterNPowerJob = true
    ElectricalPoint = math.random(10)
    px = ElectricalLocation[ElectricalPoint].x
    py = ElectricalLocation[ElectricalPoint].y
    pz = ElectricalLocation[ElectricalPoint].z
    distance = round(GetDistanceBetweenCoords(DepoLocation.x, DepoLocation.y, DepoLocation.z, px,py,pz))
    EvanCoolHaha(ElectricalLocation,ElectricalPoint)
    print(ElectricalPoint)
end)

local CanClockOut = false
local CanSpawnWorkVeh = false

RegisterNetEvent('varial-civjobs:wandp:clockin')
AddEventHandler('varial-civjobs:wandp:clockin', function()
    if not CanClockOut then
        JobAmount = 5
        CanClockOut = true
        CanSpawnWorkVeh = true
        TriggerEvent('varial-phone:SendNotify', "Clocked in go to the container use F1 to get a vehicle" , 'JobNotify')
        TriggerEvent('phone:addJobNotify', "You have "..JobAmount.."/5 Job\'s Remaining")
    else
        TriggerEvent('DoLongHudText', 'Your already clocked in !', 2)
    end
end)

RegisterNetEvent('varial-civjobs:wandp:clockout')
AddEventHandler('varial-civjobs:wandp:clockout', function()
    if NeedsToReturnTruck then
        TriggerEvent('DoLongHudText', 'You need to return your truck', 2)
    else
        if CanClockOut then
            TriggerEvent('DoLongHudText', 'Clocked Out !', 2)
            RemoveBlip(JobBlip)
            CanClockOut = false
        else
            print('was never clocked in bozo')
        end
    end
end)

RegisterNetEvent('varial-jobs:return-car')
AddEventHandler('varial-jobs:return-car', function()
    if not CanSpawnWorkVeh then
        if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("BOXVILLE")) then
            local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), true)
            deleteCar( vehicle )
            print(vehicle)
            RemoveBlip(JobBlip)
            CanClockOut = false
            NeedsToReturnTruck = false
            TriggerEvent('DoLongHudText', 'Returned Vehicle and Clocked Out', 1)
        else
            TriggerEvent('DoLongHudText', 'Hm, try getting in and out of the vehicle and trying again', 2)
        end
    else
        TriggerEvent('DoLongHudText', 'Hm, looks like you havent got a vehicle out!', 2)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isOnTheWayToWaterNPowerJob == true then
            destinol = ElectricalLocation[ElectricalPoint].name
            if GetDistanceBetweenCoords(px,py,pz, GetEntityCoords(GetPlayerPed(-1),true)) < 2 then
               if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), true), GetHashKey("boxville")) and not IsPedInAnyVehicle(PlayerPedId()) then
                    exports['varial-interaction']:showInteraction('[E] Fix Electricals')
                    if IsControlJustPressed(1,38) then
                        exports['varial-interaction']:hideInteraction()
                        FreezeEntityPosition(GetPlayerPed(-1), true)
                        TriggerEvent("animation:PlayAnimation","welding")
                        local canwork = exports['varial-taskbar']:taskBar(15000, 'Fixing Electricals')
                        if (canwork == 100) then
                            print('Passed - W&P - ' ..JobAmount)
                            JobAmount = JobAmount - 1
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            exports['varial-interaction']:hideInteraction()
                            isOnTheWayToWaterNPowerJob = false
                            isOnWaterNPowerJob = true
                            RemoveBlip(JobBlip)
                            TriggerServerEvent('varial-civjobs:post-op-payment')
                            if JobAmount == 0 then
                                TriggerEvent('phone:addJobNotify', "Return to depo you have no more jobs left.")
                            else
                                TriggerEvent('phone:addJobNotify', "You have "..JobAmount.."/5 Job\'s Remaining, wait for another job")
                                Citizen.Wait(math.random(20000, 60000))
                                TriggerEvent('varial-civjobs:waternpower:givejob')
                            end
                        else
                            FreezeEntityPosition(GetPlayerPed(-1), false)
                            TriggerEvent('DoLongHudText', 'Something went wrong try again...', 2)
                        end
                    end
                end
            else
                exports['varial-interaction']:hideInteraction()
            end
        end
            if IsEntityDead(GetPlayerPed(-1)) then
                isCurrentlyWorkingOnElectrical = false
                ElectricalPoint = 0
                isOnTheWayToWaterNPowerJob = false
                isOnWaterNPowerJob = false
                px = 0
                py = 0
                pz = 0
                RemoveBlip(JobBlip)
            end
        end
    end)
    
--// Spawn vehicle


function findClosestSpawnWaterNPower(pCurrentPosition)
	local coords = vector3(453.982421875, -1968.2769775391, 22.84326171875)
	local closestDistance = -1
	local closestCoord = pCurrentPosition
	local distance = #(coords - pCurrentPosition)
	if closestDistance == -1 or closestDistance > distance then
	  closestDistance = distance
	  closestCoord = coords
	end
	return closestCoord
end

RegisterNetEvent("varial-civjobs:waternpowercar")
AddEventHandler("varial-civjobs:waternpowercar", function()
	Citizen.CreateThread(function()
        if CanSpawnWorkVeh then
            local hash = GetHashKey("BOXVILLE")

            if not IsModelAVehicle(hash) then return end
            if not IsModelInCdimage(hash) or not IsModelValid(hash) then return end
            
            RequestModel(hash)

            while not HasModelLoaded(hash) do
                Citizen.Wait(0)
            end

            local spawnLocation = findClosestSpawnWaterNPower(GetEntityCoords(PlayerPedId()))
            local getVehicleInArea = GetClosestVehicle(spawnLocation, 3.000, 0, 70)
            if DoesEntityExist(getVehicleInArea) then
            TriggerEvent("DoLongHudText", "The area is crowded", 2)
            return
            end

            local vehicle = CreateVehicle(hash, 453.982421875, -1968.2769775391, 22.84326171875, 184.25196838379, true, false)

            local plate = GetVehicleNumberPlateText(vehicle)
            TriggerEvent("keys:addNew",vehicle,plate)
            TriggerEvent('varial-civjobs:waternpower:givejob')
            CanSpawnWorkVeh = false
            NeedsToReturnTruck = true
            SetModelAsNoLongerNeeded(hash)
            SetVehicleDirtLevel(vehicle, 0)
            SetVehicleWindowTint(vehicle, 0)
        else
            TriggerEvent('DoLongHudText', 'You need to clock in first bozo', 2)
        end
    end)
end)