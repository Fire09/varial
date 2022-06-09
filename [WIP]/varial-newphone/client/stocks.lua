local pickupLocation = vector3(508.91, 3099.83, 41.31)
local orderItem = false

-- RegisterNetEvent("Crypto:GivePixerium")
-- AddEventHandler("Crypto:GivePixerium", function(amount)
--   clientstockamount[1]["value"] = clientstockamount[1]["value"] + amount
--   Citizen.Trace("Retreived crypto")
--   updateServerClientStocks()
--   TriggerEvent("customNotification", "You have received Pixerium")
-- end)
-- RegisterNetEvent("Crypto:RemovePixerium")
-- AddEventHandler("Crypto:RemovePixerium", function(amount)
--   clientstockamount[1]["value"] = clientstockamount[1]["value"] - amount
--   updateServerClientStocks()
--   Citizen.Trace("Lost crypto")
-- end)

RegisterNetEvent('stocks:payupdate');
AddEventHandler('stocks:payupdate', function()
  local payamount = 0
  for i = 2, #clientstockamount do
    local mystock = clientstockamount[i]["value"]
    if mystock > 0 then
      local currentlyPaying = serverstockvalues[i]["value"] / 200
      local totalpay = (currentlyPaying * mystock) / 100
      local mypayout = math.ceil(totalpay * 100)
      local haslost = 0.0
      payamount = payamount + mypayout
      if serverstockvalues[i]["value"] < 1000.0 then
        if mystock > 3 then
          if math.random(100) > 90 then
            local stockloss =  math.ceil(((mystock / 100) / 3) * 100) / 100
            clientstockamount[i]["value"] = mystock - stockloss
            TriggerServerEvent("stocks:bleedstocks",i,stockloss)
            haslost = haslost - stockloss
          end
        end
        if mystock > 20 then
          if math.random(100) > 90 then
            local stockloss =  math.ceil(((mystock / 100) / 3) * 100) / 100
            clientstockamount[i]["value"] = mystock - stockloss
            TriggerServerEvent("stocks:bleedstocks",i,stockloss)
            haslost = haslost - stockloss
          end
        end
      end
      if haslost < 0 then
        TriggerEvent("chatMessagess", "EMAIL ", 8, "Interest pay out of $" .. mypayout .. " for stock ID " .. serverstockvalues[i]["identifier"] .. ". The company also cut your shares by " .. haslost .. " to increase profits. ")
      else
        TriggerEvent("chatMessagess", "EMAIL ", 8, "Interest pay out of $" .. mypayout .. " for stock ID " .. serverstockvalues[i]["identifier"])
      end
    end
  end
  payamount = math.floor(payamount)
  if payamount > 0 then
    TriggerServerEvent("server:givepayJob", "Stock Payment", payamount)
  end
end)

RegisterNetEvent('stocks:servervalueupdate');
AddEventHandler('stocks:servervalueupdate', function(sentvalues)
    serverstockvalues = sentvalues
end)

RegisterNetEvent('stocks:clientvalueupdate');
AddEventHandler('stocks:clientvalueupdate', function(sentvalues)
    clientstockamount = sentvalues

end)

RegisterNetEvent('stocks:jailed');
AddEventHandler('stocks:jailed', function()
    for i=2,#clientstockamount do
      if clientstockamount[i]["value"] > 1.0 then
        local loss = math.floor((clientstockamount[i]["value"] / 20) * 100) / 100
        TriggerServerEvent("stocks:reducestock",i,loss)
      end
    end
end)

RegisterNetEvent('stocks:newstocks');
AddEventHandler('stocks:newstocks', function(amountBuying,identifier)
  clientstockamount[identifier]["value"] = clientstockamount[identifier]["value"] + amountBuying
  updateServerClientStocks()
end)

RegisterNetEvent('stocks:losestocks');
AddEventHandler('stocks:losestocks', function(amountBuying,identifier)
  clientstockamount[identifier] = clientstockamount[identifier] - amountBuying
  updateServerClientStocks()
end)

function updateServerClientStocks()
  TriggerServerEvent("stocks:clientvalueupdate",serverstockvalues)
end




-- RegisterNetEvent('pixerium:check');
-- AddEventHandler('pixerium:check', function(costs,functionCall,server)

--   if clientstockamount[1]["value"] >= costs then
--     clientstockamount[1]["value"] = clientstockamount[1]["value"] - costs
--     updateServerClientStocks()
--     if server then
--       TriggerServerEvent(functionCall)
--     else
--       TriggerEvent(functionCall)
--     end    
--   else
--     TriggerEvent("chatMessagess", "EMAIL ", 8, "You need " .. costs .."  pixerium!")
--   end

-- end)

RegisterNUICallback('buying-darkMarket', function()
  SendNUIMessage({
    openSection = "buydarkMarket", materials = exports['varial-newphone']:getBuying(), blueprintid = RPC.execute("varial-newphone:blueprintid")
  })
end)

RegisterNUICallback('stocksTradeToPlayer', function(data, cb)
  local index = 0
  local amount = 0
  local sending = math.ceil(tonumber(data.amount) * 100) / 100
  -- print(data.identifier)
  for i=1,#serverstockvalues do
    if data.identifier == serverstockvalues[i]["identifier"] then
      index = i
      amount = serverstockvalues[i]["value"]
    end
  end
   
  if index == 0 then
    TriggerEvent("DoShortHudText","Incorrect Identifier.",2)
    TriggerEvent("stocks:refreshstocks")
    return
  end
  if amount < tonumber(data.amount) then
    -- not enough to do the trade
    TriggerEvent("DoShortHudText","Not enough stock.",2)
    TriggerEvent("stocks:refreshstocks")
    return
  end

  if data.identifier == "Syndite" then
      status = RPC.execute("varial-newphone:buyCrypto",1,data.amount)
    if status then
      serverstockvalues[1]["amountavailable"] = serverstockvalues[1]["amountavailable"] - data.amount
      -- print("what",serverstockvalues[1]["amountavailable"])
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  elseif data.identifier == "TGB Coin" then
    status = RPC.execute("varial-newphone:buyCrypto",2,data.amount)
    if status then
      serverstockvalues[2]["amountavailable"] = serverstockvalues[2]["amountavailable"] - data.amount
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  elseif data.identifier == "DVD Prime" then
    status = RPC.execute("varial-newphone:buyCrypto",3,data.amount)
    if status then
      serverstockvalues[3]["amountavailable"] = serverstockvalues[3]["amountavailable"] - data.amount
      sendStocksToPhone(true)
    else
      TriggerEvent("DoLongHudText", "You don't have enough cash!", 2)
      return
    end
  end
  
  -- clientstockamount[index]["value"] = clientstockamount[index]["value"] - sending
  -- Citizen.Trace("removing " .. sending .. " shares from index " .. index )
  -- TriggerServerEvent('phone:stockTradeAttempt', index, data.playerid, sending )
  Citizen.Wait(500)
  TriggerEvent("stocks:refreshstocks")

end)

RegisterNUICallback('exchangeCrypto', function(e)
  local amount = e.amount
  local playerid = tonumber(e.playerid)
  local characterId = tonumber(exports["isPed"]:isPed("cid"))

  if e.identifier == "Syndite" then
    popo = 1
  elseif e.identifier == "TGB Coin" then
    popo = 2
  elseif e.identifier == "DVD Prime" then
    popo = 3
  end

  if playerid == characterId then
    RPC.execute("varial-newphone:exchangeCrypto",popo,amount)
  else
    RPC.execute("varial-newphone:transferCrypto",popo,amount,playerid)
  end

  sendStocksToPhone()
end)

RegisterNetEvent('stocks:refreshstocks');
AddEventHandler('stocks:refreshstocks', function()
    --[[for i = 1, #serverstockvalues do
      local colortype = 1
      if i == 1 or i == 3 or i == 5 then
        colortype = 2
      end
      local lastchangestock = "<div class='change stockred'>▼" .. serverstockvalues[i]["lastchange"] .. "</div>"
      if serverstockvalues[i]["lastchange"] > -0.01 then
        lastchangestock = "<div class='change stockgreen'>▲" .. serverstockvalues[i]["lastchange"] .. "</div>"
      end 

      SendNUIMessage({
        openSection = "addstock",
        namesent = serverstockvalues[i]["name"],
        identifier = serverstockvalues[i]["identifier"],
        lastchange = lastchangestock,
        valuesent = serverstockvalues[i]["value"],
        amountsold = serverstockvalues[i]["amountsold"],
        clientstock = clientstockamount[i]["value"],
        colorsent = colortype,
        available = serverstockvalues[i]["amountavailable"]
      })
    end--]]
    sendStocksToPhone(true);
end)

function sendStocksToPhone(isRefresh)

  if isRefresh then
    updateServerClientStocks(serverstockvalues)
    serverstockvalues = RPC.execute("varial-newphone:incomingCrypto")
  else
    serverstockvalues = RPC.execute("varial-newphone:incomingCrypto")
  end

  Synditelol = RPC.execute("varial-newphone:GetSyndite")
  Tgblol = RPC.execute("varial-newphone:GetTgb")
  Dvdlol = RPC.execute("varial-newphone:GetDvd")
  SendNUIMessage({ openSection = "addStocks", stocksData = serverstockvalues, SynditeAmount = Synditelol, TgbAmount = Tgblol, DvdAmount = Dvdlol})
end

RegisterNUICallback('btnStocks', function()
  TriggerServerEvent('stocks:retrieve')
  sendStocksToPhone();
  --[[
    for i = 1, #serverstockvalues do
      local colortype = 1
      if i == 1 or i == 3 or i == 5 then
        colortype = 2
      end
      local lastchangestock = "<div class='change stockred'>▼" .. serverstockvalues[i]["lastchange"] .. "</div>"
      if serverstockvalues[i]["lastchange"] > -0.01 then
        lastchangestock = "<div class='change stockgreen'>▲" .. serverstockvalues[i]["lastchange"] .. "</div>"
      end 

      SendNUIMessage({
        openSection = "addstock",
        namesent = serverstockvalues[i]["name"],
        identifier = serverstockvalues[i]["identifier"],
        lastchange = lastchangestock,
        valuesent = serverstockvalues[i]["value"],
        amountsold = serverstockvalues[i]["amountsold"],
        clientstock = clientstockamount[i]["value"],
        colorsent = colortype,
        available = serverstockvalues[i]["amountavailable"]
      })
    end--]]
end)

RegisterNUICallback('purchase-darkMarket', function(data)
    local characterId = exports["isPed"]:isPed("cid")
    local colorLaptop = exports['varial-newphone']:getBuying()
    local time = math.random(60000,120000)

    if orderItem == false then
      if data.item == "vpn" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',1,20)
          if result then
            itemDM = "vpnxj"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your VPN, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Syndite!")
          end
      elseif data.item == "deliverylist" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',1,20)
          if result then
            itemDM = "darkmarketdeliveries"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your delivery schedule, please wait a few minutes!")
            orderItem = true
            Wait(time)
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Syndite!")
          end
        elseif data.item == "choplist" then
          result = RPC.execute('varial-newphone:purchaseDarkMarket',2,20)
            if result then
              itemDM = "choplist"
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for the choplist, please wait a few minutes!")
              Wait(time)
              orderItem = true
              TriggerEvent("addPickUpBlip")
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
            else
              TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough TGB Coin!")
            end
          -- TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for a chop list is unavailable!")
      elseif data.item == "gdongle" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',2,100)
          if result then
            itemDM = "heistusb4"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your dongle, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough TGB Coin!")
          end
      elseif data.item == "boostlaptop" then
        -- result = RPC.execute('varial-newphone:purchaseDarkMarket',1,100)
        -- if result then
        --   itemDM = "boostinglaptop"
        --   TriggerEvent("addPickUpBlip")
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for an RP laptop has been recieved, please wait a few minutes!")
        --   orderItem = true
        --   Wait(time)
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        -- else
        --   TriggerEvent("chatMessage", "Suspicious Individual", 8, 'You dont have enough TGB!')
        -- end
        TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order for an RP laptop is unavailable!")
      elseif data.item == "laptopred" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',1,65)
        if result then
          itemDM = "heistlaptop4"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Syndite!")
        end
      elseif data.item == "laptopgreen" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',1,50)
          if result then
            itemDM = "heistlaptop3"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Syndite!")
          end
      elseif data.item == "laptopgold" then
      elseif data.item == "laptopblue" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',1,50)
          if result then
            itemDM = "heistlaptop2"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your laptop, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Syndite!")
          end
      elseif data.item == "thermite" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',2,50)
          if result then
            itemDM = "thermite"
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your thermite, please wait a few minutes!")
            Wait(time)
            orderItem = true
            TriggerEvent("addPickUpBlip")
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
          else
            TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough TGB Coins!")
          end
      elseif data.item == "Skorpion" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "skorpionblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Uzi" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "uziblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Mac-10" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "mac10blueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "FN FNX-45" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "fnxblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          TriggerEvent("addPickUpBlip")
          orderItem = true
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Glock 18C" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "glockblueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      elseif data.item == "Desert Eagle" then
        result = RPC.execute('varial-newphone:purchaseDarkMarket',3,data.itemamount)
        if result then
          itemDM = "pistol50blueprint"
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "We've received an order for your blueprint, please wait a few minutes!")
          Wait(time)
          orderItem = true
          TriggerEvent("addPickUpBlip")
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "Your order has been finalized, please check your GPS!")
        else
          TriggerEvent("chatMessage", "Suspicious Individual", 8, "You don't have enough Davadam Prime!")
        end
      end
  else
    TriggerEvent("chatMessage", "Suspicious Individual", 8, "Transaction failed! You already have a pending order.")
  end
end)

RegisterNetEvent("addPickUpBlip")
AddEventHandler("addPickUpBlip", function()
  blip = AddBlipForCoord(pickupLocation)
  SetBlipSprite(blip, 440)
  SetBlipScale(blip, 1.2)
  SetBlipColour(blip, 5)
  SetBlipAsShortRange(blip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Item Pickup")
  EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('varial-newphone:takeDMarket')
AddEventHandler('varial-newphone:takeDMarket', function()
  if orderItem then
    TriggerEvent( "player:receiveItem", itemDM, 1)
    itemDM = nil
    orderItem = false
    RemoveBlip(blip)
    blip = nil
  else
    TriggerEvent('DoLongHudText',"You don't have an order!",2)
  end
end)

function orderingItem()
  return orderItem
end
exports("orderingItem",orderingItem)

function requestUpdate()
  TriggerServerEvent("stocks:retrieve")
end