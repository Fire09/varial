local nearCraft = false

-- Citizen.CreateThread(function()
--     exports["varial-polyzone"]:AddBoxZone("gun_craft", vector3(39.77, -2687.81, 6.01), 1.8, 2.4, {
--         name="gun_craft",
--         heading=0,
--         --debugPoly=true,
--         minZ=2.16,
--         maxZ=7.56
--     })
-- end)

-- RegisterNetEvent('varial-polyzone:enter')
-- AddEventHandler('varial-polyzone:enter', function(name)
--     if name == "gun_craft" then
--             nearCraft = true
--             AtGunCraft()
-- 			exports['varial-interaction']:showInteraction(("[E] %s"):format("Open Crafting Bench"))
--     end
-- end)

-- RegisterNetEvent('varial-polyzone:exit')
-- AddEventHandler('varial-polyzone:exit', function(name)
--     if name == "gun_craft" then
--         nearCraft = false
--     end
--     exports['varial-interaction']:hideInteraction()
-- end)

-- function AtGunCraft()
-- 	Citizen.CreateThread(function()
--         while nearCraft do
--             Citizen.Wait(1)
--                 if IsControlJustReleased(0, 38) then
--                     -- print('hi')
--                     TriggerEvent("server-inventory-open", "31", "Craft")
--             end
--         end
--     end)
-- end

-- function AtGunCraft()
-- 	Citizen.CreateThread(function()
--         while nearCraft do
--             Citizen.Wait(1)
--             local job = exports["isPed"]:isPed("myJob")
--             if job == 'police' then
--                 if IsControlJustReleased(0, 38) then
--                     TriggerEvent('server-inventory-open", "31", "Craft')
--                 end
--             end
--         end
--     end)
-- end

RegisterNetEvent('varial-crafting:openWCraftMenu')
AddEventHandler('varial-crafting:openWCraftMenu', function()
        TriggerEvent('varial-context:sendMenu', {
            {
                id = 1,
                header = "Glock 18C",
                txt = "75x Aluminium | 30x Steel | 40x Plastic",
                params = {
                    event = "craft:glock18c"
                }
            },
            {
            	id = 2,
            	header = "M70",
            	txt = "90x Aluminium | 10x Steel | 25x Plastic | 30x Scrap Metal",
            	params = {
            		event = "craft:m70"
            	}
            },
            -- {
            -- 	id = 3,
            -- 	header = "Police Charger",
            -- 	txt = "Purchase for $120,000",
            -- 	params = {
            -- 		event = "varial-garages:PurchasedCharger"
            -- 	}
            -- },
            -- {
            -- 	id = 4,
            -- 	header = "Police Corvette (HEAT Unit)",
            -- 	txt = "Purchase for $175,000",
            -- 	params = {
            -- 		event = "varial-garages:PurchasedCorvette"
            -- 	}
            -- },
            -- {
            -- 	id = 5,
            -- 	header = "Police Mustang (HEAT Unit)",
            -- 	txt = "Purchase for $175,000",
            -- 	params = {
            -- 		event = "varial-garages:PurchasedMustang"
            -- 	}
            -- },
            -- {
            -- 	id = 6,
            -- 	header = "Police Challenger (HEAT Unit)",
            -- 	txt = "Purchase for $175,000",
            -- 	params = {
            -- 		event = "varial-garages:PurchasedChallenger"
            -- 	}
            -- },
	})
end)

RegisterNetEvent('craft:glock18c')
AddEventHandler('craft:glock18c', function()
    if exports['varial-inventory']:hasEnoughOfItem('aluminium', 75) and hasEnoughOfItem('steel', 30) then
    TriggerEvent("inventory:removeItem","aluminium", 75)
    TriggerEvent("inventory:removeItem","steel", 30)
    TriggerEvent("player:receiveItem","glock18c", 1)
    else
        TriggerEvent('DoLongHudText', "You do not have enough materials!", 2)
    end
end)

RegisterNetEvent('craft:m70')
AddEventHandler('craft:m70', function()
    if exports['varial-inventory']:hasEnoughOfItem('aluminium', 90) and hasEnoughOfItem('steel', 10) and hasEnoughOfItem('plastic', 25) and hasEnoughOfItem('scrapmetal', 30)then
    TriggerEvent("inventory:removeItem","aluminium", 90)
    TriggerEvent("inventory:removeItem","steel", 10)
    TriggerEvent("inventory:removeItem","plastic", 25)
    TriggerEvent("inventory:removeItem","scrapmetal", 30)
    TriggerEvent("player:receiveItem","m70", 1)
    else
        TriggerEvent('DoLongHudText', "You do not have enough materials!", 2)
    end
end)