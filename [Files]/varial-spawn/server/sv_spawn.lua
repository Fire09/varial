function Login.decode(tableString)
    if tableString == nil or tableString =="" then
        return {}
    else
        return json.decode(tableString)
    end
end

RegisterServerEvent("login:getCharModels")
AddEventHandler("login:getCharModels", function(charlist, isReset)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)

    local list = ""
    for i=1,#charlist do
        if i == #charlist then
            list = list..charlist[i]
        else
            list = list..charlist[i]..","
        end
    end

    if charlist == nil or json.encode(charlist) == "[]" then
        TriggerClientEvent("login:CreatePlayerCharacterPeds", src, nil, isReset)
        return
    end

    exports.oxmysql:execute("SELECT cc.*, cf.*, ct.* FROM character_face cf LEFT JOIN character_current cc on cc.cid = cf.cid LEFT JOIN playerstattoos ct on ct.identifier = cf.cid WHERE cf.cid IN ("..list..")", {}, function(result)
        if result then 
            local temp_data = {}

            for k,v in pairs(result) do
                temp_data[v.cid] = {
                    model = v.model,
                    drawables = Login.decode(v.drawables),
                    props = Login.decode(v.props),
                    drawtextures = Login.decode(v.drawtextures),
                    proptextures = Login.decode(v.proptextures),
                    hairColor = Login.decode(v.hairColor),
                    headBlend = Login.decode(v.headBlend),
                    headOverlay= Login.decode(v.headOverlay),
                    headStructure = Login.decode(v.headStructure),
                    tattoos = Login.decode(v.tattoos),
                }
            end
            
            for i=1, #charlist do
                if temp_data[charlist[i]] == nil then
                    temp_data[charlist[i]] = nil
                end 
            end

            TriggerClientEvent("login:CreatePlayerCharacterPeds", src, temp_data, isReset)
        end
    end)
end)


RegisterServerEvent("varial-spawn:licenses")
AddEventHandler("varial-spawn:licenses", function()
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local char = user:getVar("character")
    exports.oxmysql:execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {['@type'] = "Firearm",['@owner'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, owner, status) VALUES (@type, @owner, @status)", {['@type'] = "Driver", ['@owner'] = char.id, ['@status'] = "1"})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {['@type'] = "Hunting",['@owner'] = char.id})
    exports.oxmysql:execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {['@type'] = "Fishing",['@owner'] = char.id})
end)

RegisterServerEvent("backpack:give:items")
AddEventHandler("backpack:give:items", function()
    local src = source
    TriggerClientEvent("player:receiveItem", src, "mobilephone", 1)
    TriggerClientEvent("player:receiveItem", src, "radio", 1)
    TriggerClientEvent("player:receiveItem", src, "idcard", 1)
    TriggerClientEvent("player:receiveItem", src, "water", 2)
    TriggerClientEvent("player:receiveItem", src, "sandwich", 2)
end)

RegisterServerEvent("SpawnCustomPeds")
AddEventHandler("SpawnCustomPeds", function(modelHash, coords1, coords2, coords3, pedheading)
    newPed = CreatePed(0, modelHash, coords1, coords2, coords3, 0.72, false, false)
    SetEntityHeading(newPed, pedheading)
    TaskPlayAnim(newPed, "timetable@ron@ig_3_couch", "base", 1.0,-2.0, -1, 1, 1, true, true, true)
end)