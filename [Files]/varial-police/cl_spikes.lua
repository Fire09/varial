local spikes = {}
local spikemodel = "P_ld_stinger_s"
local nearSpikes = false

function CreateSpikes()
    local spawnCoords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 3.0, 0.0)
        local spike = CreateObject(GetHashKey(spikemodel), spawnCoords.x, spawnCoords.y, spawnCoords.z, 1, 1, 1)
        SetEntityHeading(spike, GetEntityHeading(PlayerPedId()))
        PlaceObjectOnGroundProperly(spike)
		TriggerEvent("animation:PlayAnimation","layspike")
        table.insert(spikes, spike)
		TriggerEvent("DoLongHudText","Spikes Placed!",1)
end

RegisterNetEvent('placespikes')
AddEventHandler('placespikes', function()
    local job = exports['isPed']:isPed('myjob')
    if job == "police" or job == "sheriff" or job == "state" then
        CreateSpikes()
        TriggerEvent("inventory:removeItem","spikes", 1)
    else
        TriggerEvent('DoLongHudText', 'You aint skilled enough for this big man!', 2)
    end
end)

RegisterNetEvent('removespikes')
AddEventHandler('removespikes', function()
    local src = source
    local plypos = GetEntityCoords(PlayerPedId())
    local job = exports['isPed']:isPed('myjob')
    if job == "police" or job == "sheriff" or job == "state" then
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            TriggerEvent("animation:PlayAnimation","layspike")
            local spike = GetClosestObjectOfType(plypos.x, plypos.y, plypos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
            Delete(spike)
            TriggerEvent('player:receiveItem', 'spikes', 1)
            TriggerEvent("DoLongHudText","Spike strip picked up!",1)
        end
    else
        TriggerEvent('DoLongHudText', 'Nice Try', 2)
    end
end)


function Delete(object)
	SetEntityAsMissionEntity(object, false, true)
	DeleteEntity(object)
end

RegisterCommand("removespikes", function(source, args, raw)
    local job = exports["isPed"]:isPed("myJob")
    local src = source
    local plypos = GetEntityCoords(PlayerPedId())
    if job == 'police' or job == 'state' or job == 'sheriff' and not IsPedInAnyVehicle(PlayerPedId(), false) then
        local spike = GetClosestObjectOfType(plypos.x, plypos.y, plypos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
        Delete(spike)
        TriggerEvent("DoLongHudText","Spike strip picked up!",1)
    end
end)

local hit = false
Citizen.CreateThread(function()
    local wait2 = 100
    while true do
        Citizen.Wait(wait2)
        if nearSpikes then
            local tires = {
                {bone = "wheel_lf", index = 0},
                {bone = "wheel_rf", index = 1},
                {bone = "wheel_lm", index = 2},
                {bone = "wheel_rm", index = 3},
                {bone = "wheel_lr", index = 4},
                {bone = "wheel_rr", index = 5}
            }

            for a = 1, #tires do
                local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                local vehpos = GetEntityCoords(vehicle)
                local tirePos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, tires[a].bone))
                local spike = GetClosestObjectOfType(tirePos.x, tirePos.y, tirePos.z, 20.0, GetHashKey(spikemodel), 1, 1, 1)
                local spikePos = GetEntityCoords(spike, false)
                local distance = Vdist(tirePos.x, tirePos.y, tirePos.z, spikePos.x, spikePos.y, spikePos.z)
                local distance2 = Vdist(vehpos, spikePos)
                    wait2 = 0
                if distance < 1.8 and distance > 0 then
                    if not IsVehicleTyreBurst(vehicle, tires[a].index, true) or IsVehicleTyreBurst(vehicle, tires[a].index, false) then
                        SetVehicleTyreBurst(vehicle, tires[a].index, false, 1000.0)
                        hit = true
                    end
                else
                    if distance > 10 and hit then
                        Delete(spike)
                        hit = false
                        wait2 = 100
                    end
                end
            end
        else
            wait2 = 100
        end
    end
end)

Citizen.CreateThread(function()
    local waittime = 100
    while true do
        Citizen.Wait(waittime)
        if IsPedInAnyVehicle(PlayerPedId(), false) then
            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
            if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
                local vehiclePos = GetEntityCoords(vehicle, false)
                if GetClosestObjectOfType(vehiclePos.x, vehiclePos.y, vehiclePos.z, 30.0, GetHashKey(spikemodel), 1, 1, 1) ~= 0 then
                    waittime = 0
                    nearSpikes = true
                else
                    waittime = 100
                    nearSpikes = false
                end
            else
                waittime = 100
                nearSpikes = false
            end
        end
    end
end)

Currentstates = {
	[1] = { ["text"] = "Red Hands", ["status"] = false, ["timer"] = 0 },
	[2] = { ["text"] = "Dilated Eyes", ["status"] = false, ["timer"] = 0 },
	[3] = { ["text"] = "Red Eyes", ["status"] = false, ["timer"] = 0 },
	[4] = { ["text"] = "Smells Like Marijuana", ["status"] = false, ["timer"] = 0 },
	[5] = { ["text"] = "Fresh Bandaging", ["status"] = false, ["timer"] = 0 },
	[6] = { ["text"] = "Agitated", ["status"] = false, ["timer"] = 0 },
	[7] = { ["text"] = "Uncoordinated", ["status"] = false, ["timer"] = 0 },
	[8] = { ["text"] = "Breath smells like Alcohol", ["status"] = false, ["timer"] = 0 },
	[9] = { ["text"] = "Smells like Gasoline", ["status"] = false, ["timer"] = 0 },
	[10] = { ["text"] = "Red Gunpowder Residue", ["status"] = false, ["timer"] = 0 },
	[11] = { ["text"] = "Smells of Chemicals", ["status"] = false, ["timer"] = 0 },
	[12] = { ["text"] = "Smells of Oil / Metalwork", ["status"] = false, ["timer"] = 0 },
	[13] = { ["text"] = "Ink Stained Hands", ["status"] = false, ["timer"] = 0 },
	[14] = { ["text"] = "Smells like smoke.", ["status"] = false, ["timer"] = 0 },
	[15] = { ["text"] = "Has camping equipment.", ["status"] = false, ["timer"] = 0 },
	[16] = { ["text"] = "Smells like burnt Aluminum and iron.", ["status"] = false, ["timer"] = 0 },
	[17] = { ["text"] = "Has metal specs on clothing.", ["status"] = false, ["timer"] = 0 },
	[18] = { ["text"] = "Smells Like Cigarette Smoke.", ["status"] = false, ["timer"] = 0 },
	[19] = { ["text"] = "Labored Breathing.", ["status"] = false, ["timer"] = 0 },
	[20] = { ["text"] = "Body Sweat.", ["status"] = false, ["timer"] = 0 },
	[21] = { ["text"] = "Clothing Sweat.", ["status"] = false, ["timer"] = 0 },	
    [22] = { ["text"] = "Wire Cuts.", ["status"] = false, ["timer"] = 0 },
	[23] = { ["text"] = "Saturated Clothing.", ["status"] = false, ["timer"] = 0 },		
    [24] = { ["text"] = "Looks Dazed.", ["status"] = false, ["timer"] = 0 },
    [25] = { ["text"] = "Looks Well Fed.", ["status"] = false, ["timer"] = 0 },
    [26] = { ["text"] = "Has scratches on hands.", ["status"] = false, ["timer"] = 0 }, 
    [27] = { ["text"] = "Looks Alert.", ["status"] = false, ["timer"] = 0 }, 
}



RegisterNetEvent("Evidence:StateSet")
AddEventHandler("Evidence:StateSet",function(stateId,stateLength)
	if Currentstates[stateId]["timer"] < 10 and stateLength ~= 0 then
		TriggerEvent('chatMessage', 'STATUS ', 1, Currentstates[stateId]["text"])
	end
	Currentstates[stateId]["timer"] = stateLength
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(10000)
        for i = 1, #Currentstates do
        	if Currentstates[i]["timer"] > 0 then
        		Currentstates[i]["timer"] = Currentstates[i]["timer"] - 10
	        	if Currentstates[i]["timer"] < 0 then
	        		Currentstates[i]["timer"] = 0
	        	end
        	end
        end

    end
end)





RegisterNetEvent("stress:timedtest")
AddEventHandler("stress:timedtest",function(alteredValue,scenario)
    local removedStress = 0
    Wait(1000)
    
    
    SetPlayerMaxArmour(PlayerId(), 60 )
    while true do
      removedStress = removedStress + 100
      if removedStress >= alteredValue then
        break
      end
    
      local armor = GetPedArmour(PlayerPedId())
      SetPedArmour(PlayerPedId(),armor+3)
    
      if scenario ~= "None" then
        if not IsPedUsingScenario(PlayerPedId(),scenario) then
          TriggerEvent("animation:cancel")
          break
        end
      end
      Citizen.Wait(1000)
    end
    end)

 --- Rifle Rack below
 
 RegisterNetEvent('police:RifleRack')
 AddEventHandler('police:RifleRack', function()
    local cid = exports["isPed"]:isPed("cid")
    if exports["isPed"]:isPed("myJob") == 'police' or exports["isPed"]:isPed("myJob") == 'sheriff' or exports["isPed"]:isPed("myJob") == 'state' then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Unlocking rifle rack..",false,true)
        if finished == 100 then
        TriggerEvent("server-inventory-open", "1", "pdrifle-rack"..cid)
		Wait(1000)
    else
        TriggerEvent("notification", "You are not in vehicle", 2)
    end
end
end)

--  Sandy Shores PD Amory

-- Armory

InArmory = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("armory_sandyPD1", vector3(1861.41, 3689.95, 34.28), 1.8, 3.2, {
        name="armory_sandyPD1",
        heading=300,
		--debugPoly=true,
		-- minZ=27.67,
		-- maxZ=31.67
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "armory_sandyPD1" then
        InArmory = true     
		local myJob = exports["isPed"]:isPed("myJob")
		if myJob == 'police' or myJob == 'state' or myJob == 'sheriff' then
			OpenSandyPDSArmory()
            exports['varial-interaction']:showInteraction("[E] Armory & Appearance")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "armory_sandyPD1" then
        InArmory = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function OpenSandyPDSArmory()
	Citizen.CreateThread(function()
        while InArmory do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				TriggerEvent('varial-sandyPD-menu')
			end
		end
	end)
end


RegisterNetEvent('varial-sandyPD-menu')
AddEventHandler('varial-sandyPD-menu', function()
	TriggerEvent('varial-context:sendMenu', {
		{
            id = 1,
            header = "Open Armory",
			txt = "Armory 🔫",
			params = {
                event = "police:general",
            }
        },
		{
            id = 2,
            header = "Clothing Shop",
			txt = "Change Clothes",
			params = {
                event = "Evan:clothing:admin",
            }
        },
    })
end)




--// Evidence room sandy pd

local isInEvidenceRoomSandy = false

-- Citizen.CreateThread(function()
--     exports["varial-polyzone"]:AddBoxZone("evidence_sandypd", vector3(1850.07, 3694.39, 34.28), 3, 3, {
-- 		name="evidence_sandypd",
-- 		heading=0,
-- 		--debugPoly=true,
--     }) 
-- end)


-- RegisterNetEvent('varial-polyzone:enter')
-- AddEventHandler('varial-polyzone:enter', function(name)
--     if name == "evidence_sandypd" then
--         local job = exports["isPed"]:isPed("myjob")
--         if job == "police" or job == "sheriff" or job == "state" then
--             isInEvidenceRoomSandy = true
-- 			exports['varial-interaction']:showInteraction('/evidence [number]')
--         end
--     end
-- end)

-- RegisterNetEvent('varial-polyzone:exit')
-- AddEventHandler('varial-polyzone:exit', function(name)
--     if name == "evidence_sandypd" then
--         isInEvidenceRoomSandy = false
--     end
-- 	exports['varial-interaction']:hideInteraction()
-- end)




-- RegisterCommand("evidence", function(source, args)
-- 	local job = exports["isPed"]:isPed("myjob")
-- 	if job == 'police' or job == 'state' or job == 'sheriff' then
-- 		if isInEvidenceRoomSandy then
-- 			TriggerEvent("server-inventory-open", "1", "CASE ID: "..args[1])
-- 		else
-- 			TriggerEvent("notification", "You are not near the evidence spot!", 2)
-- 		end
-- 	end
-- end)

-- -- bENNYS

InBennysSandyPD = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("bennys_sandypd", vector3(1868.44, 3694.16, 33.62), 9.2, 4.8, {
        name="bennys_sandypd",
        heading=270,
		--debugPoly=true,
		-- minZ=27.67,
		-- maxZ=31.67
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "bennys_sandypd" then
        InBennysSandyPD = true     
            exports['varial-interaction']:showInteraction("Bennys")
        end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "bennys_sandypd" then
        InBennysSandyPD = false
        exports['varial-interaction']:hideInteraction()
    end
end)

RegisterNetEvent('varial-police:AttemptBennys:SandyPD')
AddEventHandler('varial-police:AttemptBennys:SandyPD', function()
    local car = GetVehiclePedIsIn(PlayerPedId(), false)
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == 'police' or myJob == 'state' or myJob == 'sheriff' then

    if car ~= 0 then
        FreezeEntityPosition(car, true)
        SetEntityCoords(car,1868.44, 3694.16, 33.62)
        SetEntityHeading(GetPlayerPed(-1), 270)
        Citizen.Wait(1000)
        TriggerEvent('event:control:bennys', 14) -- Dev bennys
        else
            FreezeEntityPosition(car, false)
        end
    else
        TriggerEvent("DoLongHudText", "They do not recognize you", 2)
    end
    end)
