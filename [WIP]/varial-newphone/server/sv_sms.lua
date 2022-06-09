function formatSMS(sms, phone)
    local numbers ={}
    local convos = {}
    local valid

    for k, v in pairs(sms) do
        valid = true
        if v.sender == phone then
        
            for i=1, #numbers, 1 do
                if v.receiver == numbers[i] then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v.receiver)
            end
        elseif v.receiver == phone then
            for i=1, #numbers, 1 do
                if v.sender == numbers[i] then
                    valid = false
                end
            end
            if valid then
                table.insert(numbers, v.sender)
                -- print(json.encode(numbers))
            end
        end
    end
        -- print("IS READ".)
    for i, j in pairs(numbers) do
        for g, f in pairs(sms) do
            if j == f.sender or j == f.receiver then
                table.insert(convos, {
                    id = f.id,
                    sender = f.sender,
                    receiver = f.receiver,
                    message = f.message,
                    date = f.date,
                    unread = f.isRead
                })
                break
            end
        end
    end
    return ReverseTable(convos)
end

RPC.register("varial-newphone:getSMS", function(source, id)
    local src = source
    local cid = id.param
    local myNumber = getNumber(cid)
    return getSMS(myNumber), myNumber
end)

function getSMS(phone)
    local sms = MySQL.query.await([[
        SELECT id, sender, receiver, message,date
        FROM user_messages
        WHERE receiver = ? OR sender = ?
        ORDER BY id DESC
    ]],
    { phone, phone })

    return formatSMS(sms, phone)
end

function getNumber(cid)
    local phoneNumber = MySQL.query.await([[
        SELECT phone_number FROM characters
        WHERE id = ?
    ]],
    { cid })
    return phoneNumber[1].phone_number
end

RegisterNetEvent('phone:getSMS')
AddEventHandler('phone:getSMS', function(cid)
  local src = source
  exports.oxmysql:execute("SELECT phone_number FROM characters WHERE id = @id", {['id'] = cid}, function(result2)
      local mynumber = result2[1].phone_number
      exports.oxmysql:execute("SELECT * FROM user_messages WHERE receiver = @mynumber OR sender = @mynumber ORDER BY date DESC", {['mynumber'] = mynumber}, function(result)

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
        -- print("IS READ".)
          for i, j in pairs(numbers) do
              for g, f in pairs(result) do
                  if j == f.sender or j == f.receiver then
                      table.insert(convos, {
                          id = f.id,
                          sender = f.sender,
                          receiver = f.receiver,
                          message = f.message,
                          date = f.date,
                          unread = f.isRead
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

RegisterNetEvent('phone:sendSMS')
AddEventHandler('phone:sendSMS', function(cid, receiver, message)
  local src = source
  local mynumber = getNumberPhone(cid)
  local target = getIdentifierByPhoneNumber(receiver)
  local Players = GetPlayers()
  exports.oxmysql:execute('INSERT INTO user_messages (sender, receiver, message) VALUES (@sender, @receiver, @message)', {
      ['sender'] = mynumber,
      ['receiver'] = receiver,
      ['message'] = message
  }, function(result)
  end)
  
  for _, player in ipairs(GetPlayers()) do
      local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(player))
      local characterId = user:getVar("character").id
      if characterId ~= nil then
          if characterId == target then
              TriggerClientEvent('phone:newSMS', tonumber(player), mynumber,message, os.time(),receiver)
              TriggerClientEvent('notification', src, "Message Sent!", 16)
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


function ReverseTable(t)
    local reversedTable = {}
    local itemCount = #t
    for k, v in ipairs(t) do
        reversedTable[itemCount + 1 - k] = v
    end
    return reversedTable
end