AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}

AvailableTimeTypes = {
    'MORNING',
    'NOON',
    'EVENING',
    'NIGHT',
}

local CurrentWeather = "EXTRASUNNY"
local DynamicWeather = false
local baseTime = 0
local timeOffset = 0
local freezeTime = false
local blackout = false


--CODE

RegisterServerEvent('varial-weathersync:server:RequestStateSync')
AddEventHandler('varial-weathersync:server:RequestStateSync', function()
    TriggerClientEvent('varial-weathersync:client:SyncWeather', -1, CurrentWeather, blackout)
    TriggerClientEvent('varial-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
end)

function FreezeElement(element)
    if element == 'weather' then
        DynamicWeather = not DynamicWeather
    else
        freezeTime = not freezeTime
    end
end

RegisterServerEvent('varial-weathersync:server:setWeather')
AddEventHandler('varial-weathersync:server:setWeather', function(type)
    CurrentWeather = string.upper(type)
    TriggerEvent('varial-weathersync:server:RequestStateSync')
    print('changed')
end)

RegisterCommand("blackadmin", function()
    TriggerEvent("varial-weathersync:server:toggleBlackout")
end)
RegisterServerEvent('varial-weathersync:server:toggleBlackout')
AddEventHandler('varial-weathersync:server:toggleBlackout', function()
    ToggleBlackout()
end)

RegisterServerEvent('varial-weathersync:server:setTime')
AddEventHandler('varial-weathersync:server:setTime', function(hour, minute)
    if minute ~= nil then
        SetExactTime(hour, minute)
    else
        SetExactTime(hour, "1")
    end
end)

function SetWeather(type)
    CurrentWeather = string.upper(type)
    TriggerEvent('varial-weathersync:server:RequestStateSync')
end

function SetTime(type)
    if type:upper() == AvailableTimeTypes[1] then
        ShiftToMinute(0)
        ShiftToHour(9)
        TriggerEvent('varial-weathersync:server:RequestStateSync')
    elseif type:upper() == AvailableTimeTypes[2] then
        ShiftToMinute(0)
        ShiftToHour(12)
        TriggerEvent('varial-weathersync:server:RequestStateSync')
    elseif type:upper() == AvailableTimeTypes[3] then
        ShiftToMinute(0)
        ShiftToHour(18)
        TriggerEvent('varial-weathersync:server:RequestStateSync')
    else
        ShiftToMinute(0)
        ShiftToHour(23)
        TriggerEvent('varial-weathersync:server:RequestStateSync')
    end
end

function SetExactTime(hour, minute)
    local argh = tonumber(hour)
    local argm = tonumber(minute)
    if argh < 24 then
        ShiftToHour(argh)
    else
        ShiftToHour(0)
    end
    if argm < 60 then
        ShiftToMinute(argm)
    else
        ShiftToMinute(0)
    end
    local newtime = math.floor(((baseTime+timeOffset)/60)%24) .. ":"
    local minute = math.floor((baseTime+timeOffset)%60)
    if minute < 10 then
        newtime = newtime .. "0" .. minute
    else
        newtime = newtime .. minute
    end
    TriggerEvent('varial-weathersync:server:RequestStateSync')
end

function ToggleBlackout()
    blackout = not blackout
    TriggerEvent('varial-weathersync:server:RequestStateSync')
end

function ShiftToMinute(minute)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minute )
end

function ShiftToHour(hour)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hour ) * 60
end

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("varial-weathersync:server:RequestStateSync")
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local newBaseTime = os.time(os.date("!*t"))/2 + 360
        if freezeTime then
            timeOffset = timeOffset + baseTime - newBaseTime			
        end
        baseTime = newBaseTime
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        TriggerClientEvent('varial-weathersync:client:SyncTime', -1, baseTime, timeOffset, freezeTime)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3000000)
        TriggerClientEvent('varial-weathersync:client:SyncWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(18000000)
        if DynamicWeather then
            NextWeatherStage()
        end
    end
end)

