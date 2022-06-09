-- Stash

VoidPizzeriaStash = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("maldinis_stash", vector3(813.61, -749.35, 26.78), 2, 1.2, {
        name="maldinis_stash",
        heading=0,
        --debugPoly=true,
        minZ=24.38,
        maxZ=28.38
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "maldinis_stash" then
        VoidPizzeriaStash = true     
        local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
        if rank > 1 then 
            EvanMaldinisStash()
            exports['varial-interaction']:showInteraction("[E] Stash")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "maldinis_pizzeria" then
        VoidPizzeriaStash = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function EvanMaldinisStash()
	Citizen.CreateThread(function()
        while VoidPizzeriaStash do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
                if rank > 1 then 
                    TriggerEvent('server-inventory-open', '1', 'maldinis-stash')
                end
			end
		end
	end)
end

RegisterNetEvent('varial-pizzeria:open_safe')
AddEventHandler('varial-pizzeria:open_safe', function()
    local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
    if rank > 4 then 
        TriggerEvent('server-inventory-open', '1', 'safe-maldinis')
    else
        TriggerEvent('DoLongHudText', 'You dont got access to this', 2)
    end
end)

-- Registers

RegisterNetEvent("varial_maldinis:get:receipt")
AddEventHandler("varial_maldinis:get:receipt", function(registerid)
    TriggerServerEvent('voirp_maldinis:retreive:receipt', registerid)
end)

RegisterNetEvent("varial_maldinis:register")
AddEventHandler("varial_maldinis:register", function(registerID)
    local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
    if rank > 0 then 
        local order = exports["varial-applications"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("void_maldinis:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

--// Trade In Recipt

VoidMaldinisTrade = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("void_maldinis_trade", vector3(796.21, -766.77, 31.27), 2, 2, {
        name="void_maldinis_trade",
        heading=0,
        --debugPoly=true,
        minZ=28.87,
        maxZ=32.87
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "void_maldinis_trade" then
        VoidMaldinisTrade = true     
        BurgerShotReceipts()
            local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
            if rank >= 1 then 
            exports['varial-interaction']:showInteraction("[E] Trade In Receipts")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "void_maldinis_trade" then
        VoidMaldinisTrade = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function BurgerShotReceipts()
	Citizen.CreateThread(function()
        while VoidMaldinisTrade do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("maldinis_pizzeria")
                    if rank >= 1 then 
                    TriggerEvent('varial_maldinis:cash:in')
                end
			end
		end
	end)
end

RegisterNetEvent('varial_maldinis:cash:in')
AddEventHandler('varial_maldinis:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("varial_maldinis:update:pay", cid)
end)