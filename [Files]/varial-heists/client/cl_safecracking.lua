local shoprobbery = false
local safeAttempts = 0
local safeAttemptsResult = nil
local timercomplete = false
local cracked = false
local loottaken = false

safeLocations = {
	[1] =  { ['x'] = 28.26,['y'] = -1339.25,['z'] = 29.5,['h'] = 356.94, ['info'] = ' 1 safe' },
	[2] =  { ['x'] = -43.44,['y'] = -1748.46,['z'] = 29.43,['h'] = 48.64, ['info'] = ' 2 safe' },
	[3] =  { ['x'] = -709.67,['y'] = -904.19,['z'] = 19.22,['h'] = 84.34, ['info'] = ' 3 safe' },
	[4] =  { ['x'] = -1220.84,['y'] = -915.88,['z'] = 11.33,['h'] = 125.89, ['info'] = ' 4 safe' },
	[5] =  { ['x'] = 1159.78,['y'] = -314.06,['z'] = 69.21,['h'] = 99.31, ['info'] = ' 5 safe' },
	[6] =  { ['x'] = 378.08,['y'] = 333.37,['z'] = 103.57,['h'] = 338.48, ['info'] = ' 6 safe' },
	[7] =  { ['x'] = -1829.03,['y'] = 798.92,['z'] = 138.19,['h'] = 127.41, ['info'] = ' 7 safe' },
	[8] =  { ['x'] = -2959.64,['y'] = 387.16,['z'] = 14.05,['h'] = 173.43, ['info'] = ' 8 safe' },
	[9] =  { ['x'] = -3047.55,['y'] = 585.67,['z'] = 7.91,['h'] = 104.0, ['info'] = ' 9 safe' },
	[10] =  { ['x'] = -3249.92,['y'] = 1004.42,['z'] = 12.84,['h'] = 81.06, ['info'] = ' 10 safe' },
	[11] =  { ['x'] = 2549.25,['y'] = 384.91,['z'] = 108.63,['h'] = 84.09, ['info'] = ' 11 safe' },
	[12] =  { ['x'] = 1169.24,['y'] = 2717.96,['z'] = 37.16,['h'] = 266.31, ['info'] = ' 12 safe' },
	[13] =  { ['x'] = 546.42,['y'] = 2663.01,['z'] = 42.16,['h'] = 186.64, ['info'] = ' 13 safe' },
	[14] =  { ['x'] = 1959.27,['y'] = 3748.78,['z'] = 32.35,['h'] = 26.58, ['info'] = ' 14 safe' },
	[15] =  { ['x'] = 2672.89,['y'] = 3286.54,['z'] = 55.25,['h'] = 60.89, ['info'] = ' 15 safe' },
	[16] =  { ['x'] = 0.0,['y'] = 0.0,['z'] = 0.0,['h'] = 60.89, ['info'] = ' 16 safe' },
	[17] =  { ['x'] = 1707.66,['y'] = 4920.13,['z'] = 42.07,['h'] = 320.34, ['info'] = ' 17 safe' },
	[18] =  { ['x'] = 1734.69,['y'] = 6420.48,['z'] = 35.04,['h'] = 332.9, ['info'] = ' 18 safe' },
}


RegisterNetEvent("varial-heists:stores:attemptSafe")
AddEventHandler("varial-heists:stores:attemptSafe", function()
	if cracked then
		TriggerEvent("DoLongHudText", "Already Cracked", 2)
	else
		if exports['varial-inventory']:hasEnoughOfItem('safecrackingkit', 1) then
			TriggerEvent("varial-heists:stores:attemptSafe:cops")
		else 
			TriggerEvent("DoLongHudText", "You don't have the necessary item.", 2)
		end
	end
end)

RegisterNetEvent("varial-heists:stores:attemptSafe:cops")
AddEventHandler("varial-heists:stores:attemptSafe:cops", function()
	if exports["varial-duty"]:LawAmount() >= 2 then
		crackSafe()
		TriggerEvent("varial-dispatch:storerobbery2")
		TriggerServerEvent("police:camrobbery",storeid)
		TriggerEvent("client:newStress",true,200)
	else
		TriggerEvent("DoLongHudText", "Not Enough Cops.", 2)
	end
end)

RegisterNetEvent("varial-heists:store:openSafe")
AddEventHandler("varial-heists:store:openSafe", function()
	if timercomplete then
		TriggerEvent("varial-heists:store:grabloot")
	else
		TriggerEvent("DoLongHudText", "The Safe Isnt Open Yet!", 2)
	end
end)

RegisterNetEvent("varial-heists:store:grabloot")
AddEventHandler("varial-heists:store:grabloot", function()
	local storeid = isStoreRobbery()
	local mathfunc = math.random(100)
	local safeCoords = safeLocations[storeid]
	if tonumber(storeid) == tonumber(CorrectStore) then
		CorrectStore = 0
	end
	if loottaken then
		TriggerEvent("DoLongHudText", "Loot Akready Taken", 2)
	else
		if mathfunc < 25 then
			TriggerEvent("player:receiveItem","usbdevice",1)
		end
		TriggerEvent("player:receiveItem","band", math.random(20, 30))
		TriggerEvent("player:receiveItem","rollcash", math.random(30, 40))	
		loottaken = true
	end

end)


RegisterNetEvent("varial-heists:store:openCrackedSafe")
AddEventHandler("varial-heists:store:openCrackedSafe", function()
	TriggerEvent("DoLongHudText", "Safe Opened!")
	cracked = true
end)



function countDown(timeInSecond)
	Citizen.CreateThread(function()
	
		local time = timeInSecond
		print("Countdown: ".. time)

		while(time > 0) do 
			Citizen.Wait(1000)
			time = time - 1

			if(time <= 0)then
				TriggerEvent("varial-heists:store:openCrackedSafe")
				timercomplete = true
			end
			
		end

	end)
end


AddEventHandler("varial-heists:stores:openSafe", function(p1, p2, pArgs)
  local id = pArgs.zones["store_safe_target"].id
  local coords = pArgs.zones["store_safe_target"].coords
  TriggerEvent("varial-heists:store:openCrackedSafe", id, coords)
end)



--[[ function crackSafe()
 	RequestAnimDict("mini@safe_cracking")
 	while not HasAnimDictLoaded("mini@safe_cracking") do
 	  Citizen.Wait(0)
 	end
 	ClearPedTasksImmediately(PlayerPedId())
 	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_slow", 8.0, 1.0, -1, 1, -1, false, false, false)
 		exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
 			function()
 				TriggerEvent("DoLongHudText", "Sucess")
				ClearPedTasksImmediately(PlayerPedId())
				countDown(10)
 			end,
 			function ()
 				TriggerEvent("DoLongHudText", "Fail", 2)
				ClearPedTasksImmediately(PlayerPedId())
		end)
end ]]

function crackSafe()
 	RequestAnimDict("mini@safe_cracking")
 	while not HasAnimDictLoaded("mini@safe_cracking") do
 	  Citizen.Wait(0)
 	end
 	ClearPedTasksImmediately(PlayerPedId())
 	TaskPlayAnim(PlayerPedId(), "mini@safe_cracking", "dial_turn_clock_slow", 8.0, 1.0, -1, 1, -1, false, false, false)
		exports['varial-thermite']:OpenThermiteGame(function(success)
		  if success then
			TriggerEvent("DoLongHudText", "Success, Safe Will Open In A Bit")
			ClearPedTasksImmediately(PlayerPedId())
			TriggerEvent("inventory:removeItem",'safecrackingkit', 1)
			countDown(150)
			cracked = true
		  else
			TriggerEvent("DoLongHudText", "SafeCrackingKit Bent Out Of Shape!", 2)
			TriggerServerEvent("inventory:degItem", safecrackingkit,50,cid)
			ClearPedTasksImmediately(PlayerPedId())
		  end
	end)
end

RegisterNetEvent("cancelanim")
AddEventHandler("cancelanim", function()
	wait(10)
    ClearPedTasksImmediately(PlayerPedId())
end)


animsIdle = {}
animsIdle[1] = "idle_base"
animsIdle[2] = "idle_heavy_breathe"
animsIdle[3] = "idle_look_around"

animsSucceed = {}
animsSucceed[1] = "dial_turn_succeed_1"
animsSucceed[2] = "dial_turn_succeed_2"
animsSucceed[3] = "dial_turn_succeed_3"
animsSucceed[4] = "dial_turn_succeed_4"


function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function resetAnim()
	 local player = GetPlayerPed( -1 )
	ClearPedSecondaryTask(player)
end

function crackingsafeanim(animType)
    local player = GetPlayerPed( -1 )
  	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
        loadAnimDict( "mini@safe_cracking" )


        if animType == 1 then

			if IsEntityPlayingAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 3) then
				--ClearPedSecondaryTask(player)
			else
				TaskPlayAnim(player, "mini@safe_cracking", "dial_turn_anti_fast_1", 8.0, -8, -1, 49, 0, 0, 0, 0)
			end	

	    end

        if animType == 2 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsIdle[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end

        if animType == 3 then
	        TaskPlayAnim( player, "mini@safe_cracking", animsSucceed[math.floor(math.ceil(4))], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
	    end	

    end
end




function loadSafeTexture()
	RequestStreamedTextureDict( "MPSafeCracking", false );
	while not HasStreamedTextureDictLoaded( "MPSafeCracking" ) do
		Citizen.Wait(0)
	end
end

function loadSafeAudio()
	RequestAmbientAudioBank( "SAFE_CRACK", false )
end
