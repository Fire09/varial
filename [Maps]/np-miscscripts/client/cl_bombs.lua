-- local plantedBombs = {}

-- CreateThread(function ()
--     exports["varial-interact"]:AddPeekEntryByModel({`h4_prop_h4_ld_bomb_01a`}, {
--         {
--             id = "c4_check_time",
--             event = "varial-miscscripts:bombs:checkTime",
--             icon = "stopwatch",
--             label = "Check remaining time",
--         },
--         {
--             id = "c4_cut_red",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut red wire",
--             parameters = { wire = "red" }
--         },
--         {
--             id = "c4_cut_green",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut green wire",
--             parameters = { wire = "green" }
--         },
--         {
--             id = "c4_cut_blue",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut blue wire",
--             parameters = { wire = "blue" }
--         },
--         {
--             id = "c4_cut_yellow",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut yellow wire",
--             parameters = { wire = "yellow" }
--         },
--         {
--             id = "c4_cut_purple",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut purple wire",
--             parameters = { wire = "purple" }
--         },
--         {
--             id = "c4_cut_white",
--             event = "varial-miscscripts:bombs:cut",
--             icon = "cut",
--             label = "Cut white wire",
--             parameters = { wire = "white" }
--         },
--     }, { distance = { radius = 2.5 }, isEnabled = function (pEntity)
--         local nearestBomb = getNearestBomb(GetEntityCoords(pEntity))
--         if not nearestBomb then return false end
--         return plantedBombs[nearestBomb].defused == false and plantedBombs[nearestBomb].exploded == false
--     end })
--     Wait(5000)
--     local bombs = NPX.Procedures.execute("varial-miscscripts:bombs:request")
--     plantedBombs = bombs
--     RequestAnimDict("amb@world_human_bum_wash@male@low@idle_a")
--     while not HasAnimDictLoaded("amb@world_human_bum_wash@male@low@idle_a") do
--         Wait(100)
--         RequestAnimDict("amb@world_human_bum_wash@male@low@idle_a")
--     end
-- end)

-- AddEventHandler("varial-inventory:itemUsed", function (name, info)
--     if name ~= "C4_dev" then return end

--     local wireOptions = {
--         { id = "red", name = "Red" },
--         { id = "green", name = "Green" },
--         { id = "blue", name = "Blue" },
--         { id = "yellow", name = "Yellow" },
--         { id = "purple", name = "Purple" },
--         { id = "white", name = "White" },
--         { id = "random", name = "Random :)" },
--     }

--     local elements = {
--         { name = "length", label = "Length in seconds (120-7200)", icon = "time", _type = "number" },
--         { name = "wire", label = "Wire to cut", icon = "cut", _type = "select", options = wireOptions },
--         { name = "gridSize", label = "Grid Size (5-12)", icon = "time", _type = "number" },
--         { name = "coloredSquares", label = "Colored Sqaures (5-20)", icon = "time", _type = "number" },
--         { name = "timeToComplete", label = "Time To Complete (10-30)", icon = "time", _type = "number" },
--     }

--     local prompt = exports["varial-ui"]:OpenInputMenu(elements)

--     if not prompt or not prompt.length or not prompt.wire then return end

--     local length = tonumber(prompt.length)
--     if length < 120 or length > 7200 then
--         return TriggerEvent("DoLongHudText", "Time needs to be between 120 and 7200 seconds", 2)
--     end

--     local gridSize = tonumber(prompt.gridSize)
--     if gridSize > 12 or gridSize < 5 then
--         return TriggerEvent("DoLongHudText", "Grid size must be between 5-12", 2)
--     end

--     local coloredSquares = tonumber(prompt.coloredSquares)
--     if coloredSquares > 20 or coloredSquares < 5 then
--         return TriggerEvent("DoLongHudText", "Colored Sqaures must be between 5-20", 2)
--     end

--     local timeToComplete = tonumber(prompt.timeToComplete) * 1000
--     if timeToComplete < 10000 or timeToComplete > 30000 then
--         return TriggerEvent("DoLongHudText", "Time to complete must be between 10-30 seconds", 2)
--     end

--     local coords = GetEntityCoords(PlayerPedId()) + GetEntityForwardVector(PlayerPedId())

--     TaskPlayAnim(PlayerPedId(), "amb@world_human_bum_wash@male@low@idle_a", "idle_a", 8.0, -8.0, -1, 1, 1.0, false, false, false)

--     local progress = exports["varial-taskbar"]:taskBar(30000, "Planting bomb...", true)
--     ClearPedTasks(PlayerPedId())
--     if progress ~= 100 then return end

--     local _, GroundZ = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z, 0)

--     NPX.Procedures.execute("varial-miscscripts:bombs:plant", {
--         x = coords.x,
--         y = coords.y,
--         z = GroundZ + 0.05
--     }, length, prompt.wire, gridSize, coloredSquares, timeToComplete)

--     TriggerEvent("inventory:removeItem", "C4_dev", 1)
-- end)

-- RegisterNetEvent("varial-miscscripts:bombs:setUpBomb")
-- AddEventHandler("varial-miscscripts:bombs:setUpBomb", function (index, bomb)
--     plantedBombs[index] = bomb
-- end)

-- RegisterNetEvent("varial-miscscripts:bombs:defuseCorrectBomb")
-- AddEventHandler("varial-miscscripts:bombs:defuseCorrectBomb", function (index, gridSize, coloredSquares, timeToComplete)
--     TriggerEvent("doAnim", "kneel2")

--     exports['varial-ui']:openApplication('memorygame', {
--         gameFinishedEndpoint = 'varial-miscscripts:bombs:completeHacking',
--         gameTimeoutDuration = timeToComplete or 14000,
--         coloredSquares =  coloredSquares or 10,
--         gridSize = gridSize or 5,
--         parameters = {
--           bombId = index
--         }
--       })
-- end)

-- AddEventHandler("varial-miscscripts:bombs:checkTime", function (index)
--     local nearestBomb = getNearestBomb(GetEntityCoords(PlayerPedId()))
--     if not nearestBomb then return end
--     local remaining = NPX.Procedures.execute("varial-miscscripts:bombs:remaining", nearestBomb)
--     TriggerEvent("DoLongHudText", ("Remaining time: %s  minutes and %s seconds"):format(remaining.minutes, remaining.seconds), 2)
-- end)

-- AddEventHandler("varial-miscscripts:bombs:cut", function (params)
--     if not params.wire then return false end

--     local nearestBomb = getNearestBomb(GetEntityCoords(PlayerPedId()))
--     if not nearestBomb then return false end

--     if plantedBombs[nearestBomb].defused or plantedBombs[nearestBomb].exploded then return false end

--     TriggerEvent("doAnim", "kneel2")

--     NPX.Procedures.execute('varial-miscscripts:bombs:cut', nearestBomb, params.wire)
-- end)

-- RegisterNetEvent("varial-miscscripts:bombs:defused")
-- AddEventHandler("varial-miscscripts:bombs:defused", function (index)
--     if not plantedBombs[index] then return end
--     plantedBombs[index].defused = true

--     if plantedBombs[index].soundId and plantedBombs[index].handle then 
--         exports["varial-fx"]:StopEntitySound(plantedBombs[index].handle, plantedBombs[index].soundId)
--         plantedBombs[index].handle = nil
--         plantedBombs[index].soundId = nil
--     end
-- end)

-- RegisterNetEvent("varial-miscscripts:bombs:explode")
-- AddEventHandler("varial-miscscripts:bombs:explode", function (index, bomb)
--     if not plantedBombs[index] then return false end

--     AddExplosion(
--         plantedBombs[index].coords.x,
--         plantedBombs[index].coords.y,
--         plantedBombs[index].coords.z,
--         8,
--         100.0,
--         true,
--         false,
--         0.0
--     )
-- end)

-- RegisterNetEvent("varial-miscscripts:bombs:exploded")
-- AddEventHandler("varial-miscscripts:bombs:exploded", function (index, bomb)
--     if not plantedBombs[index] then return false end
    
--     if plantedBombs[index].soundId and plantedBombs[index].handle then
--         exports["varial-fx"]:StopEntitySound(plantedBombs[index].handle, plantedBombs[index].soundId)
--         plantedBombs[index].handle = nil
--         plantedBombs[index].soundId = nil
--     end
-- end)

-- AddEventHandler("varial-objects:objectCreated", function (object, handle)
--     if object.data.model ~= `h4_prop_h4_ld_bomb_01a` then return end
--     local index = object.data.metadata.id
--     if not plantedBombs[index] then return end

--     plantedBombs[index].handle = handle
--     if plantedBombs[index].defused or plantedBombs[index].exploded then return end

--     plantedBombs[index].soundId = exports["varial-fx"]:PlayEntitySound(handle, "bomb", "DLC_NIKEZ_ROS_GENERAL", 0, "ROS_GENERAL");
-- end)

-- AddEventHandler("varial-objects:objectDeleting", function (object, handle)
--     if object.data.model ~= `h4_prop_h4_ld_bomb_01a` then return end
--     local index = object.data.metadata.id
--     if not plantedBombs[index] then return end

--     if not plantedBombs[index].soundId then return end
    
--     exports["varial-fx"]:StopEntitySound(plantedBombs[index].handle, plantedBombs[index].soundId)
--     plantedBombs[index].handle = nil
--     plantedBombs[index].soundId = nil
-- end)

-- AddEventHandler('onResourceStop', function (resource)
--     if resource ~= GetCurrentResourceName() then return end
--     for index, bomb in pairs(plantedBombs) do
--         if bomb.soundId and bomb.handle then
--             exports["varial-fx"]:StopEntitySound(bomb.handle, bomb.soundId)
--         end
--     end
-- end)

-- RegisterUICallback('varial-miscscripts:bombs:completeHacking', function(data, cb)
--     cb({ data = {}, meta = { ok = true, message = '' } })
  
--     local success = data.success
--     local bombId = data.parameters.bombId

--     TriggerServerEvent('varial-miscscripts:bombs:completedHacking', success, bombId)

--     Citizen.Wait(2000)
--     exports['varial-ui']:closeApplication('memorygame')
--   end)

-- function getNearestBomb(coords, dist)
--     if not dist then dist = 3 end
--     local nearestBomb = nil
--     local nearestDistance = nil
--     for index, bomb in pairs(plantedBombs) do
--         local distance = #(vector3(coords.x, coords.y, coords.z) - vector3(bomb.coords.x, bomb.coords.y, bomb.coords.z))
--         if not nearestDistance or distance < nearestDistance and (not bomb.exploded and not bomb.defused) then
--             nearestBomb = index
--             nearestDistance = distance
--         end
--     end
--     if not nearestDistance or nearestDistance > dist then return nil end
--     return nearestBomb
-- end
