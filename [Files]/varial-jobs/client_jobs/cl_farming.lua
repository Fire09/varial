local BaleAmount = 0

local haybaleName = 'haybale'
local haybaleAmount = '1'

local bale1 = false
local bale2 = false
local bale3 = false
local bale4 = false
local bale5 = false
local bale6 = false
local bale7 = false
local bale8 = false
local bale9 = false
local bale10 = false
local bale11 = false
local bale12 = false
local bale13 = false
local bale14 = false
local bale15 = false
local bale16 = false
local bale17 = false
local bale18 = false

CurrentlyOnJob = false

-- Functions

function DeleteBlip(blip)
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
	end
end

-- Farming Job

exports["varial-polytarget"]:AddBoxZone("varial_farming_job_start", vector3(2564.66, 4680.08, 34.08), 0.8, 1.4, {
    heading=44,
    minZ=31.28,
    maxZ=35.28,
})

-- Farming Job

exports["varial-interact"]:AddPeekEntryByPolyTarget("varial_farming_job_start", {{
    event = "skay-farming:get_Bales",
    id = "varial_farming_job_start",
    icon = "circle",
    label = "Start Farming Job",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

RegisterNetEvent('skay-farming:get_Bales')
AddEventHandler('skay-farming:get_Bales', function()
    local HaybaleAmount = math.random(1, 9)
    if HaybaleAmount == 1 then
    if not CurrentlyOnJob then
        CreateHayBaleBlip1()
        CreateHayBaleBlip2()
        CurrentlyOnJob = true
        bale1 = true
        bale2 = true
        TriggerEvent('DoLongHudText', 'I marked Bale 1 and 2 on your GPS with a blip go and collect them', 1)
        BaleAmount = 2
        TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
        if not BaleAmount then
            TriggerEvent('phone:addJobNotify', 'Job Completed!')
        end
    else
        TriggerEvent('DoLongHudText', 'You already have a job active', 2)
    end
    elseif HaybaleAmount == 2 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip3()
            CreateHayBaleBlip4()
            CurrentlyOnJob = true
            bale3 = true
            bale4 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 3 and 4 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 3 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip5()
            CreateHayBaleBlip6()
            CurrentlyOnJob = true
            bale5 = true
            bale6 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 5 and 6 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 4 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip7()
            CreateHayBaleBlip8()
            CurrentlyOnJob = true
            bale7 = true
            bale8 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 7 and 8 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2 
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 5 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip9()
            CreateHayBaleBlip10()
            CurrentlyOnJob = true
            bale9 = true
            bale10 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 9 and 10 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 6 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip11()
            CreateHayBaleBlip12()
            CurrentlyOnJob = true
            bale11 = true
            bale12 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 11 and 12 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 7 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip13()
            CreateHayBaleBlip14()
            CurrentlyOnJob = true
            bale13 = true
            bale14 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 13 and 14 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 8 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip15()
            CreateHayBaleBlip16()
            CurrentlyOnJob = true
            bale15 = true
            bale16 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 15 and 16 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    elseif HaybaleAmount == 9 then
        if not CurrentlyOnJob then
            CreateHayBaleBlip17()
            CreateHayBaleBlip18()
            CurrentlyOnJob = true
            bale17 = true
            bale18 = true
            TriggerEvent('DoLongHudText', 'I marked Bale 17 and 18 on your GPS with a blip go and collect the bale', 1)
            BaleAmount = 2
            TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
            if not BaleAmount then
                TriggerEvent('phone:addJobNotify', 'Job Completed!')
            end
        else
            TriggerEvent('DoLongHudText', 'You already have a job active', 2)
        end
    end
    end)

-- Bale 1

exports["varial-polytarget"]:AddBoxZone("bale1", vector3(2612.26, 4636.43, 33.8), 1.6, 2.0, {
    heading=330,
    minZ=30.8,
    maxZ=34.8
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale1", {{
    event = "varial-farming:grab_bale_1",
    id = "bale1",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale1
    end,
});

RegisterNetEvent('varial-farming:grab_bale_1')
AddEventHandler('varial-farming:grab_bale_1', function()
    if bale1 then
        bale1 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 2

exports["varial-polytarget"]:AddBoxZone("bale2", vector3(2619.22, 4640.27, 34.48), 2, 1.6, {
    heading=30,
    minZ=31.48,
    maxZ=35.48
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale2", {{
    event = "varial-farming:grab_bale_2",
    id = "bale2",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale2
    end,
});

RegisterNetEvent('varial-farming:grab_bale_2')
AddEventHandler('varial-farming:grab_bale_2', function()
    if bale2 then
        bale2 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 3

exports["varial-polytarget"]:AddBoxZone("bale3", vector3(2590.86, 4608.87, 33.74), 2, 1.6, {
    heading=235,
    minZ=30.54,
    maxZ=34.54
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale3", {{
    event = "varial-farming:grab_bale_3",
    id = "bale3",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale3
    end,
});

RegisterNetEvent('varial-farming:grab_bale_3')
AddEventHandler('varial-farming:grab_bale_3', function()
    if bale3 then
        bale3 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 4

exports["varial-polytarget"]:AddBoxZone("bale4", vector3(2612.77, 4615.12, 34.26), 2, 1.6, {
    heading=25,
    minZ=30.86,
    maxZ=34.86
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale4", {{
    event = "varial-farming:grab_bale_4",
    id = "bale4",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale4
    end,
});

RegisterNetEvent('varial-farming:grab_bale_4')
AddEventHandler('varial-farming:grab_bale_4', function()
    if bale4 then
        bale4 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 5

exports["varial-polytarget"]:AddBoxZone("bale5", vector3(2617.51, 4607.79, 34.14), 2, 1.6, {
    heading=290,
    minZ=31.14,
    maxZ=35.14
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale5", {{
    event = "varial-farming:grab_bale_5",
    id = "bale5",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale5
    end,
});

RegisterNetEvent('varial-farming:grab_bale_5')
AddEventHandler('varial-farming:grab_bale_5', function()
    if bale5 then
        bale5 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 6

exports["varial-polytarget"]:AddBoxZone("bale6", vector3(2611.09, 4596.94, 33.87), 2, 1.6, {
    heading=30,
    minZ=31.27,
    maxZ=35.27
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale6", {{
    event = "varial-farming:grab_bale_6",
    id = "bale6",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale6
    end,
});

RegisterNetEvent('varial-farming:grab_bale_6')
AddEventHandler('varial-farming:grab_bale_6', function()
    if bale6 then
        bale6 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 7

exports["varial-polytarget"]:AddBoxZone("bale7", vector3(2604.99, 4592.58, 34.2), 2, 1.6, {
    heading=325,
    minZ=30.8,
    maxZ=34.8
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale7", {{
    event = "varial-farming:grab_bale_7",
    id = "bale7",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale7
    end,
});

RegisterNetEvent('varial-farming:grab_bale_7')
AddEventHandler('varial-farming:grab_bale_7', function()
    if bale7 then
        bale7 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)


-- Bale 8

exports["varial-polytarget"]:AddBoxZone("bale8", vector3(2627.14, 4595.53, 35.31), 2, 1.6, {
    heading=60,
    minZ=32.31,
    maxZ=36.31
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale8", {{
    event = "varial-farming:grab_bale_8",
    id = "bale8",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale8
    end,
});

RegisterNetEvent('varial-farming:grab_bale_8')
AddEventHandler('varial-farming:grab_bale_8', function()
    if bale8 then
        bale8 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 9

exports["varial-polytarget"]:AddBoxZone("bale9", vector3(2622.53, 4572.54, 35.82), 2, 1.6, {
    heading=50,
    minZ=33.02,
    maxZ=37.02
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale9", {{
    event = "varial-farming:grab_bale_9",
    id = "bale9",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale9
    end,
});

RegisterNetEvent('varial-farming:grab_bale_9')
AddEventHandler('varial-farming:grab_bale_9', function()
    if bale9 then
        bale9 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 10

exports["varial-polytarget"]:AddBoxZone("bale10", vector3(2633.86, 4573.68, 36.33), 2, 1.6, {
    heading=240,
    minZ=33.33,
    maxZ=37.33
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale10", {{
    event = "varial-farming:grab_bale_10",
    id = "bale10",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale10
    end,
});

RegisterNetEvent('varial-farming:grab_bale_10')
AddEventHandler('varial-farming:grab_bale_10', function()
    if bale10 then
        bale10 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 11

exports["varial-polytarget"]:AddBoxZone("bale11", vector3(2640.99, 4556.19, 37.45), 2, 1.6, {
    heading=230,
    minZ=34.45,
    maxZ=38.45
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale11", {{
    event = "varial-farming:grab_bale_11",
    id = "bale11",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale11
    end,
});

RegisterNetEvent('varial-farming:grab_bale_11')
AddEventHandler('varial-farming:grab_bale_11', function()
    if bale11 then
        bale11 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 12

exports["varial-polytarget"]:AddBoxZone("bale12", vector3(2657.88, 4535.83, 39.06), 2, 1.6, {
    heading=60,
    minZ=35.86,
    maxZ=39.86
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale12", {{
    event = "varial-farming:grab_bale_12",
    id = "bale12",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale12
    end,
});

RegisterNetEvent('varial-farming:grab_bale_12')
AddEventHandler('varial-farming:grab_bale_12', function()
    if bale12 then
        bale12 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 13

exports["varial-polytarget"]:AddBoxZone("bale13", vector3(2662.18, 4575.37, 39.69), 2, 1.6, {
    heading=20,
    minZ=36.49,
    maxZ=40.49
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale13", {{
    event = "varial-farming:grab_bale_13",
    id = "bale13",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale13
    end,
});

RegisterNetEvent('varial-farming:grab_bale_13')
AddEventHandler('varial-farming:grab_bale_13', function()
    if bale13 then
        bale13 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 14

exports["varial-polytarget"]:AddBoxZone("bale14", vector3(2647.71, 4576.08, 38.57), 2, 1.4, {
    heading=280,
    minZ=34.77,
    maxZ=38.77
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale14", {{
    event = "varial-farming:grab_bale_14",
    id = "bale14",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale14
    end,
});

RegisterNetEvent('varial-farming:grab_bale_14')
AddEventHandler('varial-farming:grab_bale_14', function()
    if bale14 then
        bale14 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 15

exports["varial-polytarget"]:AddBoxZone("bale15", vector3(2669.49, 4591.91, 40.01), 2, 1.6, {
    heading=45,
    minZ=36.81,
    maxZ=40.81
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale15", {{
    event = "varial-farming:grab_bale_15",
    id = "bale15",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale15
    end,
});

RegisterNetEvent('varial-farming:grab_bale_15')
AddEventHandler('varial-farming:grab_bale_15', function()
    if bale15 then
        bale15 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 16

exports["varial-polytarget"]:AddBoxZone("bale16", vector3(2655.06, 4592.81, 38.79), 2, 1.6, {
    heading=55,
    minZ=35.39,
    maxZ=39.39
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale16", {{
    event = "varial-farming:grab_bale_16",
    id = "bale16",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale16
    end,
});

RegisterNetEvent('varial-farming:grab_bale_16')
AddEventHandler('varial-farming:grab_bale_16', function()
    if bale16 then
        bale16 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 17

exports["varial-polytarget"]:AddBoxZone("bale17", vector3(2643.75, 4591.63, 37.34), 2, 1.6, {
    heading=280,
    minZ=33.94,
    maxZ=37.94
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale17", {{
    event = "varial-farming:grab_bale_17",
    id = "bale17",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale17
    end,
});

RegisterNetEvent('varial-farming:grab_bale_17')
AddEventHandler('varial-farming:grab_bale_17', function()
    if bale17 then
        bale17 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Bale 18

exports["varial-polytarget"]:AddBoxZone("bale18", vector3(2650.96, 4608.27, 37.55), 2, 1.6, {
    heading=240,
    minZ=34.75,
    maxZ=38.75
})

exports["varial-interact"]:AddPeekEntryByPolyTarget("bale18", {{
    event = "varial-farming:grab_bale_18",
    id = "bale18",
    icon = "circle",
    label = "Grab Bale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
    isEnabled = function()
        return bale18
    end,
});

RegisterNetEvent('varial-farming:grab_bale_18')
AddEventHandler('varial-farming:grab_bale_18', function()
    if bale18 then
        bale18 = false
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent('animation:PlayAnimation', 'leanbar2')
            local finished = exports['varial-taskbar']:taskBar(10000, 'Grabbing Bale')
            if finished == 100 then
                BaleAmount = BaleAmount - 1
                DeleteBlip(blipHaybale1)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerEvent('player:receiveItem', haybaleName, haybaleAmount)  
                TriggerEvent('DoLongHudText', 'Successfully Grabbed Bale')
                if BaleAmount == 0 then
                    TriggerEvent('phone:addJobNotify', 'Job Completed!')
                else
                    TriggerEvent('phone:addJobNotify', '('..BaleAmount..'/2) Bales Remaining.' )
                end
            end
        end
    end)

-- Blips

function CreateHayBaleBlip1()
    blipHaybale1 = AddBlipForCoord(2612.26, 4636.43, 33.8)
    SetBlipHighDetail(blipHaybale1, true)
    SetBlipColour(blipHaybale1, 1)
    SetBlipScale(blipHaybale1, 0.40)
    SetBlipAlpha(blipHaybale1, 250)
    SetBlipDisplay(blipHaybale1, 2)
    SetBlipSprite(blipHaybale1, 686)
    AddTextEntry("BALE", "Haybale 1")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale1, 2)
    EndTextCommandSetBlipName(blipHaybale1)
end

function CreateHayBaleBlip2()
    blipHaybale2 = AddBlipForCoord(2619.22, 4640.27, 34.48)
    SetBlipHighDetail(blipHaybale2, true)
    SetBlipColour(blipHaybale2, 1)
    SetBlipScale(blipHaybale2, 0.40)
    SetBlipAlpha(blipHaybale2, 250)
    SetBlipDisplay(blipHaybale2, 2)
    SetBlipSprite(blipHaybale2, 687)
    AddTextEntry("BALE", "Haybale 2")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale2, 2)
    EndTextCommandSetBlipName(blipHaybale2)
end

function CreateHayBaleBlip3()
    blipHaybale3 = AddBlipForCoord(2590.86, 4608.87, 33.74)
    SetBlipHighDetail(blipHaybale3, true)
    SetBlipColour(blipHaybale3, 1)
    SetBlipScale(blipHaybale3, 0.40)
    SetBlipAlpha(blipHaybale3, 250)
    SetBlipDisplay(blipHaybale3, 2)
    SetBlipSprite(blipHaybale3, 688)
    AddTextEntry("BALE", "Haybale 3")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale3, 2)
    EndTextCommandSetBlipName(blipHaybale3)
end

function CreateHayBaleBlip4()
    blipHaybale4 = AddBlipForCoord(2612.77, 4615.12, 34.26)
    SetBlipHighDetail(blipHaybale4, true)
    SetBlipColour(blipHaybale4, 1)
    SetBlipScale(blipHaybale4, 0.40)
    SetBlipAlpha(blipHaybale4, 250)
    SetBlipDisplay(blipHaybale4, 2)
    SetBlipSprite(blipHaybale4, 689)
    AddTextEntry("BALE", "Haybale 4")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale4, 2)
    EndTextCommandSetBlipName(blipHaybale4)
end

function CreateHayBaleBlip5()
    blipHaybale5 = AddBlipForCoord(2617.51, 4607.79, 34.14)
    SetBlipHighDetail(blipHaybale5, true)
    SetBlipColour(blipHaybale5, 1)
    SetBlipScale(blipHaybale5, 0.40)
    SetBlipAlpha(blipHaybale5, 250)
    SetBlipDisplay(blipHaybale5, 2)
    SetBlipSprite(blipHaybale5, 690)
    AddTextEntry("BALE", "Haybale 5")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale5, 2)
    EndTextCommandSetBlipName(blipHaybale5)
end

function CreateHayBaleBlip6()
    blipHaybale6 = AddBlipForCoord(2611.09, 4596.94, 33.87)
    SetBlipHighDetail(blipHaybale6, true)
    SetBlipColour(blipHaybale6, 1)
    SetBlipScale(blipHaybale6, 0.40)
    SetBlipAlpha(blipHaybale6, 250)
    SetBlipDisplay(blipHaybale6, 2)
    SetBlipSprite(blipHaybale6, 691)
    AddTextEntry("BALE", "Haybale 6")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale6, 2)
    EndTextCommandSetBlipName(blipHaybale6)
end

function CreateHayBaleBlip7()
    blipHaybale7 = AddBlipForCoord(2604.99, 4592.58, 34.2)
    SetBlipHighDetail(blipHaybale7, true)
    SetBlipColour(blipHaybale7, 1)
    SetBlipScale(blipHaybale7, 0.40)
    SetBlipAlpha(blipHaybale7, 250)
    SetBlipDisplay(blipHaybale7, 2)
    SetBlipSprite(blipHaybale7, 692)
    AddTextEntry("BALE", "Haybale 7")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale7, 2)
    EndTextCommandSetBlipName(blipHaybale7)
end

function CreateHayBaleBlip8()
    blipHaybale8 = AddBlipForCoord(2627.14, 4595.53, 35.31)
    SetBlipHighDetail(blipHaybale8, true)
    SetBlipColour(blipHaybale8, 1)
    SetBlipScale(blipHaybale8, 0.40)
    SetBlipAlpha(blipHaybale8, 250)
    SetBlipDisplay(blipHaybale8, 2)
    SetBlipSprite(blipHaybale8, 693)
    AddTextEntry("BALE", "Haybale 8")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale8, 2)
    EndTextCommandSetBlipName(blipHaybale8)
end

function CreateHayBaleBlip9()
    blipHaybale9 = AddBlipForCoord(2622.53, 4572.54, 35.82)
    SetBlipHighDetail(blipHaybale9, true)
    SetBlipColour(blipHaybale9, 1)
    SetBlipScale(blipHaybale9, 0.40)
    SetBlipAlpha(blipHaybale9, 250)
    SetBlipDisplay(blipHaybale9, 2)
    SetBlipSprite(blipHaybale9, 694)
    AddTextEntry("BALE", "Haybale 9")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale9, 2)
    EndTextCommandSetBlipName(blipHaybale9)
end

function CreateHayBaleBlip10()
    blipHaybale1O = AddBlipForCoord(2633.86, 4573.68, 36.33)
    SetBlipHighDetail(blipHaybale1O, true)
    SetBlipColour(blipHaybale1O, 1)
    SetBlipScale(blipHaybale1O, 0.40)
    SetBlipAlpha(blipHaybale1O, 250)
    SetBlipDisplay(blipHaybale1O, 2)
    SetBlipSprite(blipHaybale1O, 695)
    AddTextEntry("BALE", "Haybale 10")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale1O, 2)
    EndTextCommandSetBlipName(blipHaybale1O)
end

function CreateHayBaleBlip11()
    blipHaybale11 = AddBlipForCoord(2640.99, 4556.19, 37.45)
    SetBlipHighDetail(blipHaybale11, true)
    SetBlipColour(blipHaybale11, 1)
    SetBlipScale(blipHaybale11, 0.40)
    SetBlipAlpha(blipHaybale11, 250)
    SetBlipDisplay(blipHaybale11, 2)
    SetBlipSprite(blipHaybale11, 696)
    AddTextEntry("BALE", "Haybale 11")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale11, 2)
    EndTextCommandSetBlipName(blipHaybale11)
end

function CreateHayBaleBlip12()
    blipHaybale12 = AddBlipForCoord(2657.88, 4535.83, 39.06)
    SetBlipHighDetail(blipHaybale12, true)
    SetBlipColour(blipHaybale12, 1)
    SetBlipScale(blipHaybale12, 0.40)
    SetBlipAlpha(blipHaybale12, 250)
    SetBlipDisplay(blipHaybale12, 2)
    SetBlipSprite(blipHaybale12, 697)
    AddTextEntry("BALE", "Haybale 12")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale12, 2)
    EndTextCommandSetBlipName(blipHaybale12)
end

function CreateHayBaleBlip13()
    blipHaybale13 = AddBlipForCoord(2662.18, 4575.37, 39.69)
    SetBlipHighDetail(blipHaybale13, true)
    SetBlipColour(blipHaybale13, 1)
    SetBlipScale(blipHaybale13, 0.40)
    SetBlipAlpha(blipHaybale13, 250)
    SetBlipDisplay(blipHaybale13, 2)
    SetBlipSprite(blipHaybale13, 698)
    AddTextEntry("BALE", "Haybale 13")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale13, 2)
    EndTextCommandSetBlipName(blipHaybale13)
end

function CreateHayBaleBlip14()
    blipHaybale14 = AddBlipForCoord(2647.71, 4576.08, 38.57)
    SetBlipHighDetail(blipHaybale14, true)
    SetBlipColour(blipHaybale14, 1)
    SetBlipScale(blipHaybale14, 0.40)
    SetBlipAlpha(blipHaybale14, 250)
    SetBlipDisplay(blipHaybale14, 2)
    SetBlipSprite(blipHaybale14, 699)
    AddTextEntry("BALE", "Haybale 14")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale14, 2)
    EndTextCommandSetBlipName(blipHaybale14)
end

function CreateHayBaleBlip15()
    blipHaybale15 = AddBlipForCoord(2669.49, 4591.91, 40.01)
    SetBlipHighDetail(blipHaybale15, true)
    SetBlipColour(blipHaybale15, 1)
    SetBlipScale(blipHaybale15, 0.40)
    SetBlipAlpha(blipHaybale15, 250)
    SetBlipDisplay(blipHaybale15, 2)
    SetBlipSprite(blipHaybale15, 700)
    AddTextEntry("BALE", "Haybale 15")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale15, 2)
    EndTextCommandSetBlipName(blipHaybale15)
end

function CreateHayBaleBlip16()
    blipHaybale16 = AddBlipForCoord(2655.06, 4592.81, 38.79)
    SetBlipHighDetail(blipHaybale16, true)
    SetBlipColour(blipHaybale16, 1)
    SetBlipScale(blipHaybale16, 0.40)
    SetBlipAlpha(blipHaybale16, 250)
    SetBlipDisplay(blipHaybale16, 2)
    SetBlipSprite(blipHaybale16, 701)
    AddTextEntry("BALE", "Haybale 16")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale16, 2)
    EndTextCommandSetBlipName(blipHaybale16)
end

function CreateHayBaleBlip17()
    blipHaybale17 = AddBlipForCoord(2643.75, 4591.63, 37.34)
    SetBlipHighDetail(blipHaybale17, true)
    SetBlipColour(blipHaybale17, 1)
    SetBlipScale(blipHaybale17, 0.40)
    SetBlipAlpha(blipHaybale17, 250)
    SetBlipDisplay(blipHaybale17, 2)
    SetBlipSprite(blipHaybale17, 702)
    AddTextEntry("BALE", "Haybale 17")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale17, 2)
    EndTextCommandSetBlipName(blipHaybale17)
end

function CreateHayBaleBlip18()
    blipHaybale18 = AddBlipForCoord(2650.96, 4608.27, 37.55)
    SetBlipHighDetail(blipHaybale18, true)
    SetBlipColour(blipHaybale18, 1)
    SetBlipScale(blipHaybale18, 0.40)
    SetBlipAlpha(blipHaybale18, 250)
    SetBlipDisplay(blipHaybale18, 2)
    SetBlipSprite(blipHaybale18, 703)
    AddTextEntry("BALE", "Haybale 18")
    BeginTextCommandSetBlipName("BALE")
    SetBlipCategory(blipHaybale18, 2)
    EndTextCommandSetBlipName(blipHaybale18)
end

--// Processing

RegisterNetEvent('varial-farming:process_bale')
AddEventHandler('varial-farming:process_bale', function()
    if exports['varial-inventory']:hasEnoughOfItem('haybale', 1) then
        FreezeEntityPosition(PlayerPedId(), true)
        TriggerEvent('animation:PlayAnimation', 'leanbar2')
        local finished = exports['varial-taskbar']:taskBar(15000, 'Processing Bale')
        if finished == 100 then
            TriggerEvent('inventory:removeItem', 'haybale', 1)
            FreezeEntityPosition(PlayerPedId(), false)
            TriggerEvent('player:receiveItem', 'wheat', math.random(9, 14))
            TriggerEvent('DoLongHudText', 'Successfully Proccessed 1x Haybale', 1)
        end
    else
        TriggerEvent('DoLongHudText', 'You do not have Any Haybale To Process', 2)
        end
    end)

-- Farming Job

exports["varial-polytarget"]:AddBoxZone("varial_farming_process", vector3(2530.15, 4114.97, 38.8), 2, 2, {
    heading=335,
    minZ=36.0,
    maxZ=40.0
})

-- Farming Job

exports["varial-interact"]:AddPeekEntryByPolyTarget("varial_farming_process", {{
    event = "varial-farming:process_bale",
    id = "varial_farming_process",
    icon = "circle",
    label = "Process Haybale",
    parameters = {},
}}, {
    distance = { radius = 2.5 },
});

--// Selling Wheat

RegisterNetEvent('varial-jobs:farming_sell:wheat')
AddEventHandler('varial-jobs:farming_sell:wheat', function()
    local pWheatAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Wheat?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Wheat You Want To Sell"
        }
        }
    })
    if pWheatAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('wheat', pWheatAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(4000*pWheatAmount[1].input, 'Selling Wheat')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('wheat', pWheatAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'wheat', pWheatAmount[1].input)
                    TriggerServerEvent('varial-farming:PayForWheat', math.random(50, 150)*pWheatAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
        end
    end)

FarmerSales = false

Citizen.CreateThread(function()
	exports["varial-polyzone"]:AddBoxZone("farmer_sell_wheat", vector3(1168.86, -291.57, 69.02), 4, 3.0, {
		name="farmer_sell_wheat",
        heading=325,
        minZ=67.41,
        maxZ=71.41,
        debugPoly = true
	  })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "farmer_sell_wheat" then
        FarmerSales = true     
        FarmerLocation()
        exports["varial-interaction"]:showInteraction("[E] Open Farmer Market")
    end
    end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "farmer_sell_wheat" then
        FarmerSales = false  
		exports["varial-interaction"]:hideInteraction()
    end
end)

function FarmerLocation()
	Citizen.CreateThread(function()
        while FarmerSales do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
				TriggerEvent('varial-farming:open_Market')
                Citizen.Wait(5000)
			end
		end
	end)
end

RegisterNetEvent('varial-farming:open_Market')
AddEventHandler('varial-farming:open_Market', function()
    TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Farmers Market",
            txt = "",
        },
        {
          id = 2, 
          header = "Sell Wheat",
          txt = "Sell wheat to the farmer",
          params = {
            event = "varial-jobs:farming_sell:wheat", 
          }
        },
    })
end)