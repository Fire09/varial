local MethTableID = 0 
local ConCoords = 0

-- RegisterCommand("+spawnmeth", function()
--     TriggerEvent("placemethtable", `bkr_prop_meth_table01a`)
-- end)

RegisterNetEvent("PlaceMethTable1")
AddEventHandler("PlaceMethTable1", function(model, coords)
    RequestModel(model)
    CreatedObjects = CreateObject(model, coords)
    FreezeEntityPosition(CreatedObjects, true)
    TriggerServerEvent("MethTable:new", model, coords)
end)

function MethTableTarget(distance)
    local Cam = GetGameplayCamCoord()
    local _, Hit, Coords, _, Entity = GetShapeTestResult(StartExpensiveSynchronousShapeTestLosProbe(Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4))
    return Coords
end

function GetCoordsFromCam(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

local hidden = false
scenes = {}
local SpawningMethTable = false
local coords = {}

RegisterNetEvent("placemethtable")
AddEventHandler("placemethtable", function(model)
    TriggerEvent("DoLongHudText", "MiddleMouseButton to Confirm the Placement of the Meth Table, DONT put in a shitlord spot, must be hidden")
    local placement = MethTableTarget()
    coords = {}
    SpawningMethTable = true

    while SpawningMethTable do
        RequestModel(model)
        DisableControlAction(0, 200, true)
        placement = MethTableTarget()
        if placement ~= nil then
            Object = model
            local objTypeKey = GetHashKey(Object)
            curObject = CreateObject(Object,placement,false,false,false)
            Citizen.Wait(0)
            DeleteObject(curObject)
            SetModelAsNoLongerNeeded(objTypeKey)
            SetEntityCollision(curObject, false)
            SetEntityCompletelyDisableCollision(curObject, false, false)
            SetEntityAlpha(Object, 0)
        end
        if IsControlJustReleased(0, 27) then
            TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_HAMMERING", 0, true)
            local finished = exports["varial-taskbar"]:taskBar(10000,"Placing Table")
            if (finished == 100) then
                ClearPedTasksImmediately(PlayerPedId())
            TriggerEvent("PlaceMethTable1", model, placement)
            TriggerEvent('DoLongHudText', 'You successfully placed a meth bench, use your 3rd eye to interact with it', 1)
            TriggerEvent('inventory:removeItem', 'methtable', 1)
            return
        end
    end
end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
        TriggerServerEvent("ReceiveMethCoords")
        break
    end
end)

local infosent = {}
local methh = {}

RegisterNetEvent("SpawnMethTable")
AddEventHandler("SpawnMethtable", function(infosent)
    
    local meth = {}

    methh = meth

    for i=1, #infosent do
        local hypermeth = infosent[i]
        --print(hypermeth['model'])
        meth[#meth+1] = {
            ['coords'] = vector3(hypermeth['x'], hypermeth['y'], hypermeth['z']),
           CreateObject(`bkr_prop_weed_table_01a`, vector3(hypermeth['x'], hypermeth['y'], hypermeth['z'])),
        }
end
    methtt = meth
end)

RegisterNetEvent('animation:meth')
AddEventHandler('animation:meth', function()
    inanimation = true
    local lPed = GetPlayerPed(-1)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
        ClearPedSecondaryTask(lPed)
    else
        TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 49, 0, 0, 0, 0)
        seccount = 4
        while seccount > 0 do
            Citizen.Wait(10000)
            FreezeEntityPosition(PlayerPedId(),false)
            seccount = seccount - 1
        end
        ClearPedSecondaryTask(lPed)
    end
    inanimation = false
end)

RegisterNetEvent('animation:pourcleaningsup')
AddEventHandler('animation:pourcleaningsup', function()
    inanimation = true
    local lPed = GetPlayerPed(-1)
    RequestAnimDict("weapon@w_sp_jerrycan")
    while not HasAnimDictLoaded("weapon@w_sp_jerrycan") do
        Citizen.Wait(0)
    end

    if IsEntityPlayingAnim(lPed, "weapon@w_sp_jerrycan", "fire", 3) then
        ClearPedSecondaryTask(lPed)
    else
        TaskPlayAnim(lPed, "weapon@w_sp_jerrycan", "fire", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        seccount = 4
        while seccount > 0 do
            Citizen.Wait(10000)
            FreezeEntityPosition(PlayerPedId(),false)
            seccount = seccount - 1
        end
        ClearPedSecondaryTask(lPed)
    end
    inanimation = false
end)


RegisterNetEvent('hyper:methtable')
AddEventHandler('hyper:methtable', function()
    TriggerEvent('DoLongHudText', 'Cooking Meth', 1)
end)

RegisterNetEvent('MethStage1')
AddEventHandler('MethStage1', function()
    if exports["varial-inventory"]:hasEnoughOfItem("cleaninggoods",5,false) then 
        TriggerEvent("animation:pourcleaningsup")
        local finished = exports["varial-taskbar"]:taskBar(7000,"Pouring Ingredients...")
            if (finished == 100) then
                Citizen.Wait(500)
                TriggerEvent("inventory:removeItem","cleaninggoods", 5)
                TriggerEvent('MethStage2')
            else 
                TriggerEvent('DoLongHudText', 'You do not have the required materials. (5x Cleaning Goods)')
            end
        end
    end)

RegisterNetEvent('MethStage2')
AddEventHandler('MethStage2', function()
    TriggerEvent("animation:meth")
        local finished = exports["varial-taskbar"]:taskBar(7500,"Mixing Ingredients...")
            if (finished == 100) then
                Citizen.Wait(500)
                TriggerEvent("MethStage3")
            end
        end)

RegisterNetEvent('MethStage3')
AddEventHandler('MethStage3', function()
    TriggerEvent("animation:meth")
        local finished = exports["varial-taskbar"]:taskBar(7500,"Bagging Meth...")
            if (finished == 100) then
                TriggerEvent("player:receiveItem", "methlabbatch", 1)
                print('finished')
            end
        end)

RegisterNetEvent('receivetable')
AddEventHandler('receivetable', function()
    TriggerEvent("player:receiveItem", "methtable", 1)
end)        
    
RegisterNetEvent('breakmeth')
AddEventHandler('breakmeth', function()
    TriggerEvent("animation:meth")
    local finished = exports["varial-taskbar"]:taskBar(7500,"Breaking Down Meth...")
        if finished == 100 then
        if exports['varial-inventory']:hasEnoughOfItem('methlabbatch', 1) then
            TriggerEvent("inventory:removeItem","methlabbatch", 1)
            TriggerEvent("player:receiveItem","methlabproduct", 10)
        end
    end
end)