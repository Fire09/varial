RegisterNetEvent("varial-jobmanager:playerBecameJob")
AddEventHandler("varial-jobmanager:playerBecameJob", function(job, name, notify)
    if isMedic and job ~= "ems" then isMedic = false isInService = false end
    if isCop and job ~= "police" or "state" or "sheriff" then isCop = false isInService = false end
    if job == "police" or "state" or "sheriff" then isCop = true isInService = true end
    if job == "ems" then isMedic = true isInService = true end

end)

local attempted = 0

local pickup = false
local additionalWait = 0
RegisterNetEvent('varial-heists:start_loop')
AddEventHandler('varial-heists:start_loop', function()
    pickup = true
    TriggerEvent("varial-heists:pick_cash")
    Wait(180000)
    Wait(additionalWait)
    pickup = false
end)

RegisterNetEvent('varial-heists:pick_cash')
AddEventHandler('varial-heists:pick_cash', function()
    local markerlocation = GetOffsetFromEntityInWorldCoords(attempted, 0.0, -3.7, 0.1)
    SetVehicleHandbrake(attempted,true)
    while pickup do
        Citizen.Wait(0)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], markerlocation["x"],markerlocation["y"],markerlocation["z"])
        if aDist < 10.0 then
            DrawMarker(27,markerlocation["x"],markerlocation["y"],markerlocation["z"], 0, 0, 0, 0, 0, 0, 1.51, 1.51, 0.3, 212, 189, 0, 30, 0, 0, 2, 0, 0, 0, 0)
            
            if aDist < 2.0 then
                if IsDisabledControlJustReleased(0, 38) then
                    pickUpCash()
                end
                DrawText3Ds(markerlocation["x"],markerlocation["y"],markerlocation["z"], "Press [E] to pick up cash.")
            else
                DrawText3Ds(markerlocation["x"],markerlocation["y"],markerlocation["z"], "Get Closer to pick up the cash.")
            end
        end
    end
end)

RegisterNetEvent('varial-heists:spawn_peds')
AddEventHandler('varial-heists:spawn_peds', function(veh)
    local cType = 's_m_m_highsec_01'
    local pedmodel = GetHashKey(cType)
    RequestModel(pedmodel)
    while not HasModelLoaded(pedmodel) do
        RequestModel(pedmodel)
        Citizen.Wait(100)
    end
    ped2 = CreatePedInsideVehicle(veh, 4, pedmodel, 0, 1, 0.0)
    DecorSetBool(ped2, 'ScriptedPed', true)
    ped3 = CreatePedInsideVehicle(veh, 4, pedmodel, 1, 1, 0.0)
    DecorSetBool(ped3, 'ScriptedPed', true)
    ped4 = CreatePedInsideVehicle(veh, 4, pedmodel, 2, 1, 0.0)
    DecorSetBool(ped4, 'ScriptedPed', true)

    GiveWeaponToPed(ped2, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
    GiveWeaponToPed(ped3, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)
    GiveWeaponToPed(ped4, GetHashKey('WEAPON_SpecialCarbine'), 420, 0, 1)

    SetPedDropsWeaponsWhenDead(ped2,false)
    SetPedRelationshipGroupDefaultHash(ped2,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped2,GetHashKey('COP'))
    SetPedAsCop(ped2,true)
    SetCanAttackFriendly(ped2,false,true)

    SetPedDropsWeaponsWhenDead(ped3,false)
    SetPedRelationshipGroupDefaultHash(ped3,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped3,GetHashKey('COP'))
    SetPedAsCop(ped3,true)
    SetCanAttackFriendly(ped3,false,true)

    SetPedDropsWeaponsWhenDead(ped4,false)
    SetPedRelationshipGroupDefaultHash(ped4,GetHashKey('COP'))
    SetPedRelationshipGroupHash(ped4,GetHashKey('COP'))
    SetPedAsCop(ped4,true)
    SetCanAttackFriendly(ped4,false,true)

    TaskCombatPed(ped2, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped3, GetPlayerPed(-1), 0, 16)
    TaskCombatPed(ped4, GetPlayerPed(-1), 0, 16)
end)

local pickingup = false
function pickUpCash()
    local gotcard = false
    local alerted = false
    local addedAdditionalTime = false
    if not pickingup then
        if math.random(10) == 1 then
            TriggerEvent( "player:receiveItem", "Gruppe6Card3", 1 )
        end
        TriggerEvent("alert:noPedCheck", "banktruck")
        TriggerEvent("client:newStress",true,1500)
        local coords = GetEntityCoords(GetPlayerPed(-1))
        local length = 1
        pickingup = true
        RequestAnimDict("anim@mp_snowball")
        
        while not HasAnimDictLoaded("anim@mp_snowball") do
            Citizen.Wait(0)
        end

        while pickingup do

            local coords2 = GetEntityCoords(GetPlayerPed(-1))
            local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], coords2["x"],coords2["y"],coords2["z"])
            if aDist > 1.0 or not pickup then
                pickingup = false
            end

            if IsEntityPlayingAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 3) then
                --ClearPedSecondaryTask(player)
            else
                TaskPlayAnim(GetPlayerPed(-1), "anim@mp_snowball", "pickup_snowball", 8.0, -8, -1, 49, 0, 0, 0, 0)
            end 

            local chance = math.random(1,60)

            if not alerted then
                TriggerEvent("alert:noPedCheck", "banktruck")
                alerted = true
            end

            if chance < 30 then
                TriggerEvent("player:receiveItem","band",math.random(length))
            end

            TriggerEvent("player:receiveItem","rollcash",math.random(length))
            
            local waitMin = 4000
            local waitMax = 6000
            
            Wait(waitMin, waitMax)

            length = length + 1

            if length > 15 then
                length = 15
            end

        end
        additionalWait = 0
        ClearPedTasks(GetPlayerPed(-1))
        
    end
end

RegisterNetEvent('varial-heists:start_hitting_truck')
AddEventHandler('varial-heists:start_hitting_truck', function(veh)
    TriggerEvent('varial-dispatch:bank_truck_robbery')
    attempted = veh
    SetEntityAsMissionEntity(attempted,true,true)
    local plate = GetVehicleNumberPlateText(veh)
    TriggerServerEvent("varial-heists:check_if_robbed",plate)
end)

RegisterNetEvent('sec:AllowHeist')
AddEventHandler('sec:AllowHeist', function()
    TriggerServerEvent('banktruckrobbery:log')
    TriggerEvent("varial-heists:spawn_peds",attempted)
    SetVehicleDoorOpen(attempted, 2, 0, 0)
    SetVehicleDoorOpen(attempted, 3, 0, 0)
    TriggerEvent("varial-heists:start_loop")

end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function FindEndPointCar(x,y)   
	local randomPool = 50.0
	while true do

		if (randomPool > 2900) then
			return
		end
	    local vehSpawnResult = {}
	    vehSpawnResult["x"] = 0.0
	    vehSpawnResult["y"] = 0.0
	    vehSpawnResult["z"] = 30.0
	    vehSpawnResult["x"] = x + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    vehSpawnResult["y"] = y + math.random(randomPool - (randomPool * 2),randomPool) + 1.0  
	    roadtest, vehSpawnResult, outHeading = GetClosestVehicleNode(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"],  0, 55.0, 55.0)

        Citizen.Wait(1000)        
        if vehSpawnResult["z"] ~= 0.0 then
            local caisseo = GetClosestVehicle(vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], 20.000, 0, 70)
            if not DoesEntityExist(caisseo) then

                return vehSpawnResult["x"], vehSpawnResult["y"], vehSpawnResult["z"], outHeading
            end
            
        end

        randomPool = randomPool + 50.0
	end
end