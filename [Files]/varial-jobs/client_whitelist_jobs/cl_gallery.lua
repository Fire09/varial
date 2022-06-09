RegisterNetEvent("gallery-menu")
AddEventHandler("gallery-menu", function()
    --local rank = exports["isPed"]:GroupRank("art_gallery")
    --if rank >= 1 then
        TriggerEvent('varial-context:sendMenu', {
            {
                id = "1",
                header = "Gallery Insides",
                txt = ""
            },
            {
                id = "2",
                header = "Sell Gemstone",
                txt = "Gemstone",
                params = {
                    event = "varial-jobs:gallery_sell:gem",
                }
            },
            {
                id = "3",
                header = "Sell Stone",
                txt = "Stones",
                params = {
                    event = "varial-jobs:gallery_sell:stone",
                }
            },
            {
                id = "4",
                header = "Sell Coal",
                txt = "Coal",
                params = {
                    event = "varial-jobs:gallery_sell:coal",
                }
            },
            {
                id = "5",
                header = "Sell Diamond",
                txt = "Diamond",
                params = {
                    event = "varial-jobs:gallery_sell:diamonds",
                }
            },
            {
                id = "6",
                header = "Sell Sapphire Gem",
                txt = "Sapphire",
                params = {
                    event = "varial-jobs:gallery_sell:sapphire",
                }
            },
            {
                id = "7",
                header = "Sell Ruby Gem",
                txt = "Ruby",
                params = {
                    event = "varial-jobs:gallery_sell:ruby",
                }
            },
            {
                id = "8",
                header = "Sell Gold Rolex",
                txt = "Watch",
                params = {
                    event = "varial-jobs:gallery_sell:rolex",
                }
            },
            {
                id = "9",
                header = "Close Menu",
                txt = "Close menu",
                params = {
                    event = "",
                }
            },
        })
 
end)

-- Stash

RegisterNetEvent('varial-gallery:open_stash')
AddEventHandler('varial-gallery:open_stash', function()
    local rank = exports['isPed']:GroupRank('art_gallery')
    if rank >= 1 then
        TriggerEvent('server-inventory-open', '1', 'art-gallery-stash')
    else
        TriggerEvent('DoLongHudText', 'You cant access this', 2)
    end
end)

-- Sales

-- Mining Gem

RegisterNetEvent('varial-jobs:gallery_sell:gem')
AddEventHandler('varial-jobs:gallery_sell:gem', function()
    local pGemAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Gem?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Gems You Want To Sell"
        }
        }
    })
    if pGemAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('mininggem', pGemAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pGemAmount[1].input, 'Selling Gems')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('mininggem', pGemAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'mininggem', pGemAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(250,300)*pGemAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Mining Stone

RegisterNetEvent('varial-jobs:gallery_sell:stone')
AddEventHandler('varial-jobs:gallery_sell:stone', function()
    local pStoneAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Stones?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Stones You Want To Sell"
        }
        }
    })
    if pStoneAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('miningstone', pStoneAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pStoneAmount[1].input, 'Selling Stones')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('miningstone', pStoneAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'miningstone', pStoneAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(250,300)*pStoneAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Mining Coal

RegisterNetEvent('varial-jobs:gallery_sell:coal')
AddEventHandler('varial-jobs:gallery_sell:coal', function()
    local pCoalAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Coal?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Coal You Want To Sell"
        }
        }
    })
    if pCoalAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('miningcoal', pCoalAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pCoalAmount[1].input, 'Selling Coal')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('miningcoal', pCoalAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'miningcoal', pCoalAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(124,125)*pCoalAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Mining Diamond

RegisterNetEvent('varial-jobs:gallery_sell:diamonds')
AddEventHandler('varial-jobs:gallery_sell:diamonds', function()
    local pDiamondAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Diamond?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Diamonds You Want To Sell"
        }
        }
    })
    if pDiamondAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('miningdiamond', pDiamondAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pDiamondAmount[1].input, 'Selling Diamonds')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('miningdiamond', pDiamondAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'miningdiamond', pDiamondAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(249,250)*pDiamondAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Mining Sapphire

RegisterNetEvent('varial-jobs:gallery_sell:sapphire')
AddEventHandler('varial-jobs:gallery_sell:sapphire', function()
    local pSapphireAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Sapphires?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Sapphires You Want To Sell"
        }
        }
    })
    if pSapphireAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('miningsapphire', pSapphireAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pSapphireAmount[1].input, 'Selling Sapphire')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('miningsapphire', pSapphireAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'miningsapphire', pSapphireAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(199,200)*pSapphireAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Mining Ruby

RegisterNetEvent('varial-jobs:gallery_sell:ruby')
AddEventHandler('varial-jobs:gallery_sell:ruby', function()
    local pRubyAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Rubys?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Rubys You Want To Sell"
        }
        }
    })
    if pRubyAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('miningruby', pRubyAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pRubyAmount[1].input, 'Selling Rubys')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('miningruby', pRubyAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'miningruby', pRubyAmount[1].input)
                    TriggerServerEvent( 'varial-weedbox:payout', math.random(225,226)*pRubyAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)

-- Stolen Rolex

RegisterNetEvent('varial-jobs:gallery_sell:rolex')
AddEventHandler('varial-jobs:gallery_sell:rolex', function()
    local pRolexAmount = exports["varial-applications"]:KeyboardInput({
        header = "How Much Rolexs?",
        rows = {
        {
            id = 0,
            txt = "Input How Much Rolexs You Want To Sell"
        }
        }
    })
    if pRolexAmount[1] ~= nil then
        if exports['varial-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmount[1].input) then
            FreezeEntityPosition(PlayerPedId(), true)
            local finished = exports['varial-taskbar']:taskBar(2000*pRolexAmount[1].input, 'Selling Rolexs')
            if finished == 100 then
                if exports['varial-inventory']:hasEnoughOfItem('rolexwatch', pRolexAmount[1].input) then
                    TriggerEvent('inventory:removeItem', 'rolexwatch', pRolexAmount[1].input)
                    TriggerServerEvent('varial-weedbox:payout', math.random(250,251)*pRolexAmount[1].input)
                    FreezeEntityPosition(PlayerPedId(), false)
                else
                    FreezeEntityPosition(PlayerPedId(), false)
                    TriggerEvent('DoLongHudText', 'Might wanna try again', 2)
                end
            end
        end
    end
end)
