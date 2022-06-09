
RPC.register('varial-newphone:business_hired', function(source,bus,p,r)
    local src = source
    local bId = bus.param
    local cid = p.param
    local rank = r.param
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local ply = user:getCurrentCharacter()
   -- local SrcName = ply.first_name .. " " ..ply.last_name
    local status = true
    local fullName = getFullname(cid)
    local bName = getBusinessName(bId)

    local result = MySQL.query.await([[
        SELECT * FROM character_passes
        WHERE cid = ? AND pass_type = ?
    ]],
    { cid, bId })

    if not result[1] then 
        if cidExist(cid) then
            local insertEmployee = MySQL.insert.await([[
                INSERT INTO character_passes (pass_type, cid, rank, name, giver, business_name)
                VALUES (?, ?, ?, ?, ?, ?)
            ]],
            { bId, cid, rank, fullName, SrcName, bName})
            if insertEmployee > 0 then
                status = true
            else
                print("Database Error")
            end
            return status
        else
            TriggerClientEvent('DoLongHudText', src,"CID is not valid.", 2)
        end
    end
    status = false
    
    return status
end)

RPC.register('varial-newphone:business_edit', function(source,bus,p,r)
    local src = source
    local bId = bus.param
    local cid = p.param
    local rank = r.param
    local affectedRows = MySQL.update.await([[
        UPDATE character_passes
        SET rank = ?
        WHERE cid = ? AND pass_type = ?
    ]],
    { rank, cid, bId })
end)

RPC.register('varial-newphone:business_paycheck', function(source,bus,p,a)
    local src = source
    local bId = bus.param
    local cid = p.param
    local amount = a.param

   local isPaycheck = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],
    { cid })
    local isBusinessBank = MySQL.query.await([[
        SELECT * FROM group_banking
        WHERE group_type = ?
    ]],
    { bId })
    
    local payCheck = (isPaycheck[1].paycheck+amount)
    local updateBank = (isBusinessBank[1].bank-amount)
    local affectedRows = MySQL.update.await([[
        UPDATE characters
        SET paycheck = ?
        WHERE id = ?
    ]],
    { tonumber(payCheck), cid })
    local updateBusBank = MySQL.update.await([[
        UPDATE group_banking
        SET bank = ?
        WHERE group_type = ?
    ]],
    { tonumber(updateBank), bId })
    if affectedRows and affectedRows ~= 0 and updateBusBank and updateBusBank ~= 0 then
        return true,amount
    end
end)

RPC.register('varial-newphone:bus_addBank', function(source,id,a)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local ply = user:getCurrentCharacter()
    local bId = id.param
    local amount = a.param
    local bank = MySQL.query.await([[
        SELECT * FROM group_banking
        WHERE group_type = ?
    ]],{bId})
    if tonumber(user:getCash()) >= tonumber(amount) then
        local affectedRows = MySQL.update.await([[
            UPDATE group_banking
            SET bank = ?
            WHERE group_type = ?
        ]],{bank[1].bank+amount, bId})
        user:removeMoney(tonumber(amount))
        return true
    end
end)

RPC.register('varial-newphone:business_fire', function(source,bus,p)
    local src = source
    local bId = bus.param
    local cid = p.param
    local affectedRows = MySQL.update.await([[
        DELETE FROM character_passes
        WHERE cid = ? AND pass_type = ?
    ]],
    { cid, bId })

    if affectedRows and affectedRows ~= 0 then
        return true
    end
end)

function getFullname(cid)
    local name = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],
    {cid})
    return name[1].first_name.." "..name[1].last_name
end

function cidExist(cid)
    local result = MySQL.query.await([[
        SELECT * FROM characters
        WHERE id = ?
    ]],
    { cid })
    if not result[1] then 
        return false
    end
    return true
end

function getBusinessName(bId)
    local businessName = ""
    if bId == "hayes_autos" then
        businessName = "Hayes Auto"
    elseif bId == "burger_shot" then
        businessName = "Burger Shot"
    elseif bId == "casino" then
        businessName = "Casino Diamond"
    elseif bId == "vanilla_unicorn" then
        businessName = "Vanilla Unicorn"
    elseif bId == "car_shop" then
        businessName = "PDM"
    elseif bId == "pizzaria" then
        businessName = "Maldini's Pizza"
    elseif bId == "ems" then
        businessName = "Pillbox Hospital"
    elseif bId == "police" then
        businessName = "Police"
    elseif bId == "gallery" then
        businessName = "Gallery"
    elseif bId == "ug_racing" then
        businessName = "Underground"
    elseif bId == "lostmc" then
        businessName = "Lost MC"
    elseif bId == "sacredflowers" then
        businessName = "Sacred Flowers"
    elseif bId == "bcso" then
        businessName = "BCSO"
    elseif bId == "DOJ" then
        businessName = "DOJ"
    elseif bId == "taco_shop" then
        businessName = "Taco Shop"
    elseif bId == "serpents" then
        businessName = "Serpents"
    end
    return businessName
end


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