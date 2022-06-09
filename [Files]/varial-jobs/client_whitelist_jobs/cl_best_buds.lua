RegisterNetEvent('varial-jobs:CraftJoints')
AddEventHandler('varial-jobs:CraftJoints', function(args)
    if exports['varial-inventory']:hasEnoughOfItem('weedq', args.weedAmount) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['varial-taskbar']:taskBar(math.random(5000, 7000), args.pBar)
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', args.craftItem, 1)
        end
    else
        TriggerEvent("DoLongHudText", "I do not have enough weedq", 2)
    end
end)

RegisterNetEvent('varial-jobs:CraftEdibles')
AddEventHandler('varial-jobs:CraftEdibles', function(args)
    if exports['varial-inventory']:hasEnoughOfItem('weedq', args.weedAmount) then
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TriggerEvent("animation:PlayAnimation","cokecut")
        local finished = exports['varial-taskbar']:taskBar(math.random(7500, 10000), args.pBar)
        if (finished == 100) then
            TriggerEvent("inventory:removeItem","weedq", 1)
            Wait(1000)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            TriggerEvent('player:receiveItem', args.craftItem, 1)
        end
    else
        TriggerEvent("DoLongHudText", "I do not have enough weedq", 2)
    end
end)

RegisterNetEvent('varial-jobs:CraftJointsMenu')
AddEventHandler('varial-jobs:CraftJointsMenu', function()
    TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "LS Confidential",
            txt = "Roll 2g LS Confidential Joint",
            params = {
                event = "varial-jobs:CraftJoints",
                args = {
                    weedAmount = 1,
                    craftItem = 'lsconfidentialjoint',
                    pBar = 'Crafting LS Confidential',
                },
            }
        },
        {
            id = 2,
            header = "Alaskan Thunder Fuck",
            txt = "Roll 2g Alaskan Thunder Fuck Joint",
            params = {
                event = "varial-jobs:CraftJoints",
                args = {
                    weedAmount = 1,
                    craftItem = 'alaskanthunderfuckjoint',
                    pBar = 'Alaskan Thunder Fuck',
                },
            }
        },
        {
            id = 3,
            header = "Chiliad Kush",
            txt = "Roll 2g Chiliad Kush Joint",
            params = {
                event = "varial-jobs:CraftJoints",
                args = {
                    weedAmount = 1,
                    craftItem = 'chiliadkushjoint',
                    pBar = 'Chiliad Kush',
                },
            }
        },
    })
end)

RegisterNetEvent("varial-jobs:EdiblesMenu")
AddEventHandler("varial-jobs:EdiblesMenu", function()
    TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Cannabis Brownies",
            txt = "Make a batch of brownies",
            params = {
                event = "varial-jobs:CraftEdibles",
                args = {
                    weedAmount = 1,
                    craftItem = 'cbrownie',
                    pBar = 'Making Cannabis Brownies',
                },
            }
        },
        {
            id = 2,
            header = "Cannabis Absinthe",
            txt = "Make some cannabis absinthe",
            params = {
                event = "varial-jobs:CraftEdibles",
                args = {
                    weedAmount = 1,
                    craftItem = 'cabsinthe',
                    pBar = 'Making Cannabis Absinthe',
                },
            }
        },
        {
            id = 3,
            header = "Cannabis Gummies",
            txt = "Make a batch of gummies",
            params = {
                event = "varial-jobs:CraftEdibles",
                args = {
                    weedAmount = 1,
                    craftItem = 'cgummies',
                    pBar = 'Making Cannabis Gummies',
                },
            }
        },
        {
            id = 4,
            header = "420 Bar",
            txt = "Make some chocolate",
            params = {
                event = "varial-jobs:CraftEdibles",
                args = {
                    weedAmount = 1,
                    craftItem = '420bar',
                    pBar = 'Making 420 Bar',
                },
            }
        },
    })
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent("best_buds:pay")
AddEventHandler("best_buds:pay", function(amount)
    TriggerServerEvent("server:GroupPayment","best_buds", amount)
end)

RegisterNetEvent("best_buds:register")
AddEventHandler("best_buds:register", function(registerID)
    local rank = exports["isPed"]:GroupRank("cosmic_cannabis")
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
            TriggerServerEvent("best_buds:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("best_buds:get:receipt")
AddEventHandler("best_buds:get:receipt", function(registerid)
    TriggerServerEvent('best_buds:retreive:receipt', registerid)
end)

RegisterNetEvent('best_buds:openStash')
AddEventHandler('best_buds:openStash', function()
    local rank = exports["isPed"]:GroupRank("cosmic_cannabis")
    if rank > 3 then 
        TriggerEvent("server-inventory-open", "1", "cosmic_cannabis")
    end
end)

RegisterNetEvent('best_buds:openCounter')
AddEventHandler('best_buds:openCounter', function()
    TriggerEvent("server-inventory-open", "1", "cosmic_counter")
end)

--// Trade In Recipt

CCTradeIn = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("cc_reciepts", vector3(180.03, -252.4, 54.07), 3, 3, {
        name="cc_reciepts",
        heading=340,
        --debugPoly=true,
        minZ=51.27,
        maxZ=55.27
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "cc_reciepts" then
        CCTradeIn = true     
        CCTradeReciept()
            local rank = exports["isPed"]:GroupRank("cosmic_cannabis")
            if rank >= 1 then 
            exports['varial-interaction']:showInteraction("[E] Trade In Receipts")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "cc_reciepts" then
        CCTradeIn = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function CCTradeReciept()
	Citizen.CreateThread(function()
        while CCTradeIn do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("cosmic_cannabis")
                    if rank >= 1 then 
                    TriggerEvent('varial-best_buds:trade_in')
                end
			end
		end
	end)
end

RegisterNetEvent('varial-best_buds:trade_in')
AddEventHandler('varial-best_buds:trade_in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("varial-jobs:best_buds:update:pay", cid)
end)

-- Trays

RegisterNetEvent("varial-bestbuds_tray1")
AddEventHandler("varial-bestbuds_tray1", function()
    TriggerEvent("server-inventory-open", "1", "cosmic-table-1");
end)

RegisterNetEvent("varial-best_buds:tray_2")
AddEventHandler("varial-best_buds:tray_2", function()
    TriggerEvent("server-inventory-open", "1", "cosmic-table-2");
end)

