local CraftbenchID = 0 
local ConCoords = 0

RegisterNetEvent("PlaceCraftbench1")
AddEventHandler("PlaceCraftbench1", function(model, coords)
    RequestModel(model)
    CreatedObjects = CreateObject(model, coords)
    FreezeEntityPosition(CreatedObjects, true)
    TriggerServerEvent("craftbench:new", model, coords)
end)

function CraftbenchTarget(distance)
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
local SpawningCraftBench = false
local coords = {}

RegisterNetEvent("varial-craftbench:place")
AddEventHandler("varial-craftbench:place", function(model)
    print("test")
    exports['varial-interaction']:showInteraction('[E] To place Bench')
    SetEntityLocallyInvisible(model, true)
    local placement = CraftbenchTarget()
    coords = {}
    SpawningCraftBench = true

    while SpawningCraftBench do
        RequestModel(model)
        DisableControlAction(0, 200, true)
        placement = CraftbenchTarget()
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
        if IsControlJustReleased(0, 38) then
            SetEntityLocallyInvisible(model, false)
            TriggerEvent("PlaceCraftbench1", model, placement)
            TriggerEvent('DoLongHudText', 'You successfully placed a craft bench, use your 3rd eye to interact with it', 1)
            TriggerEvent('inventory:removeItem', 'craftbench', 1)
            exports['varial-interaction']:hideInteraction()
            return
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1500)
    TriggerServerEvent("ReceiveCoords")
    break
    end
end)

local infosent = {}
local Crafttt = {}

RegisterNetEvent("SpawnCraftBench")
AddEventHandler("SpawnCraftBench", function(infosent)
    local varial_craft_bench = {}

    Crafttt = varial_craft_bench

    for i=1, #infosent do
        local crafting_varial_loc = infosent[i]
        -- print(crafting_varial_loc['model'])
        varial_craft_bench[#varial_craft_bench+1] = {
            ['coords'] = vector3(crafting_varial_loc['x'], crafting_varial_loc['y'], crafting_varial_loc['z']),
           CreateObject(`gr_prop_gr_bench_03b`, vector3(crafting_varial_loc['x'], crafting_varial_loc['y'], crafting_varial_loc['z'])),
        }
    end
    Crafttt = varial_craft_bench
end)

RegisterNetEvent('varial-craftbench:open')
AddEventHandler('varial-craftbench:open', function()
    print("idiot")
    local BusinessHigh = exports["cool-business"]:IsEmployedAt("tuner_shop") 
    local BusinessBBMC = exports["cool-business"]:IsEmployedAt("tuner_shop") 
    local BusinessMandem = exports["cool-business"]:IsEmployedAt("mandem") 
    local BusinessHOA = exports["cool-business"]:IsEmployedAt("tavern")
    local PermHigh = exports["cool-business"]:HasPermission("tuner_shop", "craft_access")
    local PermBBMC = exports["cool-business"]:HasPermission("tuner_shop", "craft_access")
    local PermMandem = exports["cool-business"]:HasPermission("mandem", "craft_access")
    local PermHOA = exports["cool-business"]:HasPermission("tavern", "craft_access")

    if BusinessHigh and PermHigh then
        TriggerEvent('server-inventory-open', '99653', 'Craft')
    elseif BusinessBBMC and PermBBMC then
        TriggerEvent('server-inventory-open', '0003', 'Craft')
    elseif BusinessHOA and PermHOA then
        TriggerEvent('server-inventory-open', '0005', 'Craft')
    elseif BusinessMandem and PermMandem then
        local MenuMandem = {
            {
                title = "Open Craft Bench",
                action = "open-bench",
            },
            {
                title = "Male Seeds",
                description = "Grab Male Seeds",
                action = "male-seeds:grabthem",
            },
            {
                title = "Female Seeds",
                description = "Grab Female Seeds",
                action = "female-seeds:grabthem",
            },
            {
                title = "Fertilizer",
                description = "Grab Fertilizer",
                action = "fertilizer:grabit",
            },
        }
        exports["varial-interaction"]:showContextMenu(MenuMandem)
    else
        TriggerEvent('DoLongHudText', 'Bro fuck off, this obviously is not for you dumb fuck!', 2)
    end
end)

RegisterNetEvent('varial-craftbench:open')
AddEventHandler('varial-craftbench:open', function()
    TriggerEvent('server-inventory-open', '28', 'Craft')
end)

RegisterInterfaceCallback('male-seeds:grabthem', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent( "player:receiveItem", "maleseed", 10)
end)

RegisterInterfaceCallback('female-seeds:grabthem', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent( "player:receiveItem", "femaleseed", 10)
end)

RegisterInterfaceCallback('fertilizer:grabit', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent( "player:receiveItem", "fertilizer", 10)
end)

RegisterInterfaceCallback('open-bench', function(data, cb)
    cb({ data = {}, meta = { ok = true, message = '' } })
    TriggerEvent('server-inventory-open', '0010', 'Craft')
end)