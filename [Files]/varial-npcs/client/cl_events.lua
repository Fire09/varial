RegisterNetEvent("varial-npcs:set:ped")
AddEventHandler("varial-npcs:set:ped", function(pNPCs)
  if type(pNPCs) == "table" then
    for _, ped in ipairs(pNPCs) do
      RegisterNPC(ped, 'varial-npcs')
      EnableNPC(ped.id)
    end
  else
    RegisterNPC(ped, 'varial-npcs')
    EnableNPC(ped.id)
  end
end)

RegisterNetEvent("varial-npcs:ped:giveStolenItems")
AddEventHandler("varial-npcs:ped:giveStolenItems", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local npcCoords = GetEntityCoords(pEntity)
  local finished = exports["varial-taskbar"]:taskBar(15000, "Preparing to receive goods, don't move.")
  if finished == 100 then
    if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
      TriggerEvent("server-inventory-open", "1", "Stolen-Goods-1")
    else
      TriggerEvent("DoLongHudText", "You moved too far you idiot.", 2)
    end
  end
end)

RegisterNetEvent("varial-npcs:ped:exchangeRecycleMaterial")
AddEventHandler("varial-npcs:ped:exchangeRecycleMaterial", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local npcCoords = GetEntityCoords(pEntity)
  local finished = exports["varial-taskbar"]:taskBar(3000, "Preparing to exchange material, don't move.")
  if finished == 100 then
    if #(GetEntityCoords(PlayerPedId()) - npcCoords) < 2.0 then
      TriggerEvent("server-inventory-open", "141", "Craft");
    else
      TriggerEvent("DoLongHudText", "You moved too far you idiot.", 2)
    end
  end
end)

RegisterNetEvent("varial-npcs:ped:signInJob")
AddEventHandler("varial-npcs:ped:signInJob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  if #pArgs == 0 then
    local npcId = DecorGetInt(pEntity, 'NPC_ID')
    if npcId == `news_reporter` then
      TriggerServerEvent("jobssystem:jobs", "news")
    elseif npcId == `head_stripper` then
      TriggerServerEvent("jobssystem:jobs", "entertainer")
    end
  else
    TriggerServerEvent("jobssystem:jobs", "unemployed")
  end
end)

RegisterNetEvent("varial-npcs:ped:paycheckCollect")
AddEventHandler("varial-npcs:ped:paycheckCollect", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerServerEvent("server:paySlipPickup")
end)

RegisterNetEvent("varial-npcs:ped:receiptTradeIn")
AddEventHandler("varial-npcs:ped:receiptTradeIn", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local cid = exports["isPed"]:isPed("cid")
  RPC.execute("ab-inventory:tradeInReceipts", cid, accountTarget)
end)

RegisterNetEvent("varial-npcs:ped:sellStolenItems")
AddEventHandler("varial-npcs:ped:sellStolenItems", function()
  RPC.execute("ab-inventory:sellStolenItems")
end)

RegisterNetEvent("varial-npcs:ped:keeper")
AddEventHandler("varial-npcs:ped:keeper", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  TriggerEvent("server-inventory-open", pArgs[1], "Shop");
end)


TriggerServerEvent("varial-npcs:location:fetch")

AddEventHandler("varial-npcs:ped:weedSales", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  local result, message = RPC.execute("varial-npcs:weedShopOpen")
  if not result then
    TriggerEvent("DoLongHudText", message, 2)
    return
  end
  TriggerEvent("server-inventory-open", "44", "Shop");
end)

AddEventHandler("varial-npcs:ped:licenseKeeper", function()
  RPC.execute("varial-npcs:purchaseDriversLicense")
end)

AddEventHandler("varial-npcs:ped:openDigitalDenShop", function()
  TriggerEvent("server-inventory-open", "42073", "Shop")
end)
RegisterNetEvent("varial-npcs:ped:giveidcard")
AddEventHandler("varial-npcs:ped:giveidcard", function()
  RPC.execute("varial-npcs:idcard")
end)

RegisterNetEvent("varial-npcs:ped:garbagejob")
AddEventHandler("varial-npcs:ped:garbagejob", function(pArgs, pEntity, pEntityFlags, pEntityCoords)
  RPC.execute("varial-npcs:GarbageVals")
end)


