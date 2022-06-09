RegisterNetEvent('varial-in_n_out-make-bubbletea')
AddEventHandler('varial-in_n_out-make-bubbletea', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local finished = exports['varial-taskbar']:taskBar(2000, 'Making Bubble Tea')
    if (finished == 100) then
        TriggerEvent('player:receiveItem', 'bubbletea', 1)
        TriggerEvent('DoLongHudText', 'Successfully poured Bubble Tea', 1)
        FreezeEntityPosition(GetPlayerPed(-1),false)
    end
end)

RegisterNetEvent('varial-in_n_out-make-soft_drink')
AddEventHandler('varial-in_n_out-make-soft_drink', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local softdrink = exports['varial-taskbar']:taskBar(2000, 'Making Soft Drink')
    if (softdrink == 100) then
        TriggerEvent('player:receiveItem', 'softdrink', 1)
        TriggerEvent('DoLongHudText', 'Poured Soft Drink', 1)
        FreezeEntityPosition(GetPlayerPed(-1),false)
    end
end)

RegisterNetEvent('in-n-out_cola', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local cola = exports['varial-taskbar']:taskBar(2000, 'Making Cola')
    if (cola == 100) then
        TriggerEvent('player:receiveItem', 'cola', 1)
        TriggerEvent('DoLongHudText', 'Poured Cola', 1)
        FreezeEntityPosition(GetPlayerPed(-1),false)
    end
end)

RegisterNetEvent('varial-in_n_out-make-drinks', function()
    local myJob = exports["isPed"]:isPed("in-n-out")
    if myJob == "in-n-out" then
        TriggerEvent('varial-context:sendMenu', {
            {
                id = 0,
                header = "Make a Drink",
                txt = "",
                params = {
                    event = "",
                },
            },
            {
                id = 1,
                header = "Make Bubble Tea",
                txt = "In N Out Bubble Tea",
                params = {
                    event = "varial-in_n_out-make-bubbletea",
                },
            },
            {
                id = 2,
                header = "Make Soft Drink",
                txt = "In N Out Soft Drink",
                params = {
                    event = "varial-in_n_out-make-soft_drink",
                },
            },
            {
                id = 3,
                header = "Cola",
                txt = "In N Out Cola",
                params = {
                    event = "in-n-out_cola",
                },
            },
            {
                id = 4,
                header = "Close menu",
                txt = "Exit from menu",
                params = {
                    event = "",
                }
            },
        })
    end
end)

RegisterNetEvent('varial-jobs:in-n-out_cook-fries', function()
    if exports['varial-inventory']:hasEnoughOfItem('potato', 1) then
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local fries = exports['varial-taskbar']:taskBar(2000, 'Cooking Fries')
        if (fries == 100) then
            TriggerEvent('inventory:removeItem', 'potato', 1)
            TriggerEvent('player:receiveItem', 'fries', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        TriggerEvent('DoLongHudText', 'Missing Potatoes', 2)
    end
end)

RegisterNetEvent('varial-jobs:in_n_out-lettuce', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local lettuce = exports['varial-taskbar']:taskBar(1000, 'Grabbing Lettuce')
    if (lettuce == 100) then
        FreezeEntityPosition(GetPlayerPed(-1),false)
        TriggerEvent('player:receiveItem', 'lettuce', 1)
        TriggerEvent('DoLongHudText', 'Got Lettuce', 1)
    end
end)

RegisterNetEvent('varial-jobs:in_n_out-raw_patty', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local lettuce = exports['varial-taskbar']:taskBar(1000, 'Grabbing Raw Patty')
    if (lettuce == 100) then
        FreezeEntityPosition(GetPlayerPed(-1),false)
        TriggerEvent('player:receiveItem', 'rawpatty', 1)
        TriggerEvent('DoLongHudText', 'Got Raw Patty', 1)
    end
end)

RegisterNetEvent('varial-jobs:in_n_out-tomato', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local lettuce = exports['varial-taskbar']:taskBar(1000, 'Grabbing Tomato')
    if (lettuce == 100) then
        FreezeEntityPosition(GetPlayerPed(-1),false)
        TriggerEvent('player:receiveItem', 'tomato', 1)
        TriggerEvent('DoLongHudText', 'Got Raw Patty', 1)
    end
end)

RegisterNetEvent('varial-jobs:in_n_out-bun', function()
    local dict = 'mp_ped_interaction'
    LoadDict(dict)
    FreezeEntityPosition(GetPlayerPed(-1),true)
    TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
    local lettuce = exports['varial-taskbar']:taskBar(1000, 'Grabbing Burger Bun')
    if (lettuce == 100) then
        FreezeEntityPosition(GetPlayerPed(-1),false)
        TriggerEvent('player:receiveItem', 'bun', 1)
        TriggerEvent('DoLongHudText', 'Got Raw Patty', 1)
    end
end)

RegisterNetEvent('varial-jobs:potato')
AddEventHandler('varial-jobs:potato', function()
     local dict = 'mp_ped_interaction'
     LoadDict(dict)
     FreezeEntityPosition(GetPlayerPed(-1), true)
     TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
     local potatoe = exports['varial-taskbar']:taskBar(1000, 'Grabbing Potatoes')
     if (potatoe == 100) then
        FreezeEntityPosition(GetPlayerPed(-1), false)
        TriggerEvent('player:receiveItem', 'potato', 1)
        TriggerEvent('DoLongHudText', 'Grabbed Potatoe', 1)
     end
end)

RegisterNetEvent('varial-in_n_out-get:shit', function()
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "in-n-out" then
        TriggerEvent('varial-context:sendMenu', {
            {
                id = 0,
                header = "Ingridients",
                txt = "",
                params = {
                    event = "",
                },
            },
            {
                id = 1,
                header = "Get Lettuce",
                txt = "In N Out Lettuce",
                params = {
                    event = "varial-jobs:in_n_out-lettuce",
                },
            },
            {
                id = 2,
                header = "Get Raw Patty",
                txt = "In N Out Raw Patty",
                params = {
                    event = "varial-jobs:in_n_out-raw_patty",
                },
            },
            {
                id = 3,
                header = "Get Tomatoes",
                txt = "In N Out Tomatoe",
                params = {
                    event = "varial-jobs:in_n_out-tomato",
                },
            },
            {
                id = 4,
                header = "Get Bun",
                txt = "In N Out Burger Bun",
                params = {
                    event = "varial-jobs:in_n_out-bun",
                },
            },
            {
                id = 5,
                header = "Get Potatoe",
                txt = "In N Out Potatoe",
                params = {
                    event = "varial-jobs:potato",
                },
            },
            {
                id = 6,
                header = "Close menu",
                txt = "Exit from menu",
                params = {
                    event = "",
                }
            },
        })
    end
end)

RegisterNetEvent('varial-in_n_out-cook:burgers', function()
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "in-n-out" then
        TriggerEvent('varial-context:sendMenu', {
            {
                id = 0,
                header = "Cook Burgers",
                txt = "",
                params = {
                    event = "",
                },
            },
            {
                id = 1,
                header = "Cook Heart Stopper",
                txt = "In N Out Heart Stopper | 2x Pattys / 1x Lettuce / 1x Tomato / 1x Burger Bun",
                params = {
                    event = "varial-jobs:heart-stopper",
                },
            },
            {
                id = 2,
                header = "Cook Bleeder Burger",
                txt = "In N Out Bleeder Burger | 1x Patty / 1x Lettuce / 1x Tomato / 1x Burger Bun",
                params = {
                    event = "varial-jobs:bleeder-burger",
                },
            },
            {
                id = 3,
                header = "Cook Double Burger",
                txt = "In N Out Double Burger | 1x Patty / 1x Burger Bun",
                params = {
                    event = "varial-jobs:moneyshot",
                },
            },
            {
                id = 4,
                header = "Cook Hamburger",
                txt = "In N Out Hamburger | 1x Patty / 1x Burger Bun",
                params = {
                    event = "varial-jobs:hamburger",
                },
            },
            {
                id = 5,
                header = "Cook Raw Patty",
                txt = "In N Out Patty | 1x Raw Patty",
                params = {
                    event = "varial-jobs:raw-patty",
                },
            },
            {
                id = 6,
                header = "Close menu",
                txt = "Exit from menu",
                params = {
                    event = "",
                }
            },
        })
    end
end)

RegisterNetEvent('varial-jobs:raw-patty')
AddEventHandler('varial-jobs:raw-patty', function()
    if exports['varial-inventory']:hasEnoughOfItem('rawpatty', 1) then
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local heartstopper = exports['varial-taskbar']:taskBar(5000,'Cooking Raw Patty')
        if (heartstopper == 100) then
            TriggerEvent('inventory:removeItem', 'rawpatty', 1)
            TriggerEvent('player:receiveItem', 'patty', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        exports['varial-interaction']:showInteraction('Required Ingridients: 1x Raw Patty', 'error')
    end
end)

RegisterNetEvent('varial-jobs:heart-stopper')
AddEventHandler('varial-jobs:heart-stopper', function()
    if exports['varial-inventory']:hasEnoughOfItem('patty', 1) and exports['varial-inventory']:hasEnoughOfItem('lettuce', 1) and exports['varial-inventory']:hasEnoughOfItem('tomato', 1) and exports['varial-inventory']:hasEnoughOfItem('bun', 1) then 
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local heartstopper = exports['varial-taskbar']:taskBar(5000,'Cooking Heart Stopper')
        if (heartstopper == 100) then
            TriggerEvent('inventory:removeItem', 'patty', 2)
            TriggerEvent('inventory:removeItem', 'lettuce', 1)
            TriggerEvent('inventory:removeItem', 'tomato', 1)
            TriggerEvent('inventory:removeItem', 'bun', 1)
            TriggerEvent('player:receiveItem', 'heartstopper')
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        exports['varial-interaction']:showInteraction('Required Ingridients: 2x Pattys 1x Lettuce 1x Tomato 1x Burger Bun', 'error')
        Citizen.Wait(5000)
        exports['varial-interaction']:hideInteraction()
    end
end)

RegisterNetEvent('varial-jobs:bleeder-burger')
AddEventHandler('varial-jobs:bleeder-burger', function()
    if exports['varial-inventory']:hasEnoughOfItem('patty', 1) and exports['varial-inventory']:hasEnoughOfItem('lettuce', 1) and exports['varial-inventory']:hasEnoughOfItem('bun', 1) then
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local bleederburger = exports['varial-taskbar']:taskBar(5000, 'Cooking Bleeder Burger')
        if (bleederburger == 100) then
            TriggerEvent('inventory:removeItem', 'patty', 1)
            TriggerEvent('inventory:removeItem', 'bun', 1)
            TriggerEvent('inventory:removeItem', 'lettuce')
            TriggerEvent('player:receiveItem', 'bleederburger', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        exports['varial-interaction']:showInteraction('Required Ingridients: 1x Patty 1x Lettuce 1x Burger Bun', 'error')
        Citizen.Wait(5000)
        exports['varial-interaction']:hideInteraction()
    end
end)

RegisterNetEvent('varial-jobs:moneyshot')
AddEventHandler('varial-jobs:moneyshot', function()
    if exports['varial-inventory']:hasEnoughOfItem('patty', 1) and exports['varial-inventory']:hasEnoughOfItem('bun', 1) then
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local moneyshot = exports['varial-taskbar']:taskBar(5000, 'Cooking Moneyshot')
        if (moneyshot == 100) then
            TriggerEvent('inventory:removeItem', 'patty', 1)
            TriggerEvent('inventory:removeItem', 'bun', 1)
            TriggerEvent('player:receiveItem', 'moneyshot', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        exports['varial-interaction']:showInteraction('Required Ingridients: 1x Patty 1x Burger Bun', 'error')
        Citizen.Wait(5000)
        exports['varial-interaction']:hideInteraction()
    end
end)

RegisterNetEvent('varial-jobs:hamburger')
AddEventHandler('varial-jobs:hamburger', function()
    if exports['varial-inventory']:hasEnoughOfItem('patty', 1) and exports['varial-inventory']:hasEnoughOfItem('bun', 1) then
        local dict = 'mp_ped_interaction'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "handshake_guy_a", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local hamburger = exports['varial-taskbar']:taskBar(5000,'Cooking Hamburger')
        if (hamburger == 100) then
            TriggerEvent('inventory:removeItem', 'patty', 1)
            TriggerEvent('inventory:removeItem', 'bun', 1)
            TriggerEvent('player:receiveItem', 'hamburger', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
        end
    else
        exports['varial-interaction']:showInteraction('Required Ingridients: 1x Patty 1x Burger Bun', 'error')
        Citizen.Wait(5000)
        exports['varial-interaction']:hideInteraction()
    end
end)

RegisterNetEvent('in_n_out:cash:in')
AddEventHandler('in_n_out:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("in_n_out:update:pay", cid)
end)

RegisterNetEvent("in_n_out:get:receipt")
AddEventHandler("in_n_out:get:receipt", function(registerid)
    TriggerServerEvent('in_n_out:retreive:receipt', registerid)
end)

RegisterNetEvent("in_n_out:register")
AddEventHandler("in_n_out:register", function(registerID)
    local myJob = exports["isPed"]:isPed("myJob")
    if myJob == "in-n-out" then
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
            TriggerServerEvent("in_n_out:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)