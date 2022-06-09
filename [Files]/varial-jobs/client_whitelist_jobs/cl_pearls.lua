RegisterNetEvent("varial-pearls:CutBoard")
AddEventHandler("varial-pearls:CutBoard", function()
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Bass",
            txt = "Skin Bass",
            params = {
                event = "varial-pearls:skinnedFood",
                args = {
                    food = 'bass'
                }
            }
            },
        {
            id = 2,
            header = "Salmon",
            txt = "Clean up Salmon",
            params = {
                    event = "varial-pearls:skinnedFood",
                    args = {
                        food = 'salmon'
                    }
                }
            },
        {
            id = 3,
            header = "Marlin",
            txt = "Skin Marlin",
            params = {
                    event = "varial-pearls:skinnedFood",
                    args = {
                        food = 'marlin'
                    }
                }
            },
            {
            id = 4,
            header = "Shark",
            txt = "Skin Shark",
            params = {
                    event = "varial-pearls:skinnedFood",
                    args = {
                        food = 'shark'
                    }
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
    end
end)

RegisterNetEvent("varial-pearls:pots")
AddEventHandler("varial-pearls:pots", function()
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Crab",
            txt = "Drop Crap in pan",
            params = {
                    event = "varial-pearls:cookedFood",
                    args = {
                        food = 'crab'
                    }
                }
            },
            {
            id = 2,
            header = "Shrimp",
            txt = "Drop Shrimp in pan",
            params = {
                    event = "varial-pearls:cookedFood",
                    args = {
                        food = 'shrimp'
                    }
                }
            },
            {
            id = 3,
            header = "Salmon",
            txt = "Cook Salmon",
            params = {
                    event = "varial-pearls:cookedFood",
                    args = {
                        food = 'salmon'
                    }
                }
            },
            {
            id = 4,
            header = "Shark",
            txt = "Cook Shark",
            params = {
                    event = "varial-pearls:cookedFood",
                    args = {
                        food = 'shark'
                    }
                }
            },
            {
            id = 5,
            header = "Rice",
            txt = "Cook Rice",
            params = {
                    event = "varial-pearls:cookedFood",
                    args = {
                        food = 'rice'
                    }
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
    end
end)

RegisterNetEvent("varial-pearls:plate")
AddEventHandler("varial-pearls:plate", function()
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Plate Shrimp",
            txt = "Shrimp Cocktail",
            params = {
                    event = "varial-pearls:plateFood",
                    args = {
                        food = 'shrimp'
                    }
                }
            },
            {
            id = 2,
            header = "Plate Bass",
            txt = "Bass Sushi",
            params = {
                    event = "varial-pearls:plateFood",
                    args = {
                        food = 'bass'
                    }
                }
            },
            {
            id = 3,
            header = "Plate Salmon",
            txt = "Salmon Dish",
            params = {
                    event = "varial-pearls:plateFood",
                    args = {
                        food = 'salmon'
                    }
                }
            },
            {
            id = 4,
            header = "Plate Marlin",
            txt = "Marlin Sushi",
            params = {
                    event = "varial-pearls:plateFood",
                    args = {
                        food = 'marlin'
                    }
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
    end
end)

RegisterNetEvent("varial-pearls:drink")
AddEventHandler("varial-pearls:drink", function()
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Grab Water",
            txt = "Pour glass of water",
            params = {
                    event = "varial-pearls:plateDrink",
                    args = {
                        food = 'water'
                    }
                }
            },
            {
            id = 2,
            header = "Grab Coke",
            txt = "Pour glass of coke",
            params = {
                    event = "varial-pearls:plateDrink",
                    args = {
                        food = 'coke'
                    }
                }
            },
            {
            id = 3,
            header = "Grab Tea",
            txt = "Pour glass of tea",
            params = {
                    event = "varial-pearls:plateDrink",
                    args = {
                        food = 'tea'
                    }
                }
            },
        })
    else
        TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
    end
end)

RegisterNetEvent("varial-pearls:skinnedFood")
AddEventHandler("varial-pearls:skinnedFood", function(data)
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        if data.food == 'bass' then
            if exports["varial-inventory"]:hasEnoughOfItem('bass',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local PedCoords = GetEntityCoords(GetPlayerPed(-1))
                prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
                AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
                SetEntityHeading(GetPlayerPed(-1), 59.52755355835)
                local finished = exports['varial-taskbar']:taskBar(10000, 'Skinning Bass')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'skinnedbass', math.random(1, 2))
                    TriggerEvent("inventory:removeItem",'bass', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough bass to proccess!', 2)
            end
        elseif data.food == 'salmon' then 
            if exports["varial-inventory"]:hasEnoughOfItem('salmon',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local PedCoords = GetEntityCoords(GetPlayerPed(-1))
                prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
                AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
                SetEntityHeading(GetPlayerPed(-1), 59.52755355835)
                local finished = exports['varial-taskbar']:taskBar(10000, 'Skinning Salmon')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'skinnedsalmon', math.random(1, 2))
                    TriggerEvent("inventory:removeItem",'salmon', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough salmon to proccess!', 2)
            end
        elseif data.food == 'marlin' then 
            if exports["varial-inventory"]:hasEnoughOfItem('marlin',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local PedCoords = GetEntityCoords(GetPlayerPed(-1))
                prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
                AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
                SetEntityHeading(GetPlayerPed(-1), 59.52755355835)
                local finished = exports['varial-taskbar']:taskBar(10000, 'Skinning Marlin')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'skinnedmarlin', math.random(1, 2))
                    TriggerEvent("inventory:removeItem",'marlin', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough marlin to proccess!', 2)
            end
        elseif data.food == 'shark' then 
            if exports["varial-inventory"]:hasEnoughOfItem('shark',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local PedCoords = GetEntityCoords(GetPlayerPed(-1))
                prop = CreateObject(GetHashKey('prop_knife'),PedCoords.x, PedCoords.y,PedCoords.z, true, true, true)
                AttachEntityToEntity(prop, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 0xDEAD), 0.13, 0.14, 0.09, 40.0, 0.0, 0.0, false, false, false, false, 2, true)
                SetEntityHeading(GetPlayerPed(-1), 59.52755355835)
                local finished = exports['varial-taskbar']:taskBar(10000, 'Skinning Shark')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'skinnedshark', math.random(1, 2))
                    TriggerEvent("inventory:removeItem",'shark', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough shark to proccess!', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
        end
    end
end)

RegisterNetEvent("varial-pearls:cookedFood")
AddEventHandler("varial-pearls:cookedFood", function(data)
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        if data.food == 'crab' then
            if exports["varial-inventory"]:hasEnoughOfItem('crab',1,false) then
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
                local finished = exports["varial-taskbar"]:taskBar(20000,"Cooking Crab",false,false,ped)
                if (finished == 100) then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    TriggerEvent("player:receiveItem",'cookedcrab', 1)
                    TriggerEvent("inventory:removeItem",'crab', 1)
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have any crab to cook!', 2)
            end
        elseif data.food == 'shrimp' then
            if exports["varial-inventory"]:hasEnoughOfItem('shrimp',1,false) then
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
                local finished = exports["varial-taskbar"]:taskBar(12000,"Cooking Shrimp",false,false,ped)
                if (finished == 100) then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    TriggerEvent("player:receiveItem",'cookedshrimp', 1)
                    TriggerEvent("inventory:removeItem",'shrimp', 1)
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have any shrimp to cook!', 2)
            end
        elseif data.food == 'salmon' then
            if exports["varial-inventory"]:hasEnoughOfItem('skinnedsalmon',1,false) then
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
                local finished = exports["varial-taskbar"]:taskBar(12000,"Cooking Shrimp",false,false,ped)
                if (finished == 100) then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    TriggerEvent("player:receiveItem",'cookedsalmon', 1)
                    TriggerEvent("inventory:removeItem",'skinnedsalmon', 1)
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have any skinnedsalmon to cook!', 2)
            end
        elseif data.food == 'shark' then
            if exports["varial-inventory"]:hasEnoughOfItem('skinnedshark',1,false) then
                TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
                local finished = exports["varial-taskbar"]:taskBar(20000,"Cooking Shark Fin Soup",false,false,ped)
                if (finished == 100) then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    TriggerEvent("player:receiveItem",'cookedshark', 1)
                    TriggerEvent("inventory:removeItem",'skinnedshark', 1)
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have any skinnedshark to cook!', 2)
            end
        elseif data.food == 'rice' then
            TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BBQ", 0, true)
            local finished = exports["varial-taskbar"]:taskBar(20000,"Cooking Rice",false,false,ped)
            if (finished == 100) then
                ClearPedTasksImmediately(GetPlayerPed(-1))
                TriggerEvent("player:receiveItem",'cookedrice', 1)
            end
        else
            TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
        end
    end
end)

RegisterNetEvent("varial-pearls:plateFood")
AddEventHandler("varial-pearls:plateFood", function(data)
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        if data.food == 'shrimp' then
            if exports["varial-inventory"]:hasEnoughOfItem('cookedshrimp',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local finished = exports['varial-taskbar']:taskBar(10000, 'Plating Shrimp Cocktail')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'platedshrimp', 1)
                    TriggerEvent("inventory:removeItem",'cookedshrimp', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough cookedshrimp to plate!', 2)
            end
        elseif data.food == 'bass' then
            if exports["varial-inventory"]:hasEnoughOfItem('skinnedbass',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local finished = exports['varial-taskbar']:taskBar(10000, 'Plating Bass Sushi')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'platedbass', 1)
                    TriggerEvent("inventory:removeItem",'skinnedbass', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough skinnedbass to plate!', 2)
            end
        elseif data.food == 'salmon' then
            if exports["varial-inventory"]:hasEnoughOfItem('cookedsalmon',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local finished = exports['varial-taskbar']:taskBar(10000, 'Plating Salmon')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'platedsalmon', 1)
                    TriggerEvent("inventory:removeItem",'cookedsalmon', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough cookedsalmon to plate!', 2)
            end
        elseif data.food == 'marlin' then
            if exports["varial-inventory"]:hasEnoughOfItem('skinnedmarlin',1,false) then
                local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
                LoadDict(dict)
                FreezeEntityPosition(GetPlayerPed(-1),true)
                TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
                local finished = exports['varial-taskbar']:taskBar(10000, 'Plating Marlin Sushi')
                if (finished == 100) then
                    TriggerEvent("player:receiveItem",'platedmarlin', 1)
                    TriggerEvent("inventory:removeItem",'skinnedmarlin', 1)
                    FreezeEntityPosition(GetPlayerPed(-1),false)
                    DeleteEntity(prop)
                    ClearPedTasks(GetPlayerPed(-1))
                    Citizen.Wait(1000)
                    TriggerEvent("animation:PlayAnimation","layspike")
                end
            else
                TriggerEvent('DoLongHudText', 'You do not have enough skinnedmarlin to plate!', 2)
            end
        else
            TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
        end
    end    
end)

RegisterNetEvent("varial-pearls:plateDrink")
AddEventHandler("varial-pearls:plateDrink", function(data)
    if data.food == 'water' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(5000, 'Grabbing Water')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'water', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
        end
    elseif data.food == 'coke' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(5000, 'Grabbing Soda')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'cola', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
        end
    elseif data.food == 'tea' then
        local dict = 'anim@amb@business@coc@coc_unpack_cut_left@'
        LoadDict(dict)
        FreezeEntityPosition(GetPlayerPed(-1),true)
        TaskPlayAnim(GetPlayerPed(-1), dict, "coke_cut_v1_coccutter", 3.0, -8, -1, 63, 0, 0, 0, 0 )
        local finished = exports['varial-taskbar']:taskBar(10000, 'Making Cup of Tea')
        if (finished == 100) then
            TriggerEvent("player:receiveItem",'tea', 1)
            FreezeEntityPosition(GetPlayerPed(-1),false)
            DeleteEntity(prop)
            ClearPedTasks(GetPlayerPed(-1))
            Citizen.Wait(1000)
            TriggerEvent("animation:PlayAnimation","layspike")
        end
    end
end)

function LoadDict(dict)
    RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
	  	Citizen.Wait(10)
    end
end

RegisterNetEvent("varial-peals:addBill")
AddEventHandler("varial-peals:addBill", function(amount)
    TriggerServerEvent("server:GroupPayment","pearls", amount)
end)

RegisterNetEvent("varial-pearls:openFridge")
AddEventHandler("varial-pearls:openFridge", function()
    local pPerals = exports["isPed"]:GroupRank("pearls")
    if pPerals >= 1 then
        TriggerEvent("server-inventory-open", "1", "pearls-fridge")
        Wait(100)
    else
        TriggerEvent('DoLongHudText', 'You are not a pearls employee!', 2)
    end
end)

RegisterNetEvent("pearls:register")
AddEventHandler("pearls:register", function(registerID)
    local rank = exports["isPed"]:GroupRank("pearls")
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
            TriggerServerEvent("pearls:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("pearls:get:receipt")
AddEventHandler("pearls:get:receipt", function(registerid)
    TriggerServerEvent('pearls:retreive:receipt', registerid)
end)

RegisterNetEvent("pearls:pay")
AddEventHandler("pearls:pay", function(amount)
    TriggerServerEvent("server:GroupPayment","pearls", amount)
end)

local nearPackcheck = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("peals_paycheck", vector3(-1840.56, -1189.82, 14.32), 1.0, 2.4, {
		name="peals_paycheck",
		heading=330,
    }) 
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "peals_paycheck" then
        local rank = exports["isPed"]:GroupRank("pearls")
		if rank > 0 then 
            nearPackcheck = true
            PearlsReceipts()
			exports['varial-interaction']:showInteraction(("[E] %s"):format("Trade In Receipts"))
        end
    end
end)


RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "peals_paycheck" then
        nearPackcheck = false
    end
    exports['varial-interaction']:hideInteraction()
end)

function PearlsReceipts()
	Citizen.CreateThread(function()
        while nearPackcheck do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("pearls")
                    if rank > 0 then 
                    TriggerEvent('pearls:cash:in')
                end
			end
		end
	end)
end

RegisterNetEvent('pearls:cash:in')
AddEventHandler('pearls:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("pearls:update:pay", cid)
end)