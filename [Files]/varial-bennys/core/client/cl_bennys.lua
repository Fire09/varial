--[[
cl_bennys.lua
Functionality that handles the player for Benny's.
Handles applying mods, etc.
]]

--#[Global Variables]#--
isPlyInBennys = false
bennysAccess = nil
local businesses = {}

--#[Local Variables]#--
local plyFirstJoin = false
devmode = false

local currentBennys = nil

local bennysLocations = {
    ["bennys"] = {
        pos = vector3(-211.55, -1324.55, 30.90),
        heading = 320.0
    },
    ["bennystuner"] = {
        pos = vector3(135.69, -3030.47, 6.4),
        heading = 358.74,
     --   access = 'police'
    },
    ["bennysoldtuner"] = {
        pos = vector3(937.51, -970.97, 38.9),
        heading = 275.32,
     --   access = 'police'
    },
    ["bennysimport"] = {
        pos = vector3(-772.92,-234.92,37.08),
        heading = 204.0,
        access = 'fastlane'
    },
    ["bennysbridge"] = {
        pos = vector3(727.74, -1088.95, 22.17),
        heading = 270.0
    },
    ["bennysmrpd"] = {
        pos = vector3(451.84, -975.96, 25.51),
        heading = 90.0,
        access = 'police'
    },
    ["bennysdavis"] = {
        pos = vector3(372.12875366211, -1623.8637695313, 28.76994514465),
        heading = 322.1871337890,
        access = 'police'
    },
    ["bennysSASP"] = {
        pos = vector3(857.06744384766, -1309.8470458984, 23.799081802368),
        heading = 353.20288085938,
        access = 'state'
    },
    ["bennyssandy"] = {
        pos = vector3(1866.5394287109, 3695.7680664063, 33.410934448242),
        heading = 31.798612594604,
        access = 'police'
    },
    ["bennysvespucci"] = {
        pos = vector3(-1117.81, -826.58, 3.75),
        heading = 31.798612594604,
        access = 'police'
    },
    ["bennyspaleto"] = {
        pos = vector3(110.8, 6626.46, 32.0),
        heading = 44.0
    },
    ["bennysboats"] = {
        pos = vector3(-809.83, -1507.21, 14.4),
        heading = 130.63,
    },
    ["bennysplanes"] = {
        pos = vector3(-1652.52, -3143.0, 13.99),
        heading = 240,
    },
    ["bennysrex"] = {
        pos = vector3(2522.64, 2621.78, 37.96),
        heading = 267.62,
    },
    ["bennyshub"] = {
        pos = vector3(-34.24, -1053.31, 28.4),
        heading = 36.52
    },
    ["bennysauto_exotics"] = {
        pos = vector3(548.47, -198.95, 54.04),
        heading = 359.25
    },
    ["bennyshayes_auto"] = {
        pos = vector3(-1417.59, -445.67, 35.23),
        heading = 208.83
    },
    ["bennyshayes_auto2"] = {
        pos = vector3(-1424.3, -449.54, 35.23),
        heading = 208.83
    },
    ["bennysottos_autos1"] = {
        pos = vector3(829.82, -805.72, 25.66),
        heading = 271.27
    },
    ["bennysottos_autos2"] = {
        pos = vector3(831.12, -813.03, 25.66),
        heading = 271.27
    },
    ["bennys_ems"] = {
        pos = vector3(340.35, -571.78, 28.58),
        heading = 159.59 
    },
}

local originalCategory = nil
local originalMod = nil
local originalPrimaryColour = nil
local originalSecondaryColour = nil
local originalPearlescentColour = nil
local originalWheelColour = nil
local originalDashColour = nil
local originalInterColour = nil
local originalWindowTint = nil
local originalWheelCategory = nil
local originalWheel = nil
local originalWheelType = nil
local originalCustomWheels = nil
local originalNeonLightState = nil
local originalNeonLightSide = nil
local originalNeonColourR = nil
local originalNeonColourG = nil
local originalNeonColourB = nil
local originalXenonColour = nil
local originalOldLivery = nil
local originalPlateIndex = nil

local attemptingPurchase = false
local isPurchaseSuccessful = false

--#[Local Functions]#--
local function saveVehicle()
    local plyPed = PlayerPedId()
    local veh = GetVehiclePedIsIn(plyPed, false)
    local vehicleMods = exports['varial-base']:FetchVehProps(veh)
    TriggerServerEvent('updateVehicle',vehicleMods,GetVehicleNumberPlateText(veh))  
end


--#[Global Functions]#--
function AttemptPurchase(type, upgradeLevel)
    local cheap = false

    if currentBennys == 'bennystuner' or currentBennys == 'bennysottos_autos2' then
        cheap = true
        TriggerEvent('varial-bennys:repairciv')
        isAtRepairsOnlyBennys = false
        enterLocation(bennys, false)
    end

    if upgradeLevel ~= nil then
        upgradeLevel = upgradeLevel + 2
    end
    TriggerServerEvent("varial-bennys:attemptPurchase",cheap, type, upgradeLevel)

    attemptingPurchase = true

    while attemptingPurchase do
        Citizen.Wait(1)
    end

    if not isPurchaseSuccessful then
        PlaySoundFrontend(-1, "ERROR", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    if currentBennys:find('^devbennys') then
        return true
    end

    return isPurchaseSuccessful
end

function RepairVehicle()
        local plyPed = PlayerPedId()
        local plyVeh = GetVehiclePedIsIn(plyPed, false)

        local vehBodyHealth = GetVehicleBodyHealth(plyVeh)
        local vehEngineHealth = GetVehicleEngineHealth(plyVeh)

        local missingBodyHealth = 1000.0 - vehBodyHealth
        --local missingEngineHealth = 1000.0 - vehEngineHealth

    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local finished = exports["varial-taskbar"]:taskBar(5000 + (missingBodyHealth / 50), "Repairing vehicle...", true)

    SetVehicleFixed(plyVeh)
    SetVehicleDirtLevel(plyVeh, 0.0)
    SetVehiclePetrolTankHealth(plyVeh, 4000.0)
    TriggerEvent('veh.randomDegredation',10,plyVeh,3)
end


function GetCurrentMod(id)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local mod = GetVehicleMod(plyVeh, id)
    local modName = GetLabelText(GetModTextLabel(plyVeh, id, mod))

    return mod, modName
end

function GetCurrentWheel()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local wheel = GetVehicleMod(plyVeh, 23)
    local wheelName = GetLabelText(GetModTextLabel(plyVeh, 23, wheel))
    local wheelType = GetVehicleWheelType(plyVeh)

    return wheel, wheelName, wheelType
end

function GetCurrentCustomWheelState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local state = GetVehicleModVariation(plyVeh, 23)

    if state then
        return 1
    else
        return 0
    end
end

function GetOriginalWheel()
    return originalWheel
end

function GetOriginalCustomWheel()
    return originalCustomWheels
end

function GetCurrentWindowTint()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    return GetVehicleWindowTint(plyVeh)
end

function GetCurrentVehicleWheelSmokeColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local r, g, b = GetVehicleTyreSmokeColor(plyVeh)

    return r, g, b
end

function GetCurrentNeonState(id)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsVehicleNeonLightEnabled(plyVeh, id)

    if isEnabled then
        return 1
    else
        return 0
    end
end

function GetCurrentNeonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local r, g, b = GetVehicleNeonLightsColour(plyVeh)

    return r, g, b
end

function GetCurrentXenonState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsToggleModOn(plyVeh, 22)

    if isEnabled then
        return 1
    else
        return 0
    end
end

function GetCurrentXenonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    return GetVehicleHeadlightsColour(plyVeh)
end

function GetCurrentTurboState()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsToggleModOn(plyVeh, 18)

    if isEnabled then
        return 1
    else
        return 0
    end
end

function GetCurrentExtraState(extra)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    return IsVehicleExtraTurnedOn(plyVeh, extra)
end

function CheckValidMods(category, id, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local tempMod = GetVehicleMod(plyVeh, id)
    local tempWheel = GetVehicleMod(plyVeh, 23)
    local tempWheelType = GetVehicleWheelType(plyVeh)
    local tempWheelCustom = GetVehicleModVariation(plyVeh, 23)
    local validMods = {}
    local amountValidMods = 0
    local hornNames = {}

    if wheelType ~= nil then
        SetVehicleWheelType(plyVeh, wheelType)
    end

    if id == 14 then
        for k, v in pairs(vehicleCustomisation) do 
            if vehicleCustomisation[k].category == category then
                hornNames = vehicleCustomisation[k].hornNames

                break
            end
        end
    end

    local modAmount = GetNumVehicleMods(plyVeh, id)
    for i = 1, modAmount do
        local label = GetModTextLabel(plyVeh, id, (i - 1))
        local modName = GetLabelText(label)

        if modName == "NULL" then
            if id == 14 then
                if i <= #hornNames then
                    modName = hornNames[i].name
                else
                    modName = "Horn " .. i
                end
            else
                modName = category .. " " .. i
            end
        end

        validMods[i] = 
        {
            id = (i - 1),
            name = modName
        }

        amountValidMods = amountValidMods + 1
    end

    if modAmount > 0 then
        table.insert(validMods, 1, {
            id = -1,
            name = "Stock " .. category
        })
    end

    if wheelType ~= nil then
        SetVehicleWheelType(plyVeh, tempWheelType)
        SetVehicleMod(plyVeh, 23, tempWheel, tempWheelCustom)
    end

    return validMods, amountValidMods
end

function RestoreOriginalMod()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleMod(plyVeh, originalCategory, originalMod)
    SetVehicleDoorsShut(plyVeh, true)

    originalCategory = nil
    originalMod = nil
end

function RestoreOriginalWindowTint()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleWindowTint(plyVeh, originalWindowTint)

    originalWindowTint = nil
end

function RestoreOriginalColours()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleColours(plyVeh, originalPrimaryColour, originalSecondaryColour)
    SetVehicleExtraColours(plyVeh, originalPearlescentColour, originalWheelColour)
    SetVehicleDashboardColour(plyVeh, originalDashColour)
    SetVehicleInteriorColour(plyVeh, originalInterColour)

    originalPrimaryColour = nil
    originalSecondaryColour = nil
    originalPearlescentColour = nil
    originalWheelColour = nil
    originalDashColour = nil
    originalInterColour = nil
end

function RestoreOriginalColourPresets()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleColours(plyVeh, originalPrimaryColour, originalSecondaryColour)
    SetVehicleExtraColours(plyVeh, originalPearlescentColour, originalWheelColour)

    originalPrimaryColour = nil
    originalSecondaryColour = nil
    originalPearlescentColour = nil
    originalWheelColour = nil
end

function RestoreOriginalWheels()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local doesHaveCustomWheels = GetVehicleModVariation(plyVeh, 23)

    SetVehicleWheelType(plyVeh, originalWheelType)

    if originalWheelCategory ~= nil then
        SetVehicleMod(plyVeh, originalWheelCategory, originalWheel, originalCustomWheels)
        
        if GetVehicleClass(plyVeh) == 8 then --Motorcycle
            SetVehicleMod(plyVeh, 24, originalWheel, originalCustomWheels)
        end

        originalWheelType = nil
        originalWheelCategory = nil
        originalWheel = nil
        originalCustomWheels = nil
    end
end

function RestoreOriginalNeonStates()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleNeonLightEnabled(plyVeh, originalNeonLightSide, originalNeonLightState)

    originalNeonLightState = nil
    originalNeonLightSide = nil
end

function RestoreOriginalNeonColours()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleNeonLightsColour(plyVeh, originalNeonColourR, originalNeonColourG, originalNeonColourB)

    originalNeonColourR = nil
    originalNeonColourG = nil
    originalNeonColourB = nil
end

function RestoreOriginalXenonColour()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleHeadlightsColour(plyVeh, originalXenonColour)
    SetVehicleLights(plyVeh, 0)

    originalXenonColour = nil
end

function RestoreOldLivery()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleLivery(plyVeh, originalOldLivery)
end

function RestorePlateIndex()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleNumberPlateTextIndex(plyVeh, originalPlateIndex)
end

function PreviewMod(categoryID, modID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalMod == nil and originalCategory == nil then
        originalCategory = categoryID
        originalMod = GetVehicleMod(plyVeh, categoryID)
    end

    if categoryID == 39 or categoryID == 40 or categoryID == 41 then
        SetVehicleDoorOpen(plyVeh, 4, false, true)
    elseif categoryID == 37 or categoryID == 38 then
        SetVehicleDoorOpen(plyVeh, 5, false, true)
    end

    SetVehicleMod(plyVeh, categoryID, modID)
end

function PreviewWindowTint(windowTintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalWindowTint == nil then
        originalWindowTint = GetVehicleWindowTint(plyVeh)
    end

    SetVehicleWindowTint(plyVeh, windowTintID)
end

function PreviewColour(paintType, paintCategory, paintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleModKit(plyVeh, 0)
    if originalDashColour == nil and originalInterColour == nil and originalPrimaryColour == nil and originalSecondaryColour == nil and originalPearlescentColour == nil and originalWheelColour == nil then
        originalPrimaryColour, originalSecondaryColour = GetVehicleColours(plyVeh)
        originalPearlescentColour, originalWheelColour = GetVehicleExtraColours(plyVeh)
        originalDashColour = GetVehicleDashboardColour(plyVeh)
        originalInterColour = GetVehicleInteriorColour(plyVeh)
    end
    if paintType == 0 then --Primary Colour
        if paintCategory == 1 then --Metallic Paint
            SetVehicleColours(plyVeh, paintID, originalSecondaryColour)
            SetVehicleExtraColours(plyVeh, originalPearlescentColour, originalWheelColour)
        else
            SetVehicleColours(plyVeh, paintID, originalSecondaryColour)
        end
    elseif paintType == 1 then --Secondary Colour
        SetVehicleColours(plyVeh, originalPrimaryColour, paintID)
    elseif paintType == 2 then --Pearlescent Colour
        SetVehicleExtraColours(plyVeh, paintID, originalWheelColour)
    elseif paintType == 3 then --Wheel Colour
        SetVehicleExtraColours(plyVeh, originalPearlescentColour, paintID)
    elseif paintType == 4 then --Dash Colour
        SetVehicleDashboardColour(plyVeh, paintID)
    elseif paintType == 5 then --Interior Colour
        SetVehicleInteriorColour(plyVeh, paintID)
    end
end

function PreviewColourPresets(presetId)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleModKit(plyVeh, 0)

    if originalPrimaryColour == nil and originalSecondaryColour == nil and originalPearlescentColour == nil and originalWheelColour == nil then
        originalPrimaryColour, originalSecondaryColour = GetVehicleColours(plyVeh)
        originalPearlescentColour, originalWheelColour = GetVehicleExtraColours(plyVeh)
    end

    SetVehicleColourCombination(plyVeh, presetId)
end

function PreviewWheel(categoryID, wheelID, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local doesHaveCustomWheels = GetVehicleModVariation(plyVeh, 23)

    if originalWheelCategory == nil and originalWheel == nil and originalWheelType == nil and originalCustomWheels == nil then
        originalWheelCategory = categoryID
        originalWheelType = GetVehicleWheelType(plyVeh)
        originalWheel = GetVehicleMod(plyVeh, 23)
        originalCustomWheels = GetVehicleModVariation(plyVeh, 23)
    end

    SetVehicleWheelType(plyVeh, wheelType)
    SetVehicleMod(plyVeh, categoryID, wheelID, doesHaveCustomWheels)

    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, wheelID, doesHaveCustomWheels)
    end
end

function PreviewNeon(side, enabled)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalNeonLightState == nil and originalNeonLightSide == nil then
        if IsVehicleNeonLightEnabled(plyVeh, side) then
            originalNeonLightState = 1
        else
            originalNeonLightState = 0
        end

        originalNeonLightSide = side
    end

    SetVehicleNeonLightEnabled(plyVeh, side, enabled)
end

function PreviewNeonColour(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalNeonColourR == nil and originalNeonColourG == nil and originalNeonColourB == nil then
        originalNeonColourR, originalNeonColourG, originalNeonColourB = GetVehicleNeonLightsColour(plyVeh)
    end

    SetVehicleNeonLightsColour(plyVeh, r, g, b)
end

function PreviewXenonColour(colour)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if originalXenonColour == nil then
        originalXenonColour = GetVehicleHeadlightsColour(plyVeh)
    end

    SetVehicleLights(plyVeh, 2)
    SetVehicleHeadlightsColour(plyVeh, colour)
end

function PreviewOldLivery(liv)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    if originalOldLivery == nil then
        originalOldLivery = GetVehicleLivery(plyVeh)
    end

    SetVehicleLivery(plyVeh, tonumber(liv))
end

function PreviewPlateIndex(index)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    if originalPlateIndex == nil then
        originalPlateIndex = GetVehicleNumberPlateTextIndex(plyVeh)
    end

    SetVehicleNumberPlateTextIndex(plyVeh, tonumber(index))
end

function ApplyMod(categoryID, modID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if categoryID == 18 then
        ToggleVehicleMod(plyVeh, categoryID, modID)
    elseif categoryID == 11 or categoryID == 12 or categoryID== 13 or categoryID == 15 or categoryID == 16 then --Performance Upgrades
        originalCategory = categoryID
        originalMod = modID

        SetVehicleMod(plyVeh, categoryID, modID)
    else
        originalCategory = categoryID
        originalMod = modID

        SetVehicleMod(plyVeh, categoryID, modID)
    end
end

function ApplyExtra(extraID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local isEnabled = IsVehicleExtraTurnedOn(plyVeh, extraID)
    if isEnabled == 1 then
        SetVehicleExtra(plyVeh, tonumber(extraID), 1)
        SetVehiclePetrolTankHealth(plyVeh,4000.0)
    else
        SetVehicleExtra(plyVeh, tonumber(extraID), 0)
        SetVehiclePetrolTankHealth(plyVeh,4000.0)
    end
end

function ApplyPreset(presetId)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    SetVehicleColourCombination(plyVeh, presetId)

    originalPrimaryColour, originalSecondaryColour = GetVehicleColours(plyVeh)
    originalPearlescentColour, originalWheelColour = GetVehicleExtraColours(plyVeh)
end

function ApplyWindowTint(windowTintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalWindowTint = windowTintID

    SetVehicleWindowTint(plyVeh, windowTintID)
end

function ApplyColour(paintType, paintCategory, paintID)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local vehPrimaryColour, vehSecondaryColour = GetVehicleColours(plyVeh)
    local vehPearlescentColour, vehWheelColour = GetVehicleExtraColours(plyVeh)

    if paintType == 0 then --Primary Colour
        if paintCategory == 1 then --Metallic Paint
            SetVehicleColours(plyVeh, paintID, vehSecondaryColour)
            -- SetVehicleExtraColours(plyVeh, paintID, vehWheelColour)
            SetVehicleExtraColours(plyVeh, originalPearlescentColour, vehWheelColour)
            originalPrimaryColour = paintID
            -- originalPearlescentColour = paintID
        else
            SetVehicleColours(plyVeh, paintID, vehSecondaryColour)
            originalPrimaryColour = paintID
        end
    elseif paintType == 1 then --Secondary Colour
        SetVehicleColours(plyVeh, vehPrimaryColour, paintID)
        originalSecondaryColour = paintID
    elseif paintType == 2 then --Pearlescent Colour
        SetVehicleExtraColours(plyVeh, paintID, vehWheelColour)
        originalPearlescentColour = paintID
    elseif paintType == 3 then --Wheel Colour
        SetVehicleExtraColours(plyVeh, vehPearlescentColour, paintID)
        originalWheelColour = paintID
    elseif paintType == 4 then --Dash Colour
        SetVehicleDashboardColour(plyVeh, paintID)
        originalDashColour = paintID
    elseif paintType == 5 then --Interior Colour
        SetVehicleInteriorColour(plyVeh, paintID)
        originalInterColour = paintID
    end
end

function ApplyWheel(categoryID, wheelID, wheelType)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local doesHaveCustomWheels = GetVehicleModVariation(plyVeh, 23)

    originalWheelCategory = categoryID
    originalWheel = wheelID
    originalWheelType = wheelType

    SetVehicleWheelType(plyVeh, wheelType)
    SetVehicleMod(plyVeh, categoryID, wheelID, doesHaveCustomWheels)
    
    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, wheelID, doesHaveCustomWheels)
    end
end

function ApplyCustomWheel(state)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    SetVehicleMod(plyVeh, 23, GetVehicleMod(plyVeh, 23), state)
    
    if GetVehicleClass(plyVeh) == 8 then --Motorcycle
        SetVehicleMod(plyVeh, 24, GetVehicleMod(plyVeh, 24), state)
    end
end

function ApplyNeon(side, enabled)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalNeonLightState = enabled
    originalNeonLightSide = side

    SetVehicleNeonLightEnabled(plyVeh, side, enabled)
end

function ApplyNeonColour(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalNeonColourR = r
    originalNeonColourG = g
    originalNeonColourB = b

    SetVehicleNeonLightsColour(plyVeh, r, g, b)
end

function ApplyXenonLights(category, state)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    ToggleVehicleMod(plyVeh, category, state)
end

function ApplyXenonColour(colour)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalXenonColour = colour

    SetVehicleHeadlightsColour(plyVeh, colour)
end

function ApplyOldLivery(liv)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    originalOldLivery = liv

    SetVehicleLivery(plyVeh, liv)
end

function ApplyPlateIndex(index)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    originalPlateIndex = index
    SetVehicleNumberPlateTextIndex(plyVeh, index)
end

function ApplyTyreSmoke(r, g, b)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    ToggleVehicleMod(plyVeh, 20, true)
    SetVehicleTyreSmokeColor(plyVeh, r, g, b)
end

function ExitBennys()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    saveVehicle()

    DisplayMenuContainer(false)

    FreezeEntityPosition(plyVeh, false)
    SetEntityCollision(plyVeh, true, true)

    SetTimeout(100, function()
        DestroyMenus()
    end)

    isPlyInBennys = false
    TriggerEvent('vehicle:leftBennys')
    TriggerEvent('inmenu', isPlyInBennys)
    TriggerServerEvent("varial-bennys:removeFromInUse", currentBennys)
    --TriggerEvent('varial-interaction:ShowUI', 'show', ("%s"):format("Benny's"))
    currentBennys = nil
end

local function freezeVehicle(pVeh, pBennys)
    SetVehicleModKit(pVeh, 0)
    SetEntityCoords(pVeh, pBennys.pos)
    SetEntityHeading(pVeh, pBennys.heading)
    FreezeEntityPosition(pVeh, true)
    SetEntityCollision(pVeh, false, true)
    SetVehicleOnGroundProperly(pVeh)
end

local function finishEnterLocation()
    isPlyInBennys = true
    disableControls()
    TriggerEvent('inmenu', isPlyInBennys)
    exports['varial-interaction']:hideInteraction()
end

RegisterCommand('bennys', function()
    TriggerEvent('varial-admin:bennys')
    RepairVehicle()
end)

RegisterNetEvent('varial-admin:bennys', function()
    devmode = true
    local bennys = getClosestBennys()
   -- currentBennys = bennystuner
    cheap = true
    isAtEmployedBennys = false
    isAtRepairsOnlyBennys = false
    enterLocation(bennys, false)
    RepairVehicle()
end)

function enterLocation(pBennys, needsRepair)
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local vehclass = GetVehicleClass(plyVeh)
    local isMotorcycle = false

    if devmode then
        freezeVehicle(plyVeh, pBennys)
    else
        if (vehclass == 18 ) or (needsRepair) then
            freezeVehicle(plyVeh, pBennys)
        elseif (vehclass ~= 18 and bennysAccess ~= 'police') or (needsRepair) then
            freezeVehicle(plyVeh, pBennys)
        end
    end

    if vehclass == 8 then --Motorcycle
        isMotorcycle = true
    else
        isMotorcycle = false
    end

    InitiateMenus(isMotorcycle, GetVehicleBodyHealth(plyVeh))

    SetTimeout(100, function()
        if needsRepair then
            DisplayMenu(true, "repairMenu")
            DisplayMenuContainer(true)
        else
            if devmode then
                DisplayMenu(true, "mainMenu")
                DisplayMenuContainer(true)
            else
                if vehclass == 18  then
                    DisplayMenu(true, "mainMenu")
                    DisplayMenuContainer(true)
                elseif vehclass ~= 18 and bennysAccess ~= 'police' then
                    DisplayMenu(true, "mainMenu")
                    DisplayMenuContainer(true)
                end
            end
        end

        PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end)

    if devmode then
        finishEnterLocation()
    else
        if vehclass == 18  or (needsRepair) then
            finishEnterLocation()
        elseif vehclass ~= 18 and bennysAccess ~= 'police' or (needsRepair) then
            finishEnterLocation()
        end
    end
end

function disableControls()
    CreateThread(function()
        while isPlyInBennys do
            DisableControlAction(1, 38, true) --Key: E
            DisableControlAction(1, 172, true) --Key: Up Arrow
            DisableControlAction(1, 173, true) --Key: Down Arrow
            DisableControlAction(1, 177, true) --Key: Backspace
            DisableControlAction(1, 176, true) --Key: Enter
            DisableControlAction(1, 71, true) --Key: W (veh_accelerate)
            DisableControlAction(1, 72, true) --Key: S (veh_brake)
            DisableControlAction(1, 34, true) --Key: A
            DisableControlAction(1, 35, true) --Key: D
            DisableControlAction(1, 75, true) --Key: F (veh_exit)
        
            if IsDisabledControlJustReleased(1, 172) then --Key: Arrow Up
                MenuScrollFunctionality("up")
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end
        
            if IsDisabledControlJustReleased(1, 173) then --Key: Arrow Down
                MenuScrollFunctionality("down")
                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end
        
            if IsDisabledControlJustReleased(1, 176) then --Key: Enter
                MenuManager(true)
                PlaySoundFrontend(-1, "OK", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end
        
            if IsDisabledControlJustReleased(1, 177) then --Key: Backspace
                MenuManager(false)
                PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
            end

            Wait(0)
        end
    end)
end

function checkVehiclePresets(model)
    for tmodel, tpresets in pairs(vehiclePresets) do
        local thash = GetHashKey(tmodel)

        if tostring(thash) == tostring(model) then
            return tpresets
        end
    end
end

--#[Event Handlers]#--
RegisterNetEvent("varial-bennys:purchaseSuccessful")
AddEventHandler("varial-bennys:purchaseSuccessful", function()
    isPurchaseSuccessful = true
    attemptingPurchase = false
end)

RegisterNetEvent("varial-bennys:purchaseFailed")
AddEventHandler("varial-bennys:purchaseFailed", function()
    isPurchaseSuccessful = false
    attemptingPurchase = false
end)

local businessesCacheTimer = nil
AddEventHandler("bennys:enter", function()
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)
    local vehclass = GetVehicleClass(plyVeh)
    local repair = false

    if GetVehicleBodyHealth(plyVeh) < 1000.0 then
        repair = true
    end

    local bennys = getClosestBennys()

    --[[local isBennysInUse = RPC.execute("varial-bennys:checkIfUsed", currentBennys)
    if isBennysInUse ~= nil then
        TriggerEvent("DoLongHudText", "This Benny's is already in use", 2)
        return
    end]]

    bennysAccess = bennys.access

    if bennysAccess then
        local govjob = exports["isPed"]:isPed("myjob")

        if govjob ~= 'police'  then
            return
        elseif govjob == 'police'  then
            goto hasAccess
        end

        local jobAccess = false
        if businessesCacheTimer ~= nil and businessesCacheTimer + 60000 > GetGameTimer() then -- 1 minute
            jobAccess = businesses.bennysAccess
        else
            businesses = {}
            
            local characterId = exports["isPed"]:isPed("cid")

            jobAccess = RPC.execute("IsEmployedAtBusiness", { character = { id = characterId }, business = { id = bennysAccess} })

            businesses = {bennysAccess = jobAccess}

            businessesCacheTimer = GetGameTimer()
        end

        if not jobAccess then
            TriggerEvent("DoLongHudText", "You do not have access for this Benny's", 2)
            return
        end
    end

    if vehclass == 18 and bennysAccess ~= 'police' then
        TriggerEvent("DoLongHudText", "This Benny's does not service Emergency Vehicles", 2)
        return
    end

    ::hasAccess::
    TriggerServerEvent("varial-bennys:addToInUse", currentBennys)
    enterLocation(bennys, repair)
end)

function getClosestBennys()
    local pos = GetEntityCoords(PlayerPedId())
    local dist = -1
    local closestBennys = nil
    
    for bennys, v in pairs(bennysLocations) do
        local newdist = #(pos - v.pos)

        if dist == -1 or newdist < dist then
            dist = newdist
            closestBennys = bennysLocations[bennys]
            currentBennys = bennys
        end
    end

    return closestBennys
end

RegisterNetEvent("varial-admin:currentDevmode")
AddEventHandler("varial-admin:currentDevmode", function(pDevmode)
    devmode = pDevmode
end)

-- PolyZone stuff
AddEventHandler("varial-polyzone:enter", function(zone, data)
    if zone ~= "bennys" then return end
    local plyPed = PlayerPedId()
    local plyVeh = GetVehiclePedIsIn(plyPed, false)

    if plyVeh ~= 0 and GetPedInVehicleSeat(plyVeh, -1) == plyPed then
        exports['varial-interaction']:showInteraction("Bennys")
    end
end)

AddEventHandler("varial-polyzone:exit", function(zone)
    if zone ~= "bennys" then return end
    exports['varial-interaction']:hideInteraction()
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() and isPlyInBennys then
        ExitBennys()
    end
end)