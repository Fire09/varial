RegisterNetEvent("varial-musicrecord:CraftDrinks")
AddEventHandler("varial-musicrecord:CraftDrinks", function(data)
    if data.food == 'whiskey' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(5000, 'Pouring Cold Whiskey')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'whiskey', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
    elseif data.food == 'vodka' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(5000, 'Pouring Cold Vodka')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'vodka', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)

        end
    elseif data.food == 'beer' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(10000, 'Pouring a cold one for the boys..')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'beer', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
        end
    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent("varial-music:addBill")
AddEventHandler("varial-music:addBill", function(amount)
    TriggerServerEvent("server:GroupPayment","rockford_records", amount)
end)

RegisterNetEvent("varial-musicrecord:RegisterPaymentMenu")
AddEventHandler("varial-musicrecord:RegisterPaymentMenu", function()
    local isMusicEmply = exports["isPed"]:GroupRank("rockford_records")
    if isMusicEmply >= 1 then
        local valid = exports["varial-applications"]:KeyboardInput({
            header = "Cash Register",
            rows = {
                {
                    id = 0,
                    txt = "Player ID"
                },
                {
                    id = 1,
                    txt = "Enter Cost"
                },
            }
        })
        if valid then
            TriggerServerEvent("varial-musicrecord:registerPay", valid[1].input, valid[2].input)
        end
    else
        TriggerEvent('DoLongHudText', 'You are not a rockford records employee!', 2)
    end
end)

RegisterNetEvent("varial-musicrecord:ConfirmOrder")
AddEventHandler("varial-musicrecord:ConfirmOrder", function(orderAmount)
    local valid = exports["varial-applications"]:KeyboardInput({
        header = "Do you confirm your order of $" ..orderAmount,
        rows = {
            {
                id = 0,
                txt = "Yes to accept or No to decline"
            },
        }
    })
    if valid then
        TriggerServerEvent("varial-musicrecord:registerConfirm", valid[1].input)
        local confirmationMan = tostring(valid[1].input)
        local confirmationMan = string.lower(confirmationMan)
        if confirmationMan == "yes" then
            playerAnim()
            TriggerEvent('DoLongHudText', 'Your payment is being processed!', 1)
            Citizen.Wait(5000)
            ClearPedTasksImmediately(PlayerPedId())
        elseif confirmationMan == "no" then
            TriggerEvent('DoLongHudText', 'Transaction Canceled!', 2)
        end
    end
end)

RegisterNetEvent("varial-musicrecord:openFridge")
AddEventHandler("varial-musicrecord:openFridge", function()
    local isMusicEmply = exports["isPed"]:GroupRank("rockford_records")
    if isMusicEmply >= 1 then
        TriggerEvent("server-inventory-open", "1", "rockford-fridge")
        Wait(100)
    else
        TriggerEvent('DoLongHudText', 'You are not a rockford records employee!', 2)
    end
end)

RegisterNetEvent('varial-music:tray1')
AddEventHandler('varial-music:tray1', function()   
	TriggerEvent("server-inventory-open", "1", "Pickup Tray 1")
end)

RegisterNetEvent('varial-music:tray2')
AddEventHandler('varial-music:tray2', function()   
	TriggerEvent("server-inventory-open", "1", "Pickup Tray 2")
end)

RegisterNetEvent('OpenSnack:StoreRockford')
AddEventHandler('OpenSnack:StoreRockford', function()
    TriggerEvent("server-inventory-open", "69421", "Shop")
end)


RegisterNetEvent("varial-musicrecord:snackmenu")
AddEventHandler("varial-musicrecord:snackmenu", function()
    local isMusicEmply = exports["isPed"]:GroupRank("rockford_records")
    if isMusicEmply >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Open Refrigerator",
            txt = "Opens refrigerator",
            params = {
                    event = "varial-musicrecord:openFridge",
                }
            },

            {
            id = 2,
            header = "Open Snack Shop",
            txt = "Get some snacks",
            params = {
                    event = "OpenSnack:StoreRockford",
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a rockford records employee!', 2)
    end
end)



RegisterNetEvent("varial-musicrecord:drink")
AddEventHandler("varial-musicrecord:drink", function()
    local isMusicEmply = exports["isPed"]:GroupRank("rockford_records")
    if isMusicEmply >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Brew Whiskey",
            txt = "Pour glass of whiskey",
            params = {
                    event = "varial-musicrecord:CraftDrinks",
                    args = {
                        food = 'whiskey'
                    }
                }
            },
            {
            id = 2,
            header = "Brew Vodka",
            txt = "Pour glass of vodka",
            params = {
                    event = "varial-musicrecord:CraftDrinks",
                    args = {
                        food = 'vodka'
                    }
                }
            },
            {
            id = 3,
            header = "Brew Beer",
            txt = "Pour glass of beer",
            params = {
                    event = "varial-musicrecord:CraftDrinks",
                    args = {
                        food = 'beer'
                    }
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a rockford records employee!', 2)
    end
end)



local nearBar = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("fridge_rockford", vector3(-993.68, -257.52, 39.04), 2.0, 1.0, {
        name="fridge_rockford",
        heading=145,
    })
end)


RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "fridge_rockford" then
            nearBar = true
            OpenDMenu()
			exports['varial-interaction']:showInteraction(("[E] %s"):format("Refrigerator/Snacks"))
        end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "fridge_rockford" then
        nearBar = false
    end
    exports['varial-interaction']:hideInteraction()
end)

function OpenDMenu()
	Citizen.CreateThread(function()
        while nearBar do
            Citizen.Wait(5)
                local isMusicEmply = exports["isPed"]:GroupRank("rockford_records")
                if isMusicEmply >= 1 then
                    if IsControlJustReleased(0, 38) then
                    TriggerEvent('varial-musicrecord:snackmenu')
                    end
                end
            end
    end)
end
