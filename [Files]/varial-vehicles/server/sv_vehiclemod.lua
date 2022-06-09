-- local plateChanges = {}

-- local function findPlate(plate)
--     for k,v in pairs(plateChanges) do
--         if plate == v then
--             return k
--         end
--     end
--     return nil
-- end

-- RegisterServerEvent("vehicleMod:changePlate")
-- AddEventHandler("vehicleMod:changePlate", function(newPlate, isFake, oldPlate)
--     if isFake then
--         plateChanges[newPlate] = oldPlate
--     else
--         local tempPlate = findPlate(newPlate)
--         if tempPlate ~= nil then
--             plateChanges[tempPlate] = nil
--         end
--     end
-- end)

-- RegisterServerEvent("carhud:ejection:server")
-- AddEventHandler("carhud:ejection:server", function(value)
--     TriggerClientEvent("carhud:ejection:client", source, value)
-- end)

-- RegisterServerEvent("NetworkNos")
-- AddEventHandler("NetworkNos", function()
--     local pSrc = source
--     TriggerClientEvent("NetworkNos", tonumber(pSrc))
-- end)

