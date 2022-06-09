

--------------------------------------------------------------------------------------------------------------------

-- RegisterNetEvent('varial-civjobs:craft-lockpick')
-- AddEventHandler('varial-civjobs:craft-lockpick', function()
--     if exports['varial-inventory']:hasEnoughOfItem('steel', 2) then
--         TriggerEvent('inventory:removeItem', 'steel', 2)
--         TriggerEvent('player:receiveItem', 'lockpick', 1)
--         TriggerEvent('DoLongHudText', 'Successfully crafted Lockpick', 1)
--     else
--         TriggerEvent('DoLongHudText', 'You dont have 2x Steel', 2)
--     end
-- end)

-- RegisterNetEvent('varial-civjobs:craft-advlockpick')
-- AddEventHandler('varial-civjobs:craft-advlockpick', function()
--     if exports['varial-inventory']:hasEnoughOfItem('refinedaluminium', 15) and exports['varial-inventory']:hasEnoughOfItem('refinedplastic', 12) and exports['varial-inventory']:hasEnoughOfItem('refinedrubber', 15) then
--         TriggerEvent('inventory:removeItem', 'refinedaluminium', 15)
--         TriggerEvent('inventory:removeItem', 'refinedplastic', 12)
--         TriggerEvent('inventory:removeItem', 'refinedrubber', 15)
--         TriggerEvent('player:receiveItem', 'advlockpick', 1)
--         TriggerEvent('DoLongHudText', 'Successfully Crafted Advlockpick', 1)
--     else
--         TriggerEvent('DoLongHudText', 'You do not have the required materials', 2)
--     end
-- end)

-- RegisterNetEvent('varial-civjobs:craft-repairkit')
-- AddEventHandler('varial-civjobs:craft-repairkit', function()
--     if exports['varial-inventory']:hasEnoughOfItem('electronics', 25) then
--         TriggerEvent('inventory:removeItem', 'electronics', 25)
--         TriggerEvent('player:receiveItem', 'repairkit', 1)
--         TriggerEvent('DoLongHudText', 'Successfully crafted Repairkit', 1)
--     else
--         TriggerEvent('DoLongHudText', 'You dont have the required materials', 2)
--     end
-- end)

-- RegisterNetEvent('varial-civjobs:craft-tyre-repairkit')
-- AddEventHandler('varial-civjobs:craft-tyre-repairkit', function()
--     if exports['varial-inventory']:hasEnoughOfItem('rubber', 10) and exports['varial-inventory']:hasEnoughOfItem('steel', 3) then
--         TriggerEvent('inventory:removeItem', 'rubber', 10)
--         TriggerEvent('inventory:removeItem', 'steel', 3)
--         TriggerEvent('player:receiveItem', 'tyrerepairkit', 1)
--         TriggerEvent('DoLongHudText', 'Successfully crafted Tyre Repairkit', 1)
--     else
--         TriggerEvent('DoLongHudText', 'You dont have the required materials', 2)
--     end
-- end)

-- RegisterNetEvent('varial-jobs:mechanic-craft')
-- AddEventHandler('varial-jobs:mechanic-craft', function()
--     TriggerEvent('varial-context:sendMenu', {
--         {
--             id = 1,
--             header = "Mechanic Craft",
--             txt = ""
--         },
--         {
--             id = 2,
--             header = "Craft Lockpick",
--             txt = "Requires: 2x Steel",
--             params = {
--                 event = "varial-civjobs:craft-lockpick"
--             }
--         },
--         {
--             id = 3,
--             header = "Craft Advlockpick",
--             txt = "Requires: 15x Refined Aluminium | 12x Refined Plastic | 15x Refined Rubber",
--             params = {
--                 event = "varial-civjobs:craft-advlockpick"
--             }
--         },
--         {
--             id = 4,
--             header = "Craft Repairkit",
--             txt = "Requires: 25 Electronics",
--             params = {
--                 event = "varial-civjobs:craft-repairkit"
--             }
--         },
--         {
--             id = 5,
--             header = "Craft Tyre Repairkit",
--             txt = "Requires: 5 Rubber | 3 Steel",
--             params = {
--                 event = "varial-civjobs:craft-tyre-repairkit"
--             }
--         },
--         {
--             id = 6,
--             header = "Close",
--             txt = "Have a good day!",
--             params = {
--                 event = ""
--             }
--         },
--     })
-- end)

-----------------------------------------------------------------------------------------------------------------

--// Start Of Hayes Autos

EvanHayesAutosStash = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("hayes_autos_stash", vector3(-1415.05, -451.58, 35.91), 1, 4.6, {
        name="hayes_autos_stash",
        heading=30,
        --debugPoly=false,
        minZ=33.11,
        maxZ=37.11
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "hayes_autos_stash" then
        EvanHayesAutosStash = true     
        HayesAutosStash()
            local rank = exports["isPed"]:GroupRank("hayes_autos")
            if rank > 1 then 
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "hayes_autos_stash" then
        EvanHayesAutosStash = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function HayesAutosStash()
	Citizen.CreateThread(function()
        while EvanHayesAutosStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("hayes_autos")
                    if rank > 1 then 
                    TriggerEvent('varial-jobs:hayes_mechanic-shop')
                end
			end
		end
	end)
end

RegisterNetEvent('varial-jobs:hayes_mechanic-shop')
AddEventHandler('varial-jobs:hayes_mechanic-shop', function()
    local job = exports["isPed"]:GroupRank('hayes_autos')
    if job >= 2 then
		TriggerEvent("server-inventory-open", "1", "storage-hayes_autos")
		Wait(1000)
	end
end)

--// Crafting

--// Hayes

EvanCraftingHayesAutos = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_crafting_hayes_autos", vector3(-1408.39, -447.37, 35.91), 1, 5.4, {
        name="varial_crafting_hayes_autos",
        heading=30,
        --debugPoly=true,
        minZ=33.31,
        maxZ=37.31
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_crafting_hayes_autos" then
        EvanCraftingHayesAutos = true     
            local rank = exports["isPed"]:GroupRank("hayes_autos")
            if rank > 1 then 
            TunerShopCraft()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)



RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_crafting_hayes_autos" then
        EvanCraftingHayesAutos = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function TunerShopCraft()
	Citizen.CreateThread(function()
        while EvanCraftingHayesAutos do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("hayes_autos")
                    if rank > 0 then 
                    TriggerEvent('server-inventory-open', '27', 'Craft')
                end
			end
		end
	end)
end

-- --// Tuner Shop

-- VarialTunerCraft = false

-- Citizen.CreateThread(function()
--     exports["varial-polyzone"]:AddBoxZone("varial_crafting_tuner_shop", vector3(144.39, -3050.88, 7.04), 4, 1.4, {
--         name="varial_crafting_tuner_shop",
--         heading=270,
--         --debugPoly=true,
--         minZ=5.44,
--         maxZ=9.44
--     })
-- end)

-- RegisterNetEvent('varial-polyzone:enter')
-- AddEventHandler('varial-polyzone:enter', function(name)
--     if name == "varial_crafting_tuner_shop" then
--         VarialTunerCraft = true     
--             local rank = exports["isPed"]:GroupRank("tuner_shop")
--             if rank > 1 then 
--             TunerShopCrafting()
--             exports['varial-interaction']:showInteraction("[E] Craft")
--         end
--     end
-- end)

-- RegisterNetEvent('varial-polyzone:exit')
-- AddEventHandler('varial-polyzone:exit', function(name)
--     if name == "varial_crafting_tuner_shop" then
--         VarialTunerCraft = false
--         exports['varial-interaction']:hideInteraction()
--     end
-- end)

-- function TunerShopCrafting()
-- 	Citizen.CreateThread(function()
--         while VarialTunerCraft do
--             Citizen.Wait(5)
-- 			if IsControlJustReleased(0, 38) then
--                     local rank = exports["isPed"]:GroupRank("tuner_shop")
--                     if rank > 1 then 
--                     TriggerEvent('server-inventory-open', '27', 'Craft')
--                 end
-- 			end
-- 		end
-- 	end)
-- end

--// Harmony Craft

EvanHarmonyCraft = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_harmony_craft", vector3(1176.22, 2635.66, 37.75), 2, 3.6, {
        name="varial_harmony_craft",
        heading=0,
        --debugPoly=true,
        minZ=35.35,
        maxZ=39.35
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_harmony_craft" then
        EvanHarmonyCraft = true     
            local rank = exports["isPed"]:GroupRank("harmony_autos")
            if rank > 1 then 
            HarmonyShopCrafting()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_harmony_craft" then
        EvanHarmonyCraft = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function HarmonyShopCrafting()
	Citizen.CreateThread(function()
        while EvanHarmonyCraft do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("harmony_autos")
                    if rank > 1 then 
                    TriggerEvent('server-inventory-open', '27', 'Craft')
                end
			end
		end
	end)
end

--// Harmony Stash

EvanHarmony = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("harmony_mec_stash", vector3(1186.97, 2637.56, 38.44), 2, 2.0, {
        name="harmony_mec_stash",
        heading=0,
        --debugPoly=true,
        minZ=35.84,
        maxZ=39.84
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "harmony_mec_stash" then
        EvanHarmony = true     
            local rank = exports["isPed"]:GroupRank("harmony_autos")
            if rank > 1 then 
            HarmonyStash()
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "harmony_mec_stash" then
        EvanHarmony = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function HarmonyStash()
	Citizen.CreateThread(function()
        while EvanHarmony do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("harmony_autos")
                    if rank > 1 then 
                    TriggerEvent("server-inventory-open", "1", "storage-harmony")
                end
			end
		end
	end)
end


-- // Racing Place Shit

EvanRacingPartyTingInnit = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("racing_shit_like_southside_innit", vector3(1001.21, -2553.71, 32.87), 1, 4, {
        name="racing_shit_like_southside_innit",
        heading=355,
        --debugPoly=true,
        minZ=29.87,
        maxZ=33.87
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "racing_shit_like_southside_innit" then
        EvanRacingPartyTingInnit = true     
        RacingLocationWarehouseStash()
            local rank = exports["isPed"]:GroupRank("illegal_shop")
            if rank > 3 then 
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "racing_shit_like_southside_innit" then
        EvanRacingPartyTingInnit = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function RacingLocationWarehouseStash()
	Citizen.CreateThread(function()
        while EvanRacingPartyTingInnit do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("illegal_shop")
                    if rank > 3 then 
                    TriggerEvent("server-inventory-open", "1", "storage-racing-shit")
                end
			end
		end
	end)
end

--// Craft

EvanCraftingRacePlace = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_racing_warehouse_craft", vector3(1046.79, -2531.53, 28.29), 1.5, 4, {
        name="varial_racing_warehouse_craft",
        heading=265,
        --debugPoly=true,
        minZ=25.29,
        maxZ=29.29
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_racing_warehouse_craft" then
        EvanCraftingRacePlace = true     
            local rank = exports["isPed"]:GroupRank("illegal_shop")
            if rank > 3 then 
            print(rank)
            RacingPlaceCraft()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_racing_warehouse_craft" then
        EvanCraftingRacePlace = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function RacingPlaceCraft()
	Citizen.CreateThread(function()
        while EvanCraftingRacePlace do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("illegal_shop")
                    if rank > 3 then 
                    TriggerEvent('server-inventory-open', '60', 'Craft')
                end
			end
		end
	end)
end

--// Auto Exotics

CraftingAutoExotics = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_crafting_autoexotics", vector3(546.62, -166.76, 54.49), 3, 2, {
        name="varial_crafting_autoexotics",
        heading=600,
        --debugPoly=true,
        minZ=52,
        maxZ=59
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_crafting_autoexotics" then
        CraftingAutoExotics = true     
        local rank = exports["isPed"]:GroupRank("auto_exotics")
        if rank > 0 then 
            AutoExoticsCrafting()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_crafting_autoexotics" then
        CraftingAutoExotics = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function AutoExoticsCrafting()
	Citizen.CreateThread(function()
        while CraftingAutoExotics do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("auto_exotics")
                if rank > 0 then 
                print("?")
                TriggerEvent('autos:crafting')
                end
			end
        end
	end)
end

--// Autos Exotics Stash

AutosStash = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("autoexotics_stash", vector3(544.93, -201.7, 54.49), 2, 2, {
        name="autoexotics_stash",
        heading=0,
       -- debugPoly=true,
        minZ=52.04,
        maxZ=62.04
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "autoexotics_stash" then
        AutosStash = true     
        AutoExoticStash()
            local rank = exports["isPed"]:GroupRank("auto_exotics")
            if rank > 1 then 
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "autoexotics_stash" then
        AutosStash = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function AutoExoticStash()
	Citizen.CreateThread(function()
        while AutosStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("auto_exotics")
                if rank > 0 then 
                    TriggerEvent('auto_exotic:stash')
                end
			end
		end
	end)
end

RegisterNetEvent('auto_exotic:stash')
AddEventHandler('auto_exotic:stash', function()
    local rank = exports["isPed"]:GroupRank("auto_exotics")
     if rank > 0 then 
		TriggerEvent("server-inventory-open", "1", "storage-auto-exotics")
		Wait(1000)
	end
end)


--// Ottos Autos Stash
OttosStash = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("ottos_stash", vector3(836.82, -808.38, 26.33), 2, 2, {
        name="ottos_stash",
        heading=0,
        --debugPoly=true,
        minZ=22,
        maxZ=32
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "ottos_stash" then
        OttosStash = true     
        OttosAutosStash()
            local rank = exports["isPed"]:GroupRank("ottos_autos")
            if rank > 0 then 
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "ottos_stash" then
        OttosStash = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function OttosAutosStash()
	Citizen.CreateThread(function()
        while OttosStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("ottos_autos")
                if rank > 0 then 
                    TriggerEvent('ottos_autos:stash')
                end
			end
		end
	end)
end

RegisterNetEvent('ottos_autos:stash')
AddEventHandler('ottos_autos:stash', function()
    local rank = exports["isPed"]:GroupRank("ottos_autos")
    if rank > 0 then 
		TriggerEvent("server-inventory-open", "1", "storage-auto-autos")
		Wait(1000)
	end
end)

--// Ottos Autos Crafting

CraftingOttosAutos= false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_crafting_ottoautos", vector3(837.68, -814.65, 26.35), 4, 2, {
        name="varial_crafting_ottoautos",
        heading=254.8,
        --debugPoly=true,
        minZ=24.35,
        maxZ=27.35
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_crafting_ottoautos" then
        CraftingOttosAutos= true     
        local rank = exports["isPed"]:GroupRank("ottos_autos")
        if rank > 0 then 
            OttosAutosCrafting()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_crafting_ottoautos" then
        CraftingOttosAutos= false
        exports['varial-interaction']:hideInteraction()
    end
end)

function OttosAutosCrafting()
	Citizen.CreateThread(function()
        while CraftingOttosAutos do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("ottos_autos")
                if rank > 0 then 
               
                TriggerEvent('ottos:crafting')
                end
			end
        end
	end)
end

--// Tuner Shop Stash

-- EvanTunerShopDoc = false

-- Citizen.CreateThread(function()
--     exports["varial-polyzone"]:AddBoxZone("tuner_shop_docs_stash", vector3(128.46, -3014.08, 7.04), 2.5, 2.5, {
--         name="tuner_shop_docs_stash",
--         heading=0,
--       --  debugPoly=false,
--         minZ=5.04,
--         maxZ=9.04
--     })
-- end)

-- RegisterNetEvent('varial-polyzone:enter')
-- AddEventHandler('varial-polyzone:enter', function(name)
--     if name == "tuner_shop_docs_stash" then
--         EvanTunerShopDoc = true     
--         TunerShopStash()
--             local rank = exports["isPed"]:GroupRank("tuner_shop")
--             if rank > 1 then 
--             exports['varial-interaction']:showInteraction("[E] Stash")
--         end
--     end
-- end)

-- RegisterNetEvent('varial-polyzone:exit')
-- AddEventHandler('varial-polyzone:exit', function(name)
--     if name == "tuner_shop_docs_stash" then
--         EvanTunerShopDoc = false
--         exports['varial-interaction']:hideInteraction()
--     end
-- end)

-- function TunerShopStash()
-- 	Citizen.CreateThread(function()
--         while EvanTunerShopDoc do
--             Citizen.Wait(5)
-- 			if IsControlJustReleased(0, 38) then
--                  local rank = exports["isPed"]:GroupRank("tuner_shop")
--                     if rank > 1 then    
--                     TriggerEvent('tuner_shop_doc_stash')
--                 end
-- 			end
-- 		end
-- 	end)
-- end

-- RegisterNetEvent('tuner_shop_doc_stash')
-- AddEventHandler('tuner_shop_doc_stash', function()
--     local rank = exports["isPed"]:GroupRank("tuner_shop")
--      if rank > 0 then 
-- 		TriggerEvent("server-inventory-open", "1", "storage-tuner-docs")
-- 		Wait(1000)
-- 	end
-- end)

RegisterNetEvent('tuner_shop_doc_craft')
AddEventHandler('tuner_shop_doc_craft', function()
    local rank = exports["isPed"]:GroupRank("tuner_shop")
     if rank > 1 then 
		TriggerEvent('server-inventory-open', '7777', 'Craft')
		Wait(1000)
	end
end)


--// Tuner Shot Crafting

-- CraftingTunerShop= false

-- Citizen.CreateThread(function()
--     exports["varial-polyzone"]:AddBoxZone("varial_crafting_tunershop", vector3(128.57, -3008.36, 7.04), 2.5, 2.5, {
--         name="varial_crafting_tunershop",
--         heading=254.8,
--       --  debugPoly=true,
--         minZ=6,
--         maxZ=9
--     })
-- end)

-- RegisterNetEvent('varial-polyzone:enter')
-- AddEventHandler('varial-polyzone:enter', function(name)
--     if name == "varial_crafting_tunershop" then
--         CraftingTunerShop= true     
--         local rank = exports["isPed"]:GroupRank("tuner_shop")
--         if rank > 0 then 
--             TunerShopCrafting()
--             exports['varial-interaction']:showInteraction("[E] Craft")
--         end
--     end
-- end)

-- RegisterNetEvent('varial-polyzone:exit')
-- AddEventHandler('varial-polyzone:exit', function(name)
--     if name == "varial_crafting_tunershop" then
--         CraftingTunerShop= false
--         exports['varial-interaction']:hideInteraction()
--     end
-- end)

-- function TunerShopCrafting()
-- 	Citizen.CreateThread(function()
--         while CraftingTunerShop do
--             Citizen.Wait(5)
-- 			if IsControlJustReleased(0, 38) then
--                 local rank = exports["isPed"]:GroupRank("tuner_shop")
--                 if rank > 0 then 
               
--                 TriggerEvent('tunershop:crafting')
--                 end
-- 			end
--         end
-- 	end)
-- end





--// ak_customs Stash

AkCustoms = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("ak_customs_stash", vector3(937.69, -985.74, 39.5), 7, 2.5, {
        name="ak_customs_stash",
        heading=97.32,
      --debugPoly=true,
        minZ=35.04,
        maxZ=49.04
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "ak_customs_stash" then
        AkCustoms = true     
        AkCustomsStash()
            local rank = exports["isPed"]:GroupRank("ak_customs")
            if rank > 1 then 
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "ak_customs_stash" then
        AkCustoms = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function AkCustomsStash()
	Citizen.CreateThread(function()
        while AkCustoms do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                 local rank = exports["isPed"]:GroupRank("ak_customs")
                    if rank > 1 then    
                    TriggerEvent('akcustoms_stash')
                end
			end
		end
	end)
end

RegisterNetEvent('akcustoms_stash')
AddEventHandler('akcustoms_stash', function()
    local rank = exports["isPed"]:GroupRank("ak_customs")
     if rank > 0 then 
		TriggerEvent("server-inventory-open", "1", "storage-akcustoms")
		Wait(1000)
	end
end)



--// Ak Customs Crafting

Craftingak_customs= false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_crafting_ak_customs", vector3(947.82, -970.29, 39.5), 4, 1.5, {
        name="varial_crafting_ak_customs",
        heading=0,
        --debugPoly=true,
        minZ=38.5,
        maxZ=44.5
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_crafting_ak_customs" then
        Craftingak_customs= true     
        local rank = exports["isPed"]:GroupRank("ak_customs")
        if rank > 0 then 
            ak_customsCrafting()
            exports['varial-interaction']:showInteraction("[E] Craft")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_crafting_ak_customs" then
        Craftingak_customs= false
        exports['varial-interaction']:hideInteraction()
    end
end)

function ak_customsCrafting()
	Citizen.CreateThread(function()
        while Craftingak_customs do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("ak_customs")
                if rank > 0 then 
               
                TriggerEvent('ak_customs:crafting')
                end
			end
        end
	end)
end