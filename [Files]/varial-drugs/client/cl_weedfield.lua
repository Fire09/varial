local Cooldown = false
local PickingWeed = false

-- Picking Weed Event

RegisterNetEvent('varial-weed:pick_field')
AddEventHandler('varial-weed:pick_field', function()
    if not PickingWeed then
        if not Cooldown then
            PickingWeed = true
            Cooldown = true
            TriggerEvent('animation:PlayAnimation', 'kneel')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Picking Weed')
            if finished == 100 then
                PickingWeed = false
                TriggerEvent('player:receiveItem', 'wetbud', math.random(1, 3))
                TriggerEvent('DoLongHudText', 'Picked Wet Bud', 1)
                TriggerEvent('animation:PlayAnimation', 'e c')
                Citizen.Wait(5000)
                Cooldown = false
            end
        else
            TriggerEvent('DoLongHudText', 'You aint skilled enough for this wait a few more seconds', 2)
        end
    end
end)

-- Polyzone Pick

EvanWeedField = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("void_weed_field", vector3(-903.07, 3822.22, 376.43), 5, 18.4, {
        name="void_weed_field",
        heading=355,
        -- debugPoly=true,
        minZ=361.69,
        maxZ=385.69
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "void_weed_field" then
        EvanWeedField = true     
        EvanWeedPick()
		exports['varial-interaction']:showInteraction("[E] Pick Weed")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "void_weed_field" then
        EvanWeedField = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function EvanWeedPick()
	Citizen.CreateThread(function()
        while EvanWeedField do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                TriggerEvent('varial-weed:pick_field')
			end
		end
	end)
end

-- Polyzone Dry

EvanWeedDry = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("void_weed_field_dry", vector3(448.15, 5553.73, 781.54), 10, 10, {
        name="void_weed_field_dry",
        heading=0,
        --debugPoly=true,
        minZ=771,
        maxZ=786.29
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "void_weed_field_dry" then
        EvanWeedDry = true     
        VoidWeedDry()
		exports['varial-interaction']:showInteraction("[E] Dry Bud")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "void_weed_field_dry" then
        EvanWeedDry = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function VoidWeedDry()
	Citizen.CreateThread(function()
        while EvanWeedDry do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                TriggerEvent('varial-drugs:dry_bud')
			end
		end
	end)
end

RegisterNetEvent('varial-drugs:dry_bud')
AddEventHandler('varial-drugs:dry_bud', function()
    if exports['varial-inventory']:hasEnoughOfItem('wetbud', 1) then
        local finished = exports['varial-taskbar']:taskBar(5000, 'Drying Bud')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('wetbud', 1) then
                TriggerEvent('inventory:removeItem', 'wetbud', 1)
                TriggerEvent('DoLongHudText', 'Dried Bud', 1)
                TriggerEvent('player:receiveItem', 'driedbud', 1)
            end
        end
    else
        TriggerEvent('DoLongHudText', 'You dont have any bud to dry', 2)
    end
end)

-- Polyzone Sell

VoidWeedSales = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("void_weed_sell", vector3(-1171.7, -1571.79, 4.37), 3, 3, {
        name="void_weed_sell",
        heading=35,
        -- debugPoly=true,
        minZ=1.37,
        maxZ=5.37
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "void_weed_sell" then
        VoidWeedSales = true     
        VoidWeedSell()
		exports['varial-interaction']:showInteraction("[E] Sell Bud")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "void_weed_sell" then
        VoidWeedSales = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function VoidWeedSell()
	Citizen.CreateThread(function()
        while VoidWeedSales do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                if exports['varial-inventory']:hasEnoughOfItem('driedbud', 1) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    local finished = exports['varial-taskbar']:taskBar(5000, 'Selling Bud')
                    if finished == 100 then
                        if exports['varial-inventory']:hasEnoughOfItem('driedbud', 1) then
                            FreezeEntityPosition(PlayerPedId(), false)
                            TriggerEvent('inventory:removeItem', 'driedbud', 1)
                            TriggerServerEvent('varial-drugs:weed_sell')
                        end
                    end
                else
                    TriggerEvent('DoLongHudText', 'You dont got any Dried Bud to sell', 2)
                end
			end
		end
	end)
end
