Citizen.CreateThread(function()
  TriggerEvent('deleteAllTweets')
  TriggerEvent('deleteAllYP')
end)

local callID = nil

RegisterNetEvent('GetTweets')
AddEventHandler('GetTweets', function(onePlayer)
  local src = source
  exports.oxmysql:execute('SELECT * FROM (SELECT * FROM tweets ORDER BY `time` DESC LIMIT 50) sub ORDER BY time ASC', {}, function(tweets) -- Get most recent 100 tweets
      if onePlayer then
          TriggerClientEvent('Client:UpdateTweets', src, tweets)
      else
          TriggerClientEvent('Client:UpdateTweets', src, tweets)
      end
  end)
end)

RegisterNetEvent('Tweet')
AddEventHandler('Tweet', function(handle, data, time)

  exports.oxmysql:execute('INSERT INTO tweets (handle, message, time) VALUES (@handle, @message, @time)', {['handle'] = handle,['message'] = data,['time'] = time}, function(result)
      TriggerEvent('GetTweets', source, true)
  end)
  local newtwat = { ['handle'] = handle, ['message'] = data, ['time'] = time}
  TriggerClientEvent('Client:UpdateTweet', -1, newtwat)
end)


RegisterNetEvent('Server:GetHandle')
AddEventHandler('Server:GetHandle', function()
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
local char = user:getCurrentCharacter()
  fal = "@" .. char.first_name .. "_" .. char.last_name
  local handle = fal
  TriggerClientEvent('givemethehandle', src, handle)
  TriggerClientEvent('updateNameClient', src, char.first_name, char.last_name)
end)

--[[ Contacts stuff ]]

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local characterId = user:getVar("character").id
  local handle = handle

  exports.oxmysql:execute('INSERT INTO user_contacts (identifier, name, number) VALUES (@identifier, @name, @number)', {
      ['identifier'] = characterId,
      ['name'] = name,
      ['number'] = number
  }, function(result)
      -- TriggerEvent('phone:getContacts', src)
      TriggerClientEvent('refreshContacts', src)
      TriggerClientEvent('phone:newContact', src, name, number)
  end)
end)

RegisterNetEvent('deleteContact')
AddEventHandler('deleteContact', function(name, number)
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local characterId = user:getVar("character").id

  exports.oxmysql:execute('DELETE FROM user_contacts WHERE name = @name AND number = @number LIMIT 1', {
      ['name'] = name,
      ['number'] = number
  }, function (result)
      TriggerClientEvent('phone:loadContacts', src, {})
      TriggerClientEvent('refreshContacts', src)
      TriggerClientEvent('phone:deleteContact', src, name, number)
  end)
end)

RegisterNetEvent('phone:getContacts')
AddEventHandler('phone:getContacts', function(cid)
    local src = source
    local contacts = getContacts(cid, function(contacts)
      if (contacts) then
          TriggerClientEvent('phone:loadContacts', src, contacts)
      else
          TriggerClientEvent('phone:loadContacts', src, {})
        end
    end)
end)

function getMessagesBetweenUsers(sender, recipient, callback)
  exports.oxmysql:execute("SELECT id, sender, receiver, message, date FROM user_messages WHERE (receiver = @from OR sender = @from) and (receiver = @to or sender = @to)", {
  ['from'] = sender,
  ['to'] = recipient
  }, function(result) callback(result) end)
end

function saveSMS(receiver, sender, message, callback)
  exports.oxmysql:execute("INSERT INTO user_messages (`receiver`, `sender`, `message`) VALUES (@receiver, @sender, @msg)",
  {['receiver'] = tonumber(receiver), ['sender'] = tonumber(sender), ['msg'] = message}, function(rowsChanged)
      exports.oxmysql:execute("SELECT id FROM user_messages WHERE receiver = @receiver AND sender = @sender AND message = @msg",
  {['receiver'] = tonumber(receiver), ['sender'] = tonumber(sender), ['msg'] = message}, function(result) if callback then callback(result) end end)
  end)
end

function getContacts(identifier, callback)
  exports.oxmysql:execute("SELECT name,number FROM user_contacts WHERE identifier = @identifier ORDER BY name ASC", {
      ['identifier'] = identifier
  }, function(result) callback(result) end)
end

RegisterNetEvent('getNM')
AddEventHandler('getNM', function(pNumber)
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local characterId = user:getVar("character").id
  local pNumber = getNumberPhone(characterId)
  TriggerClientEvent("client:updatePNumber",src,pNumber)
end)


RegisterNetEvent('phone:deleteYP')
AddEventHandler('phone:deleteYP', function(number)
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local characterId = user:getVar("character").id
  local myNumber = getNumberPhone(characterId)
  exports.oxmysql:execute('DELETE FROM phone_yp WHERE phoneNumber = @phoneNumber', {
      ['phoneNumber'] = myNumber
  }, function (result)
      TriggerClientEvent('refreshYP', src)

  end)
end)

--[[ Phone calling stuff ]]

function getNumberPhone(cid)
  local penis
  exports.oxmysql:execute("SELECT phone_number FROM characters WHERE id = @id", {
      ['id'] = cid
  }, function(result)
      if result[1] ~= nil then
          penis = result[1].phone_number
      else
          penis = nil
      end
  end)
  Wait(200)
  if penis ~= nil then
      return penis
  else
      return nil
  end
end

function getIdentifierByPhoneNumber(phone_number)
  local prick
  exports.oxmysql:execute("SELECT id FROM characters WHERE phone_number = @phone_number", {
      ['phone_number'] = phone_number
  }, function(result)
      if result[1] ~= nil then
          prick = result[1].id
      else
          prick = nil
      end
  end)
  Wait(200)
  if prick ~= nil then
      return prick
  else
      return nil
  end
end

-- RegisterServerEvent('ReturnHouseKeys')
-- AddEventHandler('ReturnHouseKeys', function(cid)
--   local src = source
--   local houses = {}
--   local shared = {}
--   exports.oxmysql:execute("SELECT * FROM __housedata WHERE cid= ? ", {cid}, function(chicken)
--       for k, v in pairs(chicken) do
--           if v ~= nil then
--               if v.housename ~= nil then
--                   local random = math.random(1111,9999)
--                   houses[random] = {}
--                   table.insert(houses[random], {["house_name"] = v.housename, ["house_model"] = v.house_model, ["house_id"] = v.house_id, ["days"]= v.days, ["overall"] = v.overall, ["payments"] = v.payments, ["amountdue"] = v.due})
--                   TriggerClientEvent('returnPlayerKeys', src, houses, shared)
--               end
--           end
--       end
--   end)
--   exports.oxmysql:execute('SELECT * FROM __housekeys WHERE `cid`= ?', {cid}, function(returnData)
--       for k, r in pairs(returnData) do
--           if r ~= nil then
--               if r.housename ~= nil then
--                   local random = math.random(1111,9999)
--                   shared[random] = {}
--                   table.insert(shared[random], {["house_name"] = r.housename, ["house_model"] = r.house_model, ["house_id"] = r.house_id})
--                  TriggerClientEvent('returnPlayerKeys', src, houses, shared)
--               end
--           end
--       end
--   end)
-- end)

RegisterServerEvent('requestPing')
AddEventHandler('requestPing', function(target, x,y,z, pIsAnon)
  local src = source
  TriggerClientEvent('AllowedPing', tonumber(target), x,y,z, src, name, pIsAnon)
end)

RegisterServerEvent('pingAccepted')
AddEventHandler('pingAccepted', function(target)
  local target = tonumber(target)
  TriggerClientEvent('DoLongHudText', target, "You ping was accepted!", 5)
end)

RegisterServerEvent('pingDeclined')
AddEventHandler('pingDeclined', function(target)
  local target = tonumber(target)
  TriggerClientEvent('DoLongHudText', target, "You ping was declined!", 5)
end)


RegisterNetEvent('phone:callContact')
AddEventHandler('phone:callContact', function(cid, targetnumber, toggle)
  local src = source
  local targetid = 0
  local targetIdentifier = getIdentifierByPhoneNumber(targetnumber)
  local srcPhone = getNumberPhone(cid)

  if not toggle then
      TriggerClientEvent('phone:initiateCall', src)
      for _, player in ipairs(GetPlayers()) do
          local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(player))
          local char = user:getVar("character")
          if char.id == targetIdentifier then
              TriggerClientEvent('phone:receiveCall', tonumber(player), targetnumber, src, getPhoneRandomNumber())
          end
      end
  else
      TriggerClientEvent('phone:initiateCall', src)
      
    for _, player in ipairs(GetPlayers()) do
        local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(player))
        local char = user:getVar("character")
        if char.id == targetIdentifier then
          TriggerClientEvent('phone:receiveCall', tonumber(player), targetnumber, src, srcPhone)
      end
    end
  end
end)

RegisterNetEvent('phone:messageSeen')
AddEventHandler('phone:messageSeen', function(id)
  id = tonumber(id)
  if id ~= nil then
      exports.oxmysql:execute("UPDATE user_messages SET isRead = 1 WHERE id = @id", {['id'] = tonumber(id)})
  end
end)

RegisterNetEvent('phone:getSMS')
AddEventHandler('phone:getSMS', function(cid)
  local src = source
  exports.oxmysql:execute("SELECT phone_number FROM characters WHERE id = @id", {['id'] = cid}, function(result2)
      local mynumber = result2[1].phone_number
      exports.oxmysql:execute("SELECT * FROM user_messages WHERE receiver = @mynumber OR sender = @mynumber ORDER BY id DESC", {['mynumber'] = mynumber}, function(result)

          local numbers ={}
          local convos = {}
          local valid
          
          for k, v in pairs(result) do
              valid = true
              if v.sender == mynumber then
                  for i=1, #numbers, 1 do
                      if v.receiver == numbers[i] then
                          valid = false
                      end
                  end
                  if valid then
                      table.insert(numbers, v.receiver)
                  end
              elseif v.receiver == mynumber then
                  for i=1, #numbers, 1 do
                      if v.sender == numbers[i] then
                          valid = false
                      end
                  end
                  if valid then
                      table.insert(numbers, v.sender)
                  end
              end
          end
          
          for i, j in pairs(numbers) do
              for g, f in pairs(result) do
                  if j == f.sender or j == f.receiver then
                      table.insert(convos, {
                          id = f.id,
                          sender = f.sender,
                          receiver = f.receiver,
                          message = f.message,
                          date = f.date
                      })
                      break
                  end
              end
          end
      
          local data = ReverseTable(convos)
          TriggerClientEvent('phone:loadSMS', src, data, mynumber)
      end)
  end)
end)

function ReverseTable(t)
  local reversedTable = {}
  local itemCount = #t
  for k, v in ipairs(t) do
      reversedTable[itemCount + 1 - k] = v
  end
  return reversedTable
end

RegisterServerEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
  local src= source
  TriggerClientEvent('phone:setServerTime', src, os.date('%H:%M:%S', os.time()))
end)

RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(cid, receiver, message)
  print(receiver)
  local src = source
  local mynumber = getNumberPhone(cid)
  local target = getIdentifierByPhoneNumber(receiver)
  local Players = GetPlayers()
  --if receiver ~= mynumber then
  exports.oxmysql:execute('INSERT INTO user_messages (sender, receiver, message) VALUES (@sender, @receiver, @message)', {
      ['sender'] = mynumber,
      ['receiver'] = receiver,
      ['message'] = message
  }, function(result)
  end)

  print(target)
  
  for _, player in ipairs(GetPlayers()) do
    local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(player))
    local characterId = user:getVar("character").id
    if characterId ~= nil then
        if characterId == target then
          exports.oxmysql:execute('SELECT name FROM user_contacts WHERE identifier = ? AND number = ?', {target, mynumber}, function(result)
            -- print(result[1].name)
            if result[1] ~= nil then 
                TriggerClientEvent('phone:newSMS', tonumber(player), 1, mynumber, result[1].name, message, os.time())
                TriggerClientEvent('DoLongHudText', src, "Message Sent!", 1)
            else
                TriggerClientEvent('phone:newSMS', tonumber(player), 1, mynumber, mynumber, message, os.time())
                TriggerClientEvent('DoLongHudText', src, "Message Sent!", 1)
            end
          end)
        end
      end
    end
end)

RegisterNetEvent('phone:serverGetMessagesBetweenParties')
AddEventHandler('phone:serverGetMessagesBetweenParties', function(sender, receiver, displayName)
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local characterId = user:getVar("character").id
  local mynumber = getNumberPhone(characterId)
  exports.oxmysql:execute("SELECT * FROM user_messages WHERE (sender = @sender AND receiver = @receiver) OR (sender = @receiver AND receiver = @sender) ORDER BY id ASC",
  {['sender'] = sender,
  ['receiver'] = receiver},
  function(result)
      if result ~= nil then
          TriggerClientEvent('phone:clientGetMessagesBetweenParties', src, result, displayName, mynumber)
      end
  end)
end)

RegisterNetEvent('phone:StartCallConfirmed')
AddEventHandler('phone:StartCallConfirmed', function(mySourceID)
  local channel = math.random(10000, 99999)
  local src = source

  TriggerClientEvent('phone:callFullyInitiated', mySourceID, mySourceID, src)
  TriggerClientEvent('phone:callFullyInitiated', src, src, mySourceID)

  TriggerClientEvent('phone:addToCall', source, channel)
  TriggerClientEvent('phone:addToCall', mySourceID, channel)

  TriggerClientEvent('phone:id', src, channel)
  TriggerClientEvent('phone:id', mySourceID, channel)
end)


RegisterNetEvent('phone:EndCall')
AddEventHandler('phone:EndCall', function(mySourceID, stupidcallnumberidk, somethingextra)
  local src = source
  TriggerClientEvent('phone:removefromToko', src, stupidcallnumberidk)
  TriggerClientEvent('varial-phone:RemoveCall', src)

  if mySourceID ~= 0 or mySourceID ~= nil then
      TriggerClientEvent('phone:removefromToko', mySourceID, stupidcallnumberidk)
      TriggerClientEvent('phone:otherClientEndCall', mySourceID)
  end

  if somethingextra then
      TriggerClientEvent('phone:otherClientEndCall', src)
  end
end)

RegisterCommand("answer", function(source, args, rawCommand)
  local src = source
  TriggerClientEvent('phone:answercall', src)
end, false)

RegisterCommand("a", function(source, args, rawCommand)
  local src = source
  TriggerClientEvent('phone:answercall', src)
end, false)

RegisterCommand("h", function(source, args, rawCommand)
  local src = source
  TriggerClientEvent('phone:hangup', src)
end, false)


RegisterCommand("hangup", function(source, args, rawCommand)
  local src = source
  TriggerClientEvent('phone:hangup', src)
end, false)


function getPlayerID(source)
  local identifiers = GetPlayerIdentifiers(source)
  local player = getIdentifiant(identifiers)
  return player
end
function getIdentifiant(id)
  for _, v in ipairs(id) do
      return v
  end
end

AddEventHandler('playerSpawned',function(source)
  local sourcePlayer = tonumber(source)
  local identifier = getPlayerID(source)
  getOrGeneratePhoneNumber(sourcePlayer, identifier, function (myPhoneNumber)
  end)
end)

function getOrGeneratePhoneNumber (sourcePlayer, identifier, cb)
  local sourcePlayer = sourcePlayer
  local identifier = identifier
  local user = exports["varial-base"]:getModule("Player"):GetUser(sourcePlayer)
  local char = user:getVar("character")
  local myPhoneNumber = getNumberPhone(char.id)
  if myPhoneNumber == '0' or myPhoneNumber == nil then
      repeat
          myPhoneNumber = getPhoneRandomNumber()
          local id = getIdentifierByPhoneNumber(myPhoneNumber)
      until id == nil
      exports.oxmysql:execute("UPDATE users SET phone_number = @myPhoneNumber WHERE identifier = @identifier", {
          ['myPhoneNumber'] = myPhoneNumber,
          ['identifier'] = identifier
      }, function ()
          cb(myPhoneNumber)
      end)
  else
      cb(myPhoneNumber)
  end
end

function getPhoneRandomNumber()
  local numBase0 = 4
  local numBase1 = 15
  local numBase2 = math.random(100,999)
  local numBase3 = math.random(1000,9999)
  local num = string.format(numBase0 .. "" .. numBase1 .. "" .. numBase2 .. "" .. numBase3)
  return num
end

RegisterNetEvent('phone:getServerTime')
AddEventHandler('phone:getServerTime', function()
  local hours, minutes, seconds = Citizen.InvokeNative(0x50C7A99057A69748, Citizen.PointerValueInt(), Citizen.PointerValueInt(), Citizen.PointerValueInt())
  TriggerClientEvent('timeheader', -1, tonumber(hours), tonumber(minutes))
end)

--[[ Yellow Pages ]]

RegisterNetEvent('getYP')
AddEventHandler('getYP', function()
  local source = source
  exports.oxmysql:execute('SELECT * FROM phone_yp LIMIT 30', {}, function(yp)
      local deorencoded = json.encode(yp)
      TriggerClientEvent('YellowPageArray', -1, yp)
      TriggerClientEvent('YPUpdatePhone', source)
  end)
end)

RegisterNetEvent('phone:updatePhoneJob')
AddEventHandler('phone:updatePhoneJob', function(advert)
  --local handle = handle
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local mynumber = char.phone_number

  fal = char.first_name .. " " .. char.last_name

  exports.oxmysql:execute('INSERT INTO phone_yp (name, job, phoneNumber) VALUES (@name, @job, @phoneNumber)', {
      ['name'] = fal,
      ['job'] = advert,
      ['phoneNumber'] = mynumber
  }, function(result)
      TriggerClientEvent('refreshYP', src)
  end)
end)

RegisterNetEvent('deleteAllYP')
AddEventHandler('deleteAllYP', function()
  local src = source
  exports.oxmysql:execute('DELETE FROM phone_yp', {}, function (result) end)
end)

RegisterNetEvent('deleteAllTweets')
AddEventHandler('deleteAllTweets', function()
  local src = source
  exports.oxmysql:execute('DELETE FROM tweets', {}, function (result) end)
end)

--Racing
local BuiltMaps = {}
local Races = {}

RegisterServerEvent('racing-global-race')
AddEventHandler('racing-global-race', function(map, laps, counter, reverseTrack, uniqueid, cid, raceName, startTime, mapCreator, mapDistance, mapDescription, street1, street2)
  Races[uniqueid] = { 
      ["identifier"] = uniqueid, 
      ["map"] = map, 
      ["laps"] = laps,
      ["counter"] = counter,
      ["reverseTrack"] = reverseTrack, 
      ["cid"] = cid, 
      ["racers"] = {}, 
      ["open"] = true, 
      ["raceName"] = raceName, 
      ["startTime"] = startTime, 
      ["mapCreator"] = mapCreator, 
      ["mapDistance"] = mapDistance, 
      ["mapDescription"] = mapDescription,
      ["raceComplete"] = false
  }

  TriggerEvent('racing:server:sendData', uniqueid, -1, 'event', 'open')
  local waitperiod = (counter * 1000)
  Wait(waitperiod)
  Races[uniqueid]["open"] = false
  -- if(math.random(1, 10) >= 5) then
  --     TriggerEvent("dispatch:svNotify", {
  --         dispatchCode = "10-94",
  --         firstStreet = street1,
  --         secondStreet = street2,
  --         origin = {
  --             x = BuiltMaps[map]["checkPoints"][1].x,
  --             y = BuiltMaps[map]["checkPoints"][1].y,
  --             z = BuiltMaps[map]["checkPoints"][1].z
  --         }
  -- })
  -- end
  TriggerEvent('racing:server:sendData', uniqueid, -1, 'event', 'close')
end)

RegisterServerEvent('racing-join-race')
AddEventHandler('racing-join-race', function(identifier)
  local src = source
  local player = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
  local playername = ""..char.first_name.." "..char.last_name..""
  Races[identifier]["racers"][cid] = {["name"] = PlayerName, ["cid"] = cid, ["total"] = 0, ["fastest"] = 0 }
  TriggerEvent('racing:server:sendData', identifier, src, 'event')
end)

RegisterServerEvent('race:completed2')
AddEventHandler('race:completed2', function(fastestLap, overall, sprint, identifier)
  local src = source
  local player = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
  local playername = ""..char.first_name.." "..char.last_name..""
  Races[identifier]["racers"][cid] = { ["name"] = PlayerName, ["cid"] = cid, ["total"] = overall, ["fastest"] = fastestLap}
  Races[identifier].sprint = sprint
  TriggerEvent('racing:server:sendData', identifier, -1, 'event')

  if not Races[identifier]["raceComplete"] then
      exports.oxmysql:execute("UPDATE racing_tracks SET races = races+1 WHERE id = '"..tonumber(Races[identifier].map).."'", function(results)
          if results.changedRows > 0 then
              Races[identifier]["raceComplete"] = true
          end
      end)
  end

  if(Races[identifier].sprint and Races[identifier]["racers"][cid]["total"]) then
      exports.oxmysql:execute("UPDATE racing_tracks SET fastest_sprint = "..tonumber(Races[identifier]["racers"][cid]["total"])..", fastest_sprint_name = '"..tostring(PlayerName).."' WHERE id = "..tonumber(Races[identifier].map).." and (fastest_sprint IS NULL or fastest_sprint > "..tonumber(Races[identifier]["racers"][cid]["total"])..")", function(results)
          if results.changedRows > 0 then
          end
      end)
  else
      exports.oxmysql:execute("UPDATE racing_tracks SET fastest_lap = "..tonumber(Races[identifier]["racers"][cid]["fastest"])..", fastest_name = '"..tostring(PlayerName).."' WHERE id = "..tonumber(Races[identifier].map).." and (fastest_lap IS NULL or fastest_lap > "..tonumber(Races[identifier]["racers"][cid]["fastest"])..")", function(results)
          if results.changedRows > 0 then
          end
      end)
  end
end)


RegisterServerEvent("racing:server:sendData")
AddEventHandler('racing:server:sendData', function(pEventId, clientId, changeType, pSubEvent)
  local dataObject = {
      eventId = pEventId, 
      event = changeType,
      subEvent = pSubEvent,
      data = {}
  }
  if (changeType =="event") then
      dataObject.data = (pEventId ~= -1 and Races[pEventId] or Races)
  elseif (changeType == "map") then
      dataObject.data = (pEventId ~= -1 and BuiltMaps[pEventId] or BuiltMaps)
  end
  TriggerClientEvent("racing:data:set", -1, dataObject)
end)

function buildMaps(subEvent)
  local src = source
  subEvent = subEvent or nil
  BuiltMaps = {}
  exports.oxmysql:execute("SELECT * FROM racing_tracks", {}, function(result)
      for i=1, #result do
          local correctId = tostring(result[i].id)
          BuiltMaps[correctId] = {
              checkPoints = json.decode(result[i].checkPoints),
              track_name = result[i].track_name,
              creator = result[i].creator,
              distance = result[i].distance,
              races = result[i].races,
              fastest_car = result[i].fastest_car,
              fastest_name = result[i].fastest_name,
              fastest_lap = result[i].fastest_lap,
              fastest_sprint = result[i].fastest_sprint, 
              fastest_sprint_name = result[i].fastest_sprint_name,
              description = result[i].description
          }
      end
      local target = -1
      if(subEvent == 'mapUpdate') then
          target = src
      end
      TriggerEvent('racing:server:sendData', -1, target, 'map', subEvent)
  end)
end

RegisterServerEvent('racing-build-maps')
AddEventHandler('racing-build-maps', function()
  buildMaps('mapUpdate')
end)

RegisterServerEvent('racing-map-delete')
AddEventHandler('racing-map-delete', function(deleteID)
  exports.oxmysql:execute("DELETE FROM racing_tracks WHERE id = @id", {
      ['id'] = deleteID })
  Wait(1000)
  buildMaps()
end)

RegisterServerEvent('racing-retreive-maps')
AddEventHandler('racing-retreive-maps', function()
  local src = source
  buildMaps('noNUI', src)
end)

RegisterServerEvent('racing-save-map')
AddEventHandler('racing-save-map', function(currentMap,name,description,distanceMap)
  local src = source
  local player = exports['varial-base']:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local playername = char.first_name .." ".. char.last_name

  -- exports.oxmysql:execute("INSERT INTO racing_tracks_new ('checkPoints', 'creator', 'track_name', 'distance', 'description') VALUES (@currentMap, @creator, @trackname, @distance, @description)",
  -- {['currentMap'] = json.encode(currentMap), ['creator'] = playername, ['trackname'] = name, ['distance'] = distanceMap, ['description'] = description})

  exports.oxmysql:execute("INSERT INTO `racing_tracks` (`checkPoints`, `creator`, `track_name`, `distance`, `description`) VALUES ('"..json.encode(currentMap).."', '"..tostring(playername).."', '"..tostring(name).."', '"..distanceMap.."',  '"..description.."')", function(results)
      Wait(1000)
      buildMaps()
  end)
end)

RegisterServerEvent('phone:RemovePayPhoneMoney')
AddEventHandler('phone:RemovePayPhoneMoney', function()
  local src = source
local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  user:removeMoney(25)
end)

RegisterServerEvent('phone:RemovePhoneJobSourceSend')
AddEventHandler('phone:RemovePhoneJobSourceSend', function(srcsent)
  local src = srcsent
  for i = 1, #YellowPageArray do
      if YellowPageArray[i]
      then 
        local a = tonumber(YellowPageArray[i]["src"])
        local b = tonumber(src)

        if a == b then
          table.remove(YellowPageArray,i)
        end
      end
  end
  TriggerClientEvent("YellowPageArray", -1 , YellowPageArray)
end)

RegisterNetEvent('phone:deleteYP')
AddEventHandler('phone:deleteYP', function(number)
  local src = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getCurrentCharacter()
  local cid = char.id
  local mynumber = getNumberPhone(cid)
  exports.oxmysql:execute('DELETE FROM phone_yp WHERE phoneNumber = @phoneNumber', {
      ['@phoneNumber'] = mynumber
  }, function (result)
      TriggerClientEvent('refreshYP', src)
  end)
end)

-- RegisterServerEvent("stocks:clientvalueupdate")
-- AddEventHandler("stocks:clientvalueupdate", function(table)
--     local src = source
--     local user = exports["varial-base"]:getModule("Player"):GetUser(src)
--     local char = user:getCurrentCharacter()
--     local tableinsert =  json.encode(table)
--     exports.oxmysql:execute("UPDATE characters SET stocks = @stock WHERE id = @cid",{
--         ['@stock'] = tableinsert,
--         ['@cid'] = char.id
--       }, function(data)
--     end)
-- end)

-- RegisterServerEvent("stocks:retrieve")
-- AddEventHandler("stocks:retrieve", function()
--     local src = source
--     local user = exports["varial-base"]:getModule("Player"):GetUser(src)
--     local char = user:getCurrentCharacter()

--     exports.oxmysql:execute("SELECT stocks FROM characters WHERE id = @id", {['id'] = char.id}, function(result)
--         if result[1].stocks then
--         TriggerClientEvent("stocks:clientvalueupdate", src, json.decode(result[1].stocks))
--         end
--     end)
-- end)

-- RegisterServerEvent("phone:stockTradeAttempt")
-- AddEventHandler("phone:stockTradeAttempt", function(index, id, sending)
--     local src = source
--     local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(id))
--     local char = user:getCurrentCharacter()

--     if user ~= nil then
--         TriggerClientEvent("Crypto:GivePixerium", id, sending)
--     end
-- end)

RegisterServerEvent('phone:triggerPager')
AddEventHandler('phone:triggerPager', function()
  TriggerClientEvent('phone:triggerPager', -1)
end)

RegisterNetEvent('message:tome')
AddEventHandler('message:tome', function(messagehueifh)
  local src = source		
  local first = messagehueifh:sub(1, 3)
  local second = messagehueifh:sub(4, 6)
  local third = messagehueifh:sub(7, 11)

  local msg = first .. "-" .. second .. "-" .. third
  TriggerClientEvent('chatMessage', src, 'Phone Number ', 4, msg)
end)

RegisterNetEvent('message:inDistanceZone')
AddEventHandler('message:inDistanceZone', function(somethingsomething, messagehueifh)
  local src = source		
  local first = messagehueifh:sub(1, 3)
  local second = messagehueifh:sub(4, 6)
  local third = messagehueifh:sub(7, 11)

  local msg = first .. "-" .. second .. "-" .. third
  TriggerClientEvent('chatMessage', somethingsomething, 'Phone Number ', 4, msg)
end)

RegisterCommand("pnum", function(source, args, rawCommand)
  local src = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = user:getVar("character")
  local srcPhone = getNumberPhone(char.id)
  TriggerClientEvent('sendMessagePhoneN', src, srcPhone)
end, false)


RegisterNetEvent('account:information:sv')
AddEventHandler('account:information:sv', function(cid)
  local src = source
  local licenceTable = {}
  exports.oxmysql:execute("SELECT type, status FROM user_licenses WHERE cid = @cid",{['cid'] = cid}, function(result)
      for i=1, #result do
          table.insert(licenceTable,{
              type = result[i].type,
              status = result[i].status,
          })
      end 
  end)

  exports.oxmysql:execute("SELECT `paycheck` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
      payslips = data[1].paycheck
  end)
  exports.oxmysql:execute("SELECT `phone_number` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
      pNumber = data[1].phone_number
  end)
  
  Citizen.Wait(100)
  TriggerClientEvent('account:information:cl', src, licenceTable, payslips, pNumber)
end)



RegisterServerEvent('group:pullinformation')
AddEventHandler('group:pullinformation', function(groupid,rank)
  local src = source
  exports.oxmysql:execute("SELECT * FROM character_passes WHERE pass_type = @groupid and rank > 0 ORDER BY rank DESC", {['groupid'] = groupid}, function(results)
      if results ~= nil then
          exports.oxmysql:execute("SELECT bank FROM group_banking WHERE group_type = @groupid", {['groupid'] = groupid}, function(result)
              local bank = 0
              if result[1] ~= nil then
                  bank = result[1].bank
              end
              TriggerClientEvent("group:fullList", src, results, bank, groupid)
          end)
      else
          TriggerClientEvent("phone:error", src)
      end
  end)
end)

RegisterServerEvent('server:currentpasses')
AddEventHandler('server:currentpasses', function()
  local src = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local ply = user:getCurrentCharacter()
  exports.oxmysql:execute("SELECT * FROM character_passes WHERE cid = @cid", {['cid'] = ply.id}, function(result)
      if result[1] ~= nil then
          TriggerClientEvent("client:passes", src, result)
          if result[1].pass_type == "police" or result[1].pass_type == "ems" then
          else
              TriggerClientEvent("varial-jobmanager:playerBecameJob", src, result[1].pass_type, result[1].pass_type, false)
          end
      end
  end)
end)

RegisterServerEvent('server:givepass')
AddEventHandler('server:givepass', function(pass_type, pass_name, rank, cid)
  local src = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  local ply = user:getCurrentCharacter()
  local SrcName = ply.first_name .. " " ..ply.last_name
  exports.oxmysql:execute("SELECT * FROM character_passes WHERE pass_type = ? AND cid = ?", {pass_type, cid}, function(data)
      if not data[1] then
          exports.oxmysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(name)
              if name[1] then
                  local name = name[1].first_name.. ' ' ..name[1].last_name
                  exports.oxmysql:execute('INSERT INTO character_passes (cid, rank, name, giver, pass_type, business_name) VALUES (@cid, @rank, @name, @giver, @pass_type, @business_name)', {
                      ['cid'] = cid,
                      ['rank'] = rank,
                      ['name'] = name,
                      ['giver'] = SrcName,
                      ['pass_type'] = pass_type,
                      ['business_name'] = pass_name
                  })
                  exports.oxmysql:execute("SELECT * FROM characters WHERE id = ?", {cid}, function(data2)
                      if data2[1] then
                          local pSteam = data2[1].owner
                          exports.oxmysql:execute('INSERT INTO jobs_whitelist (owner, cid, job, rank) VALUES (@owner, @cid, @job, @rank)', {
                              ['owner'] = pSteam,
                              ['cid'] = cid,
                              ['job'] = pass_type,
                              ['rank'] = rank
                          })

                      end
                  end)
                  TriggerClientEvent("DoLongHudText", src, "You hired " ..name.. " !")
                  TriggerClientEvent("Passes:RequestUpdate", -1, cid)
              else
                  TriggerClientEvent("DoLongHudText", src, "CID does not exist!")
              end
          end)
      else
          exports.oxmysql:execute("UPDATE character_passes SET `rank` = ? WHERE cid = ? AND pass_type = ?", {rank, cid, pass_type})
          TriggerClientEvent("DoLongHudText", src, "You have updated their rank!")
          TriggerClientEvent("Passes:RequestUpdate", -1, cid)
      end
  end)
end)


RegisterServerEvent('server:givepayGroup')
AddEventHandler('server:givepayGroup', function(groupname, amount, cid)
  local src = source
  exports.oxmysql:execute("SELECT * FROM group_banking WHERE group_type = @id", {['id'] = groupname}, function(data)
      if data[1].bank >= tonumber(amount) then
          exports.oxmysql:execute("SELECT paycheck FROM characters WHERE id = @id", {['id'] = cid}, function(result)
              exports.oxmysql:execute("UPDATE characters SET `paycheck` = @paycheck WHERE id = @id", { ['id'] = cid, ['paycheck'] = result[1].paycheck + tonumber(amount)})
              TriggerClientEvent("Yougotpaid", -1, cid)
              exports.oxmysql:execute("UPDATE group_banking SET `bank` = @bank WHERE group_type = @group_type", { ['group_type'] = groupname, ['bank'] = data[1].bank - tonumber(amount)})
          end)
      else
      TriggerClientEvent('DoLongHudText', src, 'You do not have enough money in your account to perform this transaction', 2)
      end
  end)
end)

RegisterServerEvent('server:gankGroup')
AddEventHandler('server:gankGroup', function(groupid, amount)
  local src = source
  local user = exports["varial-base"]:getModule("Player"):GetUser(src)
  if user:getCash() >= tonumber(amount) then
      exports.oxmysql:execute("SELECT * FROM group_banking WHERE group_type = @id", {['id'] = groupid}, function(result)
          exports.oxmysql:execute("UPDATE group_banking SET `bank` = @bank WHERE `group_type` = @id", { ['id'] = groupid, ['bank'] = result[1].bank + amount})
      end)
  end
end)

RegisterServerEvent("get:vehicle:coords")
AddEventHandler("get:vehicle:coords", function(plate)
  local src = source
  exports.oxmysql:execute("SELECT `coords` FROM characters_cars WHERE license_plate = @license_plate", {['license_plate'] = plate}, function(result)
      if result[1] then
          TriggerClientEvent("pass:coords:vehicle", src, json.decode(result[1].coords))
      end
  end)
end)

RegisterServerEvent("vehicle:coords")
AddEventHandler("vehicle:coords", function(plate, coords)
  local updatecoords = json.encode(coords)
  exports.oxmysql:execute("UPDATE characters_cars SET `coords` = @coords WHERE `license_plate` = @license_plate", { ['license_plate'] = plate, ['coords'] = updatecoords})
end)

RegisterServerEvent("car:Outstanding")
AddEventHandler("car:Outstanding", function()
  local src = source
  exports.oxmysql:execute("SELECT * FROM characters_cars WHERE finance_time = ? AND payments_left >= ? AND repoed = ?", {"0", "1", "0"}, function(result)
      local FinalResult = {}
      for _, v in pairs(result) do
          local vname = v.name
          local plate = v.license_plate
          local finance = v.financed
          local payments = v.payments_left
          owner = v.cid
          exports.oxmysql:execute('SELECT * FROM characters WHERE `id`= ?', {owner}, function(data)
              for _, d in pairs(data) do
                  phonenum = d.phone_number
                  local name = d.first_name .. ' ' .. d.last_name
                  local string = {
                      Plate = ('Vehicle: %s (%s)'):format(vname, plate),
                      AmountDue = ('Amount Due: $%s'):format(math.floor(finance/payments)),
                      cid = ('CID: %s'):format(owner),
                      Info = ('%s | %s'):format(phonenum, name)
                  }
                  
                  table.insert(FinalResult, string)
                  TriggerClientEvent("phone:listunpaid", src, FinalResult)
              end
          end) 
      end
  end)
end)

RegisterServerEvent("phone:saveWallpaper")
AddEventHandler("phone:saveWallpaper", function(cid, wall)
    exports.oxmysql:execute("UPDATE characters SET `wallpaper` = @wallpaper WHERE `id` = @cid", { ['cid'] = cid, ['wallpaper'] = wall})
end)

RegisterServerEvent("varial-phone:grabWallpaper")
AddEventHandler("varial-phone:grabWallpaper", function()
  local src = source
  local player = exports["varial-base"]:getModule("Player"):GetUser(src)
  local char = player:getCurrentCharacter()
  local cid = char.id
    exports.oxmysql:execute("SELECT `wallpaper` FROM characters WHERE id = @id",{['id'] = cid}, function(data)
      if data[1].wallpaper ~= nil then
          TriggerClientEvent('varial-phone:grabBackground', src, data[1].wallpaper)
      else
          TriggerClientEvent('varial-phone:grabBackground', src, "https://i.imgur.com/JVPavDg.jpg")
      end
    end)
end)

RegisterNetEvent('varial-phone:twatSendDoLongHudText')
AddEventHandler('varial-phone:twatSendDoLongHudText', function(handle, twat, time)
      TriggerClientEvent('varial-phone:TwatNotify', -1, handle, twat, time)
end)