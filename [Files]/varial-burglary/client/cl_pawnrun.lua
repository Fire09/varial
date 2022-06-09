--------------------
------ LOCALS ------
--------------------

local tasking = false
local rnd = 0
local blip = 0
local deliveryPed = 0
local gangTaskArea = "local"
local mygang = "local"
local watching = "local"
local watchinglist = {}
local drugStorePed = 0
local rolexVehicle = 0
local firstdeal = false
local lunchtime2 = false

local RolexDropOffs123 = {
	[1] = { ['x'] = 46.1524, ['y'] = -1476.7189, ['z'] = 29.3170, ['h'] = 139.7198, ['info'] = 'GSF 1' },
	[2] = { ['x'] = -29.3422, ['y'] = -1473.4358, ['z'] = 31.1078, ['h'] = 8.1225, ['info'] = 'GSF 2' },
	[3] = { ['x'] = -156.7668, ['y'] = -1541.8529, ['z'] = 34.9816, ['h'] = 232.6306, ['info'] = 'GSF 3' },
	[4] = { ['x'] = -99.3112, ['y'] = -1578.2963, ['z'] = 31.6934, ['h'] = 231.7848, ['info'] = 'GSF 4' },
	[5] = { ['x'] = -189.2680, ['y'] = -1696.2288, ['z'] = 33.2028, ['h'] = 308.3297, ['info'] = 'GSF 5' },
	[6] = { ['x'] = 43.4741, ['y'] = -1599.7650, ['z'] = 29.5991, ['h'] = 57.1507, ['info'] = ' Overall 1' },
	[7] = { ['x'] = 165.7283, ['y'] = -1503.6810, ['z'] = 29.2605, ['h'] = 136.4087, ['info'] = 'Overall 2' },
	[8] = { ['x'] = 271.2181, ['y'] = -1704.6768, ['z'] = 29.3046, ['h'] = 51.4415, ['info'] = 'Overall 3' },
	[9] = { ['x'] = 162.0545, ['y'] = -1716.9275, ['z'] = 29.2917, ['h'] = 230.6309, ['info'] = 'Ballas 1' },
	[10] = { ['x'] = 161.8787, ['y'] = -1809.9852, ['z'] = 28.7246, ['h'] = 136.1513, ['info'] = 'Ballas 2' },
	[11] = { ['x'] = -10.8360, ['y'] = -1828.6095, ['z'] = 25.3935, ['h'] = 138.1396, ['info'] = 'Ballas 3' },
	[12] = { ['x'] = -59.3870, ['y'] = -1752.3202, ['z'] = 29.4088, ['h'] = 137.7803, ['info'] = 'Ballas 4' },
	[13] = { ['x'] = 234.2278, ['y'] = -1946.5729, ['z'] = 22.9589, ['h'] = 11.7603, ['info'] = 'Vagos 1' },
	[14] = { ['x'] = 174.6839, ['y'] = -2025.5616, ['z'] = 18.3274, ['h'] = 126.8092, ['info'] = 'Vagos 2' },
	[15] = { ['x'] = 410.3984, ['y'] = -1908.6029, ['z'] = 25.4558, ['h'] = 92.5838, ['info'] = 'Vagos 3' },
	[16] = { ['x'] = 285.6999, ['y'] = -1726.5742, ['z'] = 29.3329, ['h'] = 237.1148, ['info'] = 'Vagos 4' },
}

local RolexDropOffs = {
	[1] = { ['x'] = 46.1524, ['y'] = -1476.7189, ['z'] = 29.3170, ['h'] = 139.7198, ['info'] = 'GSF 1' },
	[2] = { ['x'] = -29.3422, ['y'] = -1473.4358, ['z'] = 31.1078, ['h'] = 8.1225, ['info'] = 'GSF 2' },
	[3] = { ['x'] = -156.7668, ['y'] = -1541.8529, ['z'] = 34.9816, ['h'] = 232.6306, ['info'] = 'GSF 3' },
	[4] = { ['x'] = -99.3112, ['y'] = -1578.2963, ['z'] = 31.6934, ['h'] = 231.7848, ['info'] = 'GSF 4' },
	[5] = { ['x'] = -189.2680, ['y'] = -1696.2288, ['z'] = 33.2028, ['h'] = 308.3297, ['info'] = 'GSF 5' },
	[6] = { ['x'] = 43.4741, ['y'] = -1599.7650, ['z'] = 29.5991, ['h'] = 57.1507, ['info'] = ' Overall 1' },
	[7] = { ['x'] = 165.7283, ['y'] = -1503.6810, ['z'] = 29.2605, ['h'] = 136.4087, ['info'] = 'Overall 2' },
	[8] = { ['x'] = 271.2181, ['y'] = -1704.6768, ['z'] = 29.3046, ['h'] = 51.4415, ['info'] = 'Overall 3' },
	[9] = { ['x'] = 162.0545, ['y'] = -1716.9275, ['z'] = 29.2917, ['h'] = 230.6309, ['info'] = 'Ballas 1' },
	[10] = { ['x'] = 161.8787, ['y'] = -1809.9852, ['z'] = 28.7246, ['h'] = 136.1513, ['info'] = 'Ballas 2' },
	[11] = { ['x'] = -10.8360, ['y'] = -1828.6095, ['z'] = 25.3935, ['h'] = 138.1396, ['info'] = 'Ballas 3' },
	[12] = { ['x'] = -59.3870, ['y'] = -1752.3202, ['z'] = 29.4088, ['h'] = 137.7803, ['info'] = 'Ballas 4' },
	[13] = { ['x'] = 234.2278, ['y'] = -1946.5729, ['z'] = 22.9589, ['h'] = 11.7603, ['info'] = 'Vagos 1' },
	[14] = { ['x'] = 174.6839, ['y'] = -2025.5616, ['z'] = 18.3274, ['h'] = 126.8092, ['info'] = 'Vagos 2' },
	[15] = { ['x'] = 410.3984, ['y'] = -1908.6029, ['z'] = 25.4558, ['h'] = 92.5838, ['info'] = 'Vagos 3' },
	[16] = { ['x'] = 285.6999, ['y'] = -1726.5742, ['z'] = 29.3329, ['h'] = 237.1148, ['info'] = 'Vagos 4' },
}

-----------------------
------ NETEVENTS ------
-----------------------

RegisterNetEvent('lunchtime2')
AddEventHandler('lunchtime2', function(pass)
	lunchtime2 = pass
end)

RegisterNetEvent("rolexdelivery:client")
AddEventHandler("rolexdelivery:client", function()

	if tasking then
		return
	end
	
	rnd = math.random(1,#RolexDropOffs)

	CreateBlip()

	local pedCreated = false

	tasking = true
	local toolong = 600000
	while tasking do

		Citizen.Wait(1)
		local plycoords = GetEntityCoords(PlayerPedId())
		local dstcheck = #(plycoords - vector3(RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"])) 

		local veh = GetVehiclePedIsIn(PlayerPedId(),false)
		if dstcheck < 40.0 and not pedCreated then
			pedCreated = true
			DeleteCreatedPed()
			CreateRolexPed()
			TriggerEvent("DoLongHudText","You are close to the drop off.")
		end
		toolong = toolong - 1
		if toolong < 0 then
			tasking = false
			RolexRun = false
			TriggerEvent("DoLongHudText","You are no longer selling Rolex due to taking too long to drop off.")
		end
		if dstcheck < 2.0 and pedCreated then

			local crds = GetEntityCoords(deliveryPed)
			DrawText3Ds(crds["x"],crds["y"],crds["z"], "[E] - Make Exchange")  

			if IsControlJustReleased(0,38) then
				TaskTurnPedToFaceEntity(deliveryPed, PlayerPedId(), 1.0)
				PlayAmbientSpeech1(deliveryPed, "Generic_Hi", "Speech_Params_Force")
				local finished = exports["varial-taskbar"]:taskBar(2000,"Making An Exchange")
				if finished == 100 then 
					DoDropOff()
					tasking = false
				end
			end
		end
	end
	
	DeleteCreatedPed()
	DeleteBlip()

end)

RegisterNetEvent("rolexdelivery:startDealing")
AddEventHandler("rolexdelivery:startDealing", function()
	local NearNPC = exports["isPed"]:GetClosestNPC()
	PlayAmbientSpeech1(NearNPC, "Chat_Resp", "SPEECH_PARAMS_FORCE", 1)
	TriggerEvent("chatMessage", "EMAIL - Pawn Runs", 8, "Find a car get to the drop offs, preferably not your personal car ! Keep the police away.")
	salecount = 0	
	firstdeal = true
	RolexRun = true
end)

-----------------------
------ FUNCTIONS ------
-----------------------

function CleanUpArea()
    local playerped = PlayerPedId()
    local plycoords = GetEntityCoords(playerped)
    local handle, ObjectFound = FindFirstObject()
    local success
    repeat
        local pos = GetEntityCoords(ObjectFound)
        local distance = #(plycoords - pos)
        if distance < 10.0 and ObjectFound ~= playerped then
        	if IsEntityAPed(ObjectFound) then
        		if IsPedAPlayer(ObjectFound) then
        		else
        			DeleteObject(ObjectFound)
        		end
        	else
        		if not IsEntityAVehicle(ObjectFound) and not IsEntityAttached(ObjectFound) then
	        		DeleteObject(ObjectFound)
	        	end
        	end            
        end
        success, ObjectFound = FindNextObject(handle)
    until not success
    SetEntityAsNoLongerNeeded(drugStorePed)
    DeleteEntity(drugStorePed)
    EndFindObject(handle)
end

RolexSpot = false

Citizen.CreateThread(function()
	exports["varial-polyzone"]:AddBoxZone("rolex_run_start", vector3(182.79, -1319.47, 29.32), 2, 2, {
		name="rolex_run_start",
		heading=335,
		minZ=27.72,
		maxZ=31.72
	  })
	  
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "rolex_run_start" then
        RolexSpot = true     
        RolexLocation()
		if not RolexRun then
			exports["varial-interaction"]:showInteraction("[E] Start Run ($500)")
		else 
			exports["varial-interaction"]:showInteraction("Finish Your Run")
		end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "rolex_run_start" then
        RolexSpot = false  
		exports["varial-interaction"]:hideInteraction()
    end
end)

function RolexLocation()
	Citizen.CreateThread(function()
        while RolexSpot do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				if exports['varial-inventory']:hasEnoughOfItem('rolexwatch', 1) or exports['varial-inventory']:hasEnoughOfItem('stolenpsp', 1) or exports['varial-inventory']:hasEnoughOfItem('stolens8', 1) or exports['varial-inventory']:hasEnoughOfItem('stolenBrokenGoods', 1) or exports['varial-inventory']:hasEnoughOfItem('stolen2ctchain', 1) or exports['varial-inventory']:hasEnoughOfItem('stolenraybans', 1) or exports['varial-inventory']:hasEnoughOfItem('stolencasiowatch', 1) then
					if not RolexRun then
						TriggerServerEvent("rolexdelivery:server", 500)
					end
				else
					TriggerEvent('DoLongHudText', 'We need something to buy ?!?!', 2)
				end
			end
		end
	end)
end

Citizen.CreateThread(function()
    while true do
        if drugdealer then
	        Citizen.Wait(1000)
	        if firstdeal then
	        	Citizen.Wait(10000)
	        end
	        TriggerEvent("drugdelivery:client")  
		    salecount = salecount + 1
		    if salecount == 7 then
		    	Citizen.Wait(1200000)
		    	drugdealer = false
		    end
		    Citizen.Wait(150000)
		    firstdeal = false
		elseif RolexRun then
			if (not DoesEntityExist(rolexVehicle) or GetVehicleEngineHealth(rolexVehicle) < 100.0) and vehspawn then
				RolexRun = false
				tasking = false
				TriggerEvent("chatMessage", "EMAIL - Drug Deliveries", 8, "Dude! You fucked the car up, I canceled your run, asshole! ")
			else
				if tasking then
			        Citizen.Wait(30000)
			    else
			        TriggerEvent("rolexdelivery:client")  
				    salecount = salecount + 1
				    if salecount == 7 then
				    	RolexRun = false
				    end
				end
			end
	    else
			Citizen.Wait(2000)
	    end
    end
end)

function CreateRolexPed()

    local hashKey = `a_m_y_stwhi_01`

    local pedType = 5

    RequestModel(hashKey)
    while not HasModelLoaded(hashKey) do
        RequestModel(hashKey)
        Citizen.Wait(100)
    end


	deliveryPed = CreatePed(pedType, hashKey, RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"], RolexDropOffs[rnd]["h"], 0, 0)
	
	DecorSetBool(deliveryPed, 'ScriptedPed', true)
    ClearPedTasks(deliveryPed)
    ClearPedSecondaryTask(deliveryPed)
    TaskSetBlockingOfNonTemporaryEvents(deliveryPed, true)
    SetPedFleeAttributes(deliveryPed, 0, 0)
    SetPedCombatAttributes(deliveryPed, 17, 1)

    SetPedSeeingRange(deliveryPed, 0.0)
    SetPedHearingRange(deliveryPed, 0.0)
    SetPedAlertness(deliveryPed, 0)
    searchPockets()
    SetPedKeepTask(deliveryPed, true)

end

function DeleteCreatedPed()
	if DoesEntityExist(deliveryPed) then 
		SetPedKeepTask(deliveryPed, false)
		TaskSetBlockingOfNonTemporaryEvents(deliveryPed, false)
		ClearPedTasks(deliveryPed)
		TaskWanderStandard(deliveryPed, 10.0, 10)
		SetPedAsNoLongerNeeded(deliveryPed)
		DecorSetBool(deliveryPed, 'ScriptedPed', false)

		Citizen.Wait(20000)
		DeletePed(deliveryPed)
	end
end

function DeleteBlip()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

function CreateBlip()
	DeleteBlip()
	if RolexRun then
		blip = AddBlipForCoord(RolexDropOffs[rnd]["x"],RolexDropOffs[rnd]["y"],RolexDropOffs[rnd]["z"])
	else
		blip = AddBlipForCoord(RolexDrops[rnd]["x"],RolexDrops[rnd]["y"],RolexDrops[rnd]["z"])
	end
    
    SetBlipSprite(blip, 500)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Drop Off")
    EndTextCommandSetBlipName(blip)
end

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function searchPockets()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "random@mugging4" )
        TaskPlayAnim( deliveryPed, "random@mugging4", "agitated_loop_a", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
    end
end

function giveAnim()
    if ( DoesEntityExist( deliveryPed ) and not IsEntityDead( deliveryPed ) ) then 
        loadAnimDict( "mp_safehouselost@" )
        if ( IsEntityPlayingAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 3 ) ) then 
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        else
            TaskPlayAnim( deliveryPed, "mp_safehouselost@", "package_dropoff", 8.0, 1.0, -1, 16, 0, 0, 0, 0 )
        end     
    end
end

function DoDropOff(requestMoney)
	local success = true

	searchPockets()

	PlayAmbientSpeech1(deliveryPed, "Chat_State", "Speech_Params_Force")

	if DoesEntityExist(deliveryPed) and not IsEntityDead(deliveryPed) then

			if math.random(10) == 1 then
				TriggerEvent( "player:receiveItem", "safecrackingkit", 1 )
			end

			if RolexRun then
		        if exports["varial-inventory"]:hasEnoughOfItem("rolexwatch",1) then     
		            TriggerEvent("inventory:removeItem","rolexwatch", 1)  
		            TriggerServerEvent('rolexwatch:cash:payment')             

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolenpsp",1) then     
					TriggerEvent("inventory:removeItem","stolenpsp", 1)   
					TriggerServerEvent('stolenpsp:cash:payment')                 

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolens8",1) then     
					TriggerEvent("inventory:removeItem","stolens8", 1)   
					TriggerServerEvent('stolens8:cash:payment')             

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolenBrokenGoods",1) then     
					TriggerEvent("inventory:removeItem","stolenBrokenGoods", 1)   
					TriggerServerEvent('brokenGoods:cash:payment')                   

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolen2ctchain",1) then     
					TriggerEvent("inventory:removeItem","stolen2ctchain", 1)   
					TriggerServerEvent('stolen2ctchain:cash:payment')
					
				elseif exports["varial-inventory"]:hasEnoughOfItem("stolen10ctchain",1) then     
					TriggerEvent("inventory:removeItem","stolen10ctchain", 1)   
					TriggerServerEvent('stolen10ctchain:cash:payment') 

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolenraybans",1) then     
					TriggerEvent("inventory:removeItem","stolenraybans", 1)   
					TriggerServerEvent('stolenraybans:cash:payment')                 

				elseif exports["varial-inventory"]:hasEnoughOfItem("stolencasiowatch",1) then     
					TriggerEvent("inventory:removeItem","stolencasiowatch", 1)   
					TriggerServerEvent('stolencasiowatch:cash:payment')                 
					
			else
				TriggerEvent("DoLongHudText","You aint got anything to sell !", 2)
			end
		end
	end

	local counter = math.random(90, 115)
	while counter > 0 do
		local crds = GetEntityCoords(deliveryPed)
		counter = counter - 1
		Citizen.Wait(1)
	end

	if success then
		searchPockets()
		local counter = math.random(90, 115)
		while counter > 0 do
			local crds = GetEntityCoords(deliveryPed)
			counter = counter - 1
			Citizen.Wait(1)
		end
		giveAnim()
	end

	local crds = GetEntityCoords(deliveryPed)
	local crds2 = GetEntityCoords(PlayerPedId())

	if #(crds - crds2) > 5.0 or not DoesEntityExist(deliveryPed) or IsEntityDead(deliveryPed) then
		success = false
	end


	if success then
		PlayAmbientSpeech1(deliveryPed, "Generic_Thanks", "Speech_Params_Force_Shouted_Critical")
		TriggerEvent("denoms",true)
		TriggerEvent("client:newStress",true,250)
	else
		TriggerEvent("DoLongHudText","The drop off failed.",2)
	end
	
	DeleteBlip()
	if success then
		TriggerEvent("DoLongHudText", "I got the call in, delivery was on point, go await the next one! ", 1)
	else
		TriggerEvent("DoLongHudText","Drop off failed I expect better.",2)
	end

	DeleteCreatedPed()
end

function DropItemPed(ai)
    local ai = ai
    local chance = math.random(50)
    if chance > 41 then
        DropDrugs(ai,true)
    elseif chance > 35 then
        DropDrugs(ai,false)
    end
end

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

function SetRolexShopPed()
	modelHash = GetHashKey("a_m_m_genfat_02")
	RequestModel(modelHash)
	while not HasModelLoaded(modelHash) do
		Wait(1)
	end
	created_ped = CreatePed(0, modelHash , -1449.6075439453, -385.05880737305, 38.148693084717 -1, true)
	FreezeEntityPosition(created_ped, true)
	SetEntityHeading(created_ped,  35.796226501465)
	SetEntityInvincible(created_ped, true)
	SetBlockingOfNonTemporaryEvents(created_ped, true)
	TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_AA_SMOKE", 0, true)
end

Citizen.CreateThread(function()
	SetRolexShopPed()
end)