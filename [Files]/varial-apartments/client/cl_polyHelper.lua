Apart.poly = {}
Apart.poly.zones = {[1] = {},[2] = {},[3] = {}}
Apart.poly.DefaultLength = 1.4
Apart.poly.DefaultWidth = 1.4
local listening = false
local typeVector = type(vector3(0.0,0.0,0.0))
local globalLocNumber = nil
local globalNumber = nil
local pussyleaker = nil

function createZone(apartmentLocNumber,apartmentNumber)
    print("createZone",apartmentLocNumber,apartmentNumber)
    local options = {heading = 340, minZ = 0.0, maxZ = 0.0, data = {}}
    options.data = {
        LocNumber = apartmentLocNumber,
        apartmentNum = apartmentNumber
    }

    local boxCenter = Apart.Locations[1][1]

    local length = Apart.poly.DefaultLength
    local width = Apart.poly.DefaultWidth
    
    if type(Apart.Locations[apartmentLocNumber]) == typeVector then 
        boxCenter = Apart.Locations[apartmentLocNumber]
        length = 2.5
        width = 2.5
    else
        boxCenter = Apart.Locations[apartmentLocNumber][apartmentNumber]
    end

    options.minZ = boxCenter.z-1.0
    options.maxZ = boxCenter.z+1.0

    local zone = BoxZone:Create(boxCenter, length, width, options)

    zone:onPlayerInOut(function(isPointInside, point,moreData)
        if not isPointInside then
            polyHelperExit(zone.data.LocNumber,zone.data.apartmentNum)
        else
            polyHelperEnter(zone.data.LocNumber,zone.data.apartmentNum)
        end
    end, 500)

    Apart.poly.zones[apartmentLocNumber][apartmentNumber] = zone

end


function polyHelperExit(apartmentLocNumber,apartmentNumber)
    listening = false
    exports['varial-interaction']:hideInteraction()
end

function polyHelperEnter(apartmentLocNumber,apartmentNumber)
    if listening then return end
    listening = true
    exports['varial-interaction']:showInteraction(getInteractionMessage(apartmentLocNumber,apartmentNumber))
    listen(apartmentLocNumber,apartmentNumber)
end

function listen(apartmentLocNumber,apartmentNumber)
    Citizen.CreateThread(function()
        while listening do
            globalLocNumber = apartmentLocNumber
            globalNumber = apartmentNumber
            Wait(0)
        end

        globalLocNumber = nil
        globalNumber = nil
    end)
end

function getInteractionMessage(apartmentLocNumber,apartmentNumber)

    if apartmentLocNumber == Apart.currentRoomType and apartmentNumber == Apart.currentRoomNumber then
        return "[H] to enter, [G] For More"
    end

    if Apart.currentRoomLocks[apartmentLocNumber] ~= nil and Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] ~= nil and Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] == false then
        return "[G] For More"
    end
end

-- function getInteractionMessage(apartmentLocNumber,apartmentNumber)

--     if apartmentLocNumber == Apart.currentRoomType and apartmentNumber == Apart.currentRoomNumber then
--         return "[H] to enter, [G] For More"
--     end

--     if Apart.currentRoomLocks[apartmentLocNumber] ~= nil and Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] ~= nil and Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] == false then
--         return "[H] to enter"
--     end
-- end

function destroyAllLockedZones()
    for i=1,#Apart.Locations do
        if type(Apart.Locations[i]) ~= typeVector then
            for k,v in pairs(Apart.poly.zones[i]) do
                local pass = true
                if i == Apart.currentRoomType and k == Apart.currentRoomNumber then pass = false end

                if Apart.currentRoomLocks[i][k] and pass then
                    v:destroy()
                    Apart.poly.zones[i][k] = nil
                end
            end
        end
    end
end


function createNewUnlockZones()
    for i=1,#Apart.Locations do
        if type(Apart.Locations[i]) ~= typeVector then
            for k,v in pairs(Apart.currentRoomLocks[i]) do
                if Apart.poly.zones[i][k] == nil then
                    if not Apart.currentRoomLocks[i][k] then
                        createZone(i,k)
                    end
                end
            end
        end
    end
end


function showApartmentMenu(apartmentLocNumber,apartmentNumber)
    local Text = "Unlock"

    if Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] then    
        Text = "Unlock"
    else
        Text = "Lock"
    end

    local unlockedApartments = {}

    for k,v in pairs(Apart.currentRoomLocks[apartmentLocNumber]) do
        if v == false then
            unlockedApartments[#unlockedApartments + 1] = { title = "Apartment # "..k, action = "varial-ui:apartmentsContext", key = {"EnterUnlocked",apartmentLocNumber,k} }
        end 
    end

    local data = {
        {
            title = Text,
            description = "Lock / Unlock Your apartment.",
            key = {"locks",apartmentLocNumber,apartmentNumber},
            action = "varial-ui:apartmentsContext"
        },
        {
            title = "Apartments",
            description = "View / Enter Unlocked Apartments.",
            key = {nil,apartmentLocNumber,apartmentNumber},
            children = unlockedApartments
        },
    }

    local myjob = exports["isPed"]:isPed("myjob")
    
    if myjob == "police" or myjob == "judge" or myjob == "sheriff" or myjob == "state" then

        local allApartments = {}
        local currentApartments = RPC.execute("apartment:allCurrentApartmentsOfRoomType",apartmentLocNumber) 

        for k,v in pairs(currentApartments) do
            local Locktext = "Apartment # "..k
            if Apart.currentRoomLockDown[apartmentLocNumber][v] then
                Locktext = "Remove Apartment # "..k
            end

            allApartments[#allApartments + 1] = {
                title = Locktext,
                description = "Lockdown a Given Apartment.",
                key = {"lockdown",apartmentLocNumber,k},
                action = "varial-ui:apartmentsContext"
            }
        end
        
        data[#data + 1] = {
            title = "Lockdown",
            description = "Lockdown a Given Apartment.",
            key = {nil,apartmentLocNumber,apartmentNumber},
            children = allApartments
        }
    end

    exports["varial-ui"]:showContextMenu(data)
  end
  
RegisterUICallback("varial-ui:apartmentsContext", function(data, cb)
    local keyData = data.key
    local action = keyData[1]
    local loc = keyData[2]
    local room = keyData[3] 

    if action == "locks" then
        exports["varial-ui"]:hideContextMenu()
        Apart.locksMotel(loc,room)
        --exports["varial-ui"]:showInteraction(getInteractionMessage(globalLocNumber,globalNumber))
    end

    if action == "EnterUnlocked" then
        exports["varial-ui"]:hideContextMenu()
        print("EnterUnlocked",room,loc)
        Apart.enterMotel(room,loc)
    end

    if action == "lockdown" then
        TriggerServerEvent("apartment:serverLockdown",room,loc)
        --exports["varial-ui"]:showInteraction(getInteractionMessage(globalLocNumber,globalNumber))
    end

    cb({ data = {}, meta = { ok = true, message = "done" } })
    SetNuiFocus(false, false)
end)

RegisterNetEvent('varial-binds:keyEvent')
AddEventHandler('varial-binds:keyEvent', function(name,onDown)
    if onDown then return end
    if not listening then return end

    if name == "housingSecondary" then
        if globalLocNumber == Apart.currentRoomType and globalNumber == Apart.currentRoomNumber then
            exports['varial-interaction']:hideInteraction()
            showApartmentMenu(globalLocNumber,globalNumber)
        else
            if pussyleaker then

            else 
                exports['varial-interaction']:hideInteraction()
                showApartmentMenuTwo(globalLocNumber,globalNumber)
            end
        end
    end
    
    if name == "housingMain" then
        if globalLocNumber == Apart.currentRoomType and globalNumber == Apart.currentRoomNumber then
            listening = false
            exports['varial-interaction']:hideInteraction()
            TriggerEvent("apartments:enterMotel",apartmentNumber, apartmentLocNumber)
        end
    end
end)


function showApartmentMenuTwo(apartmentLocNumber,apartmentNumber)
    local Text = "Unlock"

    if Apart.currentRoomLocks[apartmentLocNumber][apartmentNumber] then    
        Text = "Unlock"
    else
         Text = "Lock"
    end

    local unlockedApartments = {}

    for k,v in pairs(Apart.currentRoomLocks[apartmentLocNumber]) do
        if v == false then
            unlockedApartments[#unlockedApartments + 1] = { title = "Apartment # "..k, action = "varial-ui:apartmentsenterContext", key = {"EnterUnlocked",apartmentLocNumber,k} }
        end 
    end

    local data = {
        {
            title = "Apartments",
            description = "View / Enter Unlocked Apartments.",
            key = {nil,apartmentLocNumber,apartmentNumber},
            children = unlockedApartments
        },
    }

    local myjob = exports["isPed"]:isPed("myjob")
    
    if myjob == "police" or myjob == "judge" or myjob == "sheriff" or myjob == "state" then

        local allApartments = {}
        local currentApartments = RPC.execute("apartment:allCurrentApartmentsOfRoomType",apartmentLocNumber) 

        for k,v in pairs(currentApartments) do
            local Locktext = "Apartment # "..k
            if Apart.currentRoomLockDown[apartmentLocNumber][v] then
                Locktext = "Remove Apartment # "..k
            end

            allApartments[#allApartments + 1] = {
                title = Locktext,
                description = "Lockdown a Given Apartment.",
                key = {"lockdown",apartmentLocNumber,k},
                action = "varial-ui:apartmentsenterContext"
            }
        end
        
        data[#data + 1] = {
            title = "Lockdown",
            description = "Lockdown a Given Apartment.",
            key = {nil,apartmentLocNumber,apartmentNumber},
            children = allApartments
        }
    end

    exports["varial-ui"]:showContextMenu(data)
end


RegisterUICallback("varial-ui:apartmentsenterContext", function(data, cb)
    local keyData = data.key
    local action = keyData[1]
    local loc = keyData[2]
    local room = keyData[3] 

    if action == "locks" then
        exports["varial-ui"]:hideContextMenu()
        Apart.locksMotel(loc,room)
        --exports["varial-ui"]:showInteraction(getInteractionMessage(globalLocNumber,globalNumber))
    end

    if action == "EnterUnlocked" then
        exports["varial-ui"]:hideContextMenu()
        Apart.enterMotel(room,loc)
    end

    if action == "lockdown" then
        exports["varial-ui"]:hideContextMenu()
        TriggerServerEvent("apartment:serverLockdown",room,loc)
        --exports["varial-ui"]:showInteraction(getInteractionMessage(globalLocNumber,globalNumber))
    end

    cb({ data = {}, meta = { ok = true, message = "done" } })
    SetNuiFocus(false, false)
end)



RegisterNetEvent('varial-apps:unlocks1')
AddEventHandler('varial-apps:unlocks1', function()
    if globalLocNumber ~= nil then
        showApartmentMenu(globalLocNumber,globalNumber)
    else
        TriggerEvent('DoLongHudText', "No Apartments are in use right now", 1)
    end
end)

RegisterNetEvent('varial-apps:unlocks2')
AddEventHandler('varial-apps:unlocks2', function()
    if globalLocNumber ~= nil then
        showApartmentMenuTwo(globalLocNumber,globalNumber)
    else
        TriggerEvent('DoLongHudText', "No Apartments are in use right now", 1)
    end
end)