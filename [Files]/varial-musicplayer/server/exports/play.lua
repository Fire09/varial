function PlayUrl(source, name_, url_, volume_, loop_)
    TriggerClientEvent("varial-musicplayer:stateSound", source, "play", {
        soundId = name_,
        url = url_,
        volume = volume_,
        loop = loop_
    })
end

exports('PlayUrl', PlayUrl)

function PlayUrlPos(source, name_, url_, volume_, pos, loop_)
    TriggerClientEvent("varial-musicplayer:stateSound", source, "playpos", {
        soundId = name_,
        position = pos,
        url = url_,
        volume = volume_,
        loop = loop_
    })
end

exports('PlayUrlPos', PlayUrlPos)

function TextToSpeech(source, name_, lang, text, volume_, loop_)
    TriggerClientEvent("varial-musicplayer:stateSound", source, "texttospeech", {
        soundId = name_,
        url = text,
        lang = lang,
        volume = volume_,
        loop = loop_
    })
end

exports('TextToSpeech', TextToSpeech)

function TextToSpeechPos(source, name_, lang, text, volume_, pos, loop_)
    TriggerClientEvent("varial-musicplayer:stateSound", source, "texttospeechpos", {
        soundId = name_,
        lang = lang,
        position = pos,
        url = text,
        volume = volume_,
        loop = loop_
    })
end

exports('TextToSpeechPos', TextToSpeechPos)



RegisterServerEvent("vanilla:request:song:sv", function(url)
    local Speaker3 = vector3(115.78768920898, -1286.7399902344, 28.884038925171)
    TriggerClientEvent("play:song", -1, url, Speaker3, "VU")
    local data = {
        soundId = "VU",
        distance =  24,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("vanilla:change:volume", function(volume)
    local Speaker3 = vector3(115.78768920898, -1286.7399902344, 28.884038925171)
    local data = {
        soundId = "VU",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("burgershot:request:song:sv", function(url)
    local Speaker3 = vector3(-1195.4957275391, -892.31683349609, 14.561881065369)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BU")
    local data = {
        soundId = "BU",
        distance =  15,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("burgershot:change:volume", function(volume)
    local Speaker3 = vector3(-1195.4957275391, -892.31683349609, 14.561881065369)
    local data = {
        soundId = "BU",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("bahamas:request:song:sv", function(url)
    local Speaker3 = vector3(-1379.6644287109, -627.27758789062, 29.926954269409)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BH")
    local data = {
        soundId = "BH",
        distance =  40,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("bahamas:change:volume", function(volume)
    local Speaker3 = vector3(-1379.6644287109, -627.27758789062, 29.926954269409)
    local data = {
        soundId = "BH",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("bean:request:song:sv", function(url)
    local Speaker3 = vector3(-625.60089111328, 233.97686767578, 81.881462097168)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BM")
    local data = {
        soundId = "BM",
        distance =  10,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)


RegisterServerEvent("bean:change:volume", function(volume)
    local Speaker3 = vector3(-625.60089111328, 233.97686767578, 81.881462097168)
    local data = {
        soundId = "BM",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("best:request:song:sv", function(url)
    local Speaker3 = vector3(377.40530395508, -826.04797363281, 29.302112579346)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BB")
    local data = {
        soundId = "BB",
        distance =  10,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)

RegisterServerEvent("best:change:volume", function(volume)
    local Speaker3 = vector3(377.40530395508, -826.04797363281, 29.302112579346)
    local data = {
        soundId = "BB",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("tunershop:request:song:sv", function(url)
    local Speaker3 = vector3(138.04194641113, -3030.6838378906, 7.0457015037537)
    TriggerClientEvent("play:song", -1, url, Speaker3, "BBC")
    local data = {
        soundId = "BBC",
        distance =  35,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)

RegisterServerEvent("tunershop:change:volume", function(volume)
    local Speaker3 = vector3(138.04194641113, -3030.6838378906, 7.0457015037537)
    local data = {
        soundId = "BBC",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)

RegisterServerEvent("casino:request:song:sv", function(url)
    local Speaker3 = vector3(1119.3299560547, 237.28546142578, -49.788967132568)
    TriggerClientEvent("play:song", -1, url, Speaker3, "CS")
    local data = {
        soundId = "CS",
        distance =  100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "distance", data)
end)

RegisterServerEvent("casino:change:volume", function(volume)
    local Speaker3 = vector3(1119.3299560547, 237.28546142578, -49.788967132568)
    local data = {
        soundId = "CS",
        volume =  volume/100,
    }
    TriggerClientEvent("varial-musicplayer:stateSound", -1, "volume", data)
end)