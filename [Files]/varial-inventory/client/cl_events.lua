
AddEventHandler('varial-inventory:getTakeoutItem', function(pParameters, pEntity, pContext)
    local data = pContext.zones['restaurant_takeout']
    if data.id == 'uwu_1' then
        local BENTO_BOXES = {
            'np_bento_1.png',
            'np_bento_2.png',
            'np_bento_3.png',
            'np_bento_4.png',
            'np_bento_5.png',
            'np_bento_6.png',
        }
        data.image = 'icons/' .. BENTO_BOXES[math.random(#BENTO_BOXES)]
    end
    RPC.execute('varial-inventory:getTakeoutBox', pContext.zones['restaurant_takeout'])
end)

AddEventHandler('varial-inventory:openFridge', function(pParameters, pEntity, pContext)
    local id = pContext.zones['restaurant_fridge'].id
    TriggerEvent("server-inventory-open", "1", "burgerjob_fridge-" .. SERVER_CODE .. ":" .. id)
end)

local containerItems = {
    ['burgershotbag'] = true,
    ['murdermeal'] = true,
    ['wrappedgift'] = true,
    ['casinobag'] = true,
    ['bentobox'] = true,
    ['pizzabox'] = true,
    ['roostertakeout'] = true,
    ['cockbox'] = true,
    ['heistduffelbag'] = true,
}

local toyItems = {
    ['randomtoy'] = true,
    ['randomtoy2'] = true,
    ['randomtoy3'] = true,
    ['cockegg'] = true,
    ['uwutoy'] = true,
}
AddEventHandler("varial-inventory:itemUsed", function(item, info)
    if containerItems[item] then
        data = json.decode(info)
        TriggerEvent("InteractSound_CL:PlayOnOne","unwrap",0.1)
        TriggerEvent("inventory-open-container", data.inventoryId, data.slots, data.weight)
        return
    end
    if toyItems[item] then
        local finished = exports["np-taskbar"]:taskBar(1000, _L("restaurant-opening", "Opening"))
        if finished == 100 then
            TriggerServerEvent('loot:useItem', item)
            TriggerEvent("inventory:removeItem", item, 1)
        end
        return
    end
end)

AddEventHandler('varial-inventory:shelfPrompt', function(pParameters, pEntity, pContext)
    local id = pContext.zones['restaurant_shelf'].id
    TriggerEvent("server-inventory-open", "1", "restaurants_shelf-" .. id)
end)

AddEventHandler('varial-inventory:getToyItem', function(pParameters, pEntity, pContext)
    local data = pContext.zones['restaurant_takeout']

    if not data.toy then
        return
    end

    local prompt = exports['np-ui']:OpenInputMenu({
        {
            label = 'Enter Amount',
            name = 'amount',
            icon = 'pencil-alt',
            maxLength = 2,
        }
    }, function(values)
        return tonumber(values.amount) and values.amount:len() > 0 and values.amount:len() < 99
    end)

    if not prompt then
        return
    end

    local amount = tonumber(prompt.amount)

    TriggerEvent('player:receiveItem', data.toy, amount, false)
end)

AddEventHandler('varial-inventory:viewSafeCash', function(pParameters, pEntity, pContext)
    local business = pContext.meta.data.metadata.business
    local context = RPC.execute('varial-inventory:getSafeCash', business)
    if not context then
        return
    end
    exports['np-ui']:showContextMenu(context)
end)

AddEventHandler('varial-inventory:takeSafeCash', function(pParameters, pEntity, pContext)
    local business = pContext.meta.data.metadata.business
    RPC.execute('varial-inventory:takeSafeCash', business)
end)

AddEventHandler('varial-inventory:tradeInCash',  function(pParameters, pEntity, pContext)
    local item = exports['varial-inventory']:getItemsOfType('envelope', 1, true, {
        cashEnvelope = true,
    })[1]
    if not item then
        return
    end
    local info = json.decode(item.information)
    RPC.execute('varial-inventory:depositCash', info)
end)

AddEventHandler('varial-inventory:crackSafe', function(pParameters, pEntity, pContext)
    local business = pContext.meta.data.metadata.business
    local animDict = "mini@safe_cracking"
    local anim = "dial_turn_clock_slow"
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
      Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), animDict, anim, 8.0, 1.0, -1, 1, -1, false, false, false)
    local finished = exports['np-taskbar']:taskBar(30000, _L("restaurant-crack-safe", "Cracking"), false, true, false, false, nil, 5.0, PlayerPedId())
    ClearPedTasks(PlayerPedId())
    if finished == 100 then
        RPC.execute('varial-inventory:crackSafe', business)
    end
end)

AddEventHandler('varial-inventory:setWorkHours', function(pParameters, pEntity, pContext)
    local biz = pContext.zones['restaurant_sign_on'].biz

    local times = {}
    for i=0,24 do
        local label = ''
        if i < 10 then
            label = '0' .. i .. ':00'
        else
            label = i .. ':00'
        end

        times[#times+1] = {
            id = i,
            name = label,
        }
    end

    local prompt = exports['np-ui']:OpenInputMenu({
        {
            label = 'Opening Time',
            name = 'open',
            icon = 'clock',
            _type = 'select',
            options = times,
        },
        {
            label = 'Closing Time',
            name = 'close',
            icon = 'clock',
            _type = 'select',
            options = times,
        },
    }, function(values)
        return values.open and values.close and values.open < values.close
    end)

    if not prompt then
        return
    end

    RPC.execute('varial-inventory:setWorkHours', biz, prompt.open, prompt.close)
end)

AddEventHandler('varial-inventory:viewWorkHours', function(pParameters, pEntity, pContext)
    local biz = pContext.zones['restaurant_sign_on'].biz
    local context = RPC.execute('varial-inventory:getWorkHours', biz)
    exports['np-ui']:showContextMenu(context)
end)
