
--// Start With Axe

RegisterNetEvent('varial-start-mining')
AddEventHandler('varial-start-mining', function()
    if EvanMiningZone then
        TriggerEvent('varial-civjobs-mining')
    else
        TriggerEvent('DoLongHudText', 'You are not in the Mining Zone', 2)
    end
end)

local currentlyMining = false
local pFarmed = 0

RegisterNetEvent("varial-civjobs-mining")
AddEventHandler("varial-civjobs-mining", function()
	if exports["varial-inventory"]:hasEnoughOfItem("miningpickaxe",1,false) and not currentlyMining then 
        currentlyMining = true
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
            FreezeEntityPosition(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'))
            Citizen.Wait(200)
            local pickaxe = GetHashKey("prop_tool_pickaxe")
            
            -- Loads Pickaxe
            RequestModel(pickaxe)
            while not HasModelLoaded(pickaxe) do
            Wait(1)
            end
            
            local anim = "melee@hatchet@streamed_core_fps"
            local action = "plyr_front_takedown"
            
            -- Loads Anims
            RequestAnimDict(anim)
            while not HasAnimDictLoaded(anim) do
                Wait(1)
            end
            
            local object = CreateObject(pickaxe, coords.x, coords.y, coords.z, true, false, false)
            AttachEntityToEntity(object, playerPed, GetPedBoneIndex(playerPed, 57005), 0.1, 0.0, 0.0, -90.0, 25.0, 35.0, true, true, false, true, 1, true)
            TaskPlayAnim(PlayerPedId(), anim, action, 3.0, -3.0, -1, 31, 0, false, false, false)
            local finished = exports["varial-ui"]:taskBarSkill(5000,math.random( 200,400 ))
            if (finished == 100) then
                local finished = exports["varial-ui"]:taskBarSkill(5000,math.random( 200,400 ))
                if (finished == 100) then
                    local finished = exports["varial-ui"]:taskBarSkill(5000,math.random( 200,400 ))
                    if (finished == 100) then
                        TriggerEvent('varial-civjobs:mines-items')
                        pFarmed = pFarmed + 1    
                    else
                        TriggerEvent("DoLongHudText", "Failed", 2)
                        currentlyMining = false
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(playerPed, false)
                        DeleteObject(object)
                    
                    end
                else
                    TriggerEvent("DoLongHudText", "Failed", 2)
                    currentlyMining = false
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(playerPed, false)
                    DeleteObject(object)
                
                end        
            else
                TriggerEvent("DoLongHudText", "Failed", 2)
                currentlyMining = false
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(playerPed, false)
                DeleteObject(object)
            
            end
            currentlyMining = false
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(playerPed, false)
            DeleteObject(object)
    else
		TriggerEvent('DoLongHudText', 'You need a pickaxe to mine', 2)
    end
end)

--// Events to get items

RegisterNetEvent('varial-civjobs:mines-items', function()
    local roll = math.random(8)
        if roll == 1 then
            TriggerEvent('player:receiveItem', 'mininggem', 1)
            TriggerEvent('DoLongHudText', 'You Found A Gemstone !', 1)
        elseif roll == 2 then
            TriggerEvent('player:receiveItem', 'miningstone', math.random(1, 3))
            TriggerEvent('DoLongHudText', 'You Found Stone', 1)
        elseif roll == 3 then
            TriggerEvent('player:receiveItem', 'miningcoal', math.random(1, 5))
            TriggerEvent('DoLongHudText', 'You Found Coal', 1)
        elseif roll == 4 then
            TriggerEvent('player:receiveItem', 'miningdiamond', 1)
            TriggerEvent('DoLongHudText', 'You Found A Diamond', 1)
        elseif roll == 5 then
            TriggerEvent('player:receiveItem', 'miningsapphire', 1)
            TriggerEvent('DoLongHudText', 'You found a Sapphire', 1)
        elseif roll == 6 then
            TriggerEvent('player:receiveItem', 'miningstone', math.random(1, 3))
            TriggerEvent('DoLongHudText', 'You Found Stone', 1)
        elseif roll == 7 then
            TriggerEvent('player:receiveItem', 'mininggem', 1)
            TriggerEvent('DoLongHudText', 'You Found A Gemstone', 1)
        elseif roll == 8 then
            TriggerEvent('player:receiveItem', 'miningruby', 1)
            TriggerEvent('DoLongHudText', 'You found a Ruby', 1)
        end
    end)

--// Polyzone

EvanMiningZone = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("mining_zone", vector3(-592.1, 2075.5, 131.38), 25, 4, {
        name="mining_zone",
        heading=15,
        minZ=129.18,
        maxZ=133.18
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "mining_zone" then
        EvanMiningZone = true     
        print("^2[Varial Mining] In Zone^0")
        exports['varial-interaction']:showInteraction("Mining")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "mining_zone" then
        EvanMiningZone = false  
        print("^2[Varial Mining] Left Zone^0")  
        exports['varial-interaction']:hideInteraction()
    end
end)

--// Peds

function setMiningSalesPeds()
    modelHash = GetHashKey("a_m_y_stwhi_02")
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    created_ped = CreatePed(0, modelHash , -1463.947265625, -182.22857666016, 48.82568359375  -1, true)
    FreezeEntityPosition(created_ped, true)
    SetEntityHeading(created_ped, 34.015747070312)
    SetEntityInvincible(created_ped, true)
    SetBlockingOfNonTemporaryEvents(created_ped, true)
    TaskStartScenarioInPlace(created_ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
end

Citizen.CreateThread(function()
    setMiningSalesPeds()
end)

