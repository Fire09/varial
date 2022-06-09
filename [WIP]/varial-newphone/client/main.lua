local guiEnabled = false
local hasOpened = false
local lstMsgs = {}
local lstContacts = {}
local inPhone = false
local radioChannel = math.random(1,999)
local usedFingers = false
local dead = false
local onhold = false
local YellowPageArray = {}
local YellowPages = {}
local PhoneBooth = GetEntityCoords(PlayerPedId())
local phoneNotifications = true
local insideDelivers = false
local curhrs = 9
local curmins = 2
local allowpopups = true
local vehicles = {}
local isDead = false
local wallPaper = ""
local pPhoneOpen = false
local unReadMsg = 0
local unReadTwt = 0
local unReadEmail = 0
local serverSpawn = false
local sanitation = true
local rentEnabled = false
local canSpawnVehs = false
local canSpawnDist = 0
local vehSpawnPlate = 0
local spawningVeh = 0
function pOpen()
  return pPhoneOpen
end

function phasPhone()
  return hasPhone()
end

function pNotify()
  return phoneNotifications
end

CreateThread(function ()
  while true do
    Wait(0)
      if guiEnabled == true then 
        DisableAllControlActions(0)
        DisableAllControlActions(2)
             
        EnableControlAction(0, 32, true)
        EnableControlAction(0, 34, true)
        EnableControlAction(0, 31, true)
        EnableControlAction(0, 30, true)
        EnableControlAction(0, 22, true)
        EnableControlAction(0, 21, true)

        -- car
        EnableControlAction(0, 71, true)
        EnableControlAction(0, 72, true)
        EnableControlAction(0, 59, true)

        -- push to talk
        EnableControlAction(0, 249, true)
      end
    end
end)


RegisterNetEvent('varial-housing:rent_activate_cl')
AddEventHandler('varial-housing:rent_activate_cl', function()
    local rank = exports['isPed']:GroupRank("real_estate")
    if not rentEnabled then
        if rank > 0 then
            TriggerEvent('DoLongHudText', "Rent is Enabled.")
        end
        rentEnabled = true
        enabledRentSelling()
    else
        if rank > 0 then
            TriggerEvent('DoLongHudText', "Rent is Disabled.",2)
        end
        rentEnabled = false
    end
end)

AddEventHandler('varial-newphone:sanitationIn', function()
  -- print("SANITATION SIGN IN")
  sanitation = true
end)

RegisterNetEvent("varial-newphone:grabBackground")
AddEventHandler("varial-newphone:grabBackground", function(link)
    wallPaper = link
end)

RegisterNetEvent("varial-jobmanager:playerBecameJob")
AddEventHandler("varial-jobmanager:playerBecameJob", function(job)
    if job == "trucker" then
        trucker = true
    end
end)

AddEventHandler('addUnreadMsg', function()
  unReadMsg = unReadMsg + 1
end)

AddEventHandler('msgReads', function()
  unReadMsg = 0
end)

AddEventHandler('addUnreadTwt', function()
  unReadTwt = unReadTwt + 1
end)

AddEventHandler('twtReads', function()
  unReadTwt = 0
end)

AddEventHandler('addUnreadEmail', function()
  unReadEmail = unReadEmail + 1
end)

AddEventHandler('emailReads', function()
  unReadEmail = 0
end)

RegisterNUICallback('emailReads', function(data)
  unReadEmail = 0
end)

function SetCustomNuiFocus(hasKeyboard, hasMouse)
  HasNuiFocus = hasKeyboard or hasMouse

  SetNuiFocus(hasKeyboard, hasMouse)
  SetNuiFocusKeepInput(HasNuiFocus)

  TriggerEvent("np:voice:focus:set", HasNuiFocus, hasKeyboard, hasMouse)
end

RegisterNUICallback('btnNotifyToggle', function(data, cb)
    allowpopups = not allowpopups
    if allowpopups then
      TriggerEvent("DoLongHudText","Popups Enabled", 1)
    else
      TriggerEvent("DoLongHudText","Popups Disabled", 2)
    end
end)

RegisterNUICallback('wallpaper', function(data, cb)
  wallPaper = ""
  Wait(5)
  local wallPaperSelecionado = data.wallpaper
  TriggerEvent('varial-newphone:grabBackground', wallPaperSelecionado)
  TriggerServerEvent("phone:saveWallpaper", exports['isPed']:isPed('cid'), wallPaperSelecionado)
end)

activeNumbersClient = {}

RegisterNetEvent('phone:reset')
AddEventHandler('phone:reset', function(cidsent)
    closeGui()
    guiEnabled = false
    hasOpened = false
    lstMsgs = {}
    lstContacts = {}
    vehicles = {}
    radioChannel = math.random(1,999)
    dead = false
    onhold = false
    inPhone = false
    wallPaper = ""
    Wait(1)
    TriggerServerEvent('varial-newphone:grabWallpaper')
end)

RegisterNetEvent('Yougotpaid')
AddEventHandler('Yougotpaid', function(cidsent)
    if tonumber(cid) == tonumber(cidsent) then
      TriggerEvent("DoLongHudText","Life Invader Payslip Generated.", 1)
    end
end)

RegisterNetEvent("phone:listunpaid")
AddEventHandler("phone:listunpaid", function(outstandingArray)

  SendNUIMessage({
    openSection = "showOutstandingPayments",
    outstandingPayments = outstandingArray
  })
end)
           
RegisterNetEvent('Payment:Successful')
AddEventHandler('Payment:Successful', function()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Payment Processed.",
    })     
end)

RegisterNetEvent('warrants:AddInfo')
AddEventHandler('warrants:AddInfo', function(name, charges)

    openGuiNow()

    SendNUIMessage({
      openSection = "enableoutstanding",
    })
    for i = 1, #charges do

      SendNUIMessage({
        openSection = "inputoutstanding",
        textmessage = charges[i],
      })
    end
    
end)

RegisterNetEvent("phone:activeNumbers")
AddEventHandler("phone:activeNumbers", function(activePhoneNumbers)
  activeNumbersClient = activePhoneNumbers
  hasOpened = false
end)



RegisterNetEvent("gangTasks:updateClients")
AddEventHandler("gangTasks:updateClients", function(newTasks)
  activeTasks = newTasks
end)

TaskState = {
  [1] = "Ready For Pickup",
  [2] = "In Process",
  [3] = "Successful",
  [4] = "Failed",
  [5] = "Delivered with Damaged Goods",
}

TaskTitle = {
  [1] = "Ordering 'Take-Out'",
  [2] = "Ordering 'Disposal Service'",
  [3] = "Ordering 'Postal Delivery'",
  [4] = "Ordering 'Hot Food Room Service'",
}

function findTaskIdFromBlockChain(blockchain)
  local retnum = 1
  for i = 1, #activeTasks do
    if activeTasks[i]["BlockChain"] == blockchain then
      retnum = i
    end
  end
  return retnum
end

-- real estate nui app responses

function loading()
    SendNUIMessage({
        openSection = "error",
        textmessage = "Loading, please wait.",
    })  
end

RegisterNetEvent("phone:setServerTime")
AddEventHandler("phone:setServerTime", function(time)
  SendNUIMessage({
    openSection = "server-time",
    serverTime = time
  })
end)

RegisterNetEvent("timeheader")
AddEventHandler("timeheader", function(hrs,mins)


  if hrs < 10 then
    hrs = "0"..hrs
  end
  if mins < 10 then
    mins = "0"..mins
  end
  curhrs = hrs
  curmins = mins

  local timesent = curhrs .. ":" .. curmins
  if guiEnabled then
    SendNUIMessage({
      openSection = "timeheader",
      timestamp = timesent,
    })   
  end
end)


function doTimeUpdate()
  hour = GetClockHours()
  minute = GetClockMinutes()

  if minute <= 9 then
		minute = "0" .. minute
  end

  local timesent = hour .. ":" .. minute
  if guiEnabled then
    SendNUIMessage({
      openSection = "timeheader",
      timestamp = timesent,
    })   
  end
end

RegisterNUICallback('btnGiveKey', function(data, cb)
  TriggerEvent("houses:GiveKey")
end)
RegisterNetEvent("returnPlayerKeys")
AddEventHandler("returnPlayerKeys", function(ownedkeys,sharedkeys)
  
      if not guiEnabled then
        return
      end
      SendNUIMessage({
        openSection = "keys",
        keys = {
          sharedKeys = sharedkeys,
          ownedKeys = ownedkeys
        }
      })
end)

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

local selfieMode = false
local isCamera, frontCam = false, false
RegisterNUICallback('phone:selfie', function()
  selfieMode = not selfieMode
  closeGui()
  ToggleCamera()
end)

RegisterNUICallback('submitBg', function(data, cb)
  -- TriggerServerEvent('phone:saveWallpaper', exports['isPed']:isPed('cid'),data.bg)
  -- SendNUIMessage({openSection = "screenSaver"})

  wallPaper = ""
  Wait(5)
  local wallPaperSelecionado = data.bg
  TriggerEvent('varial-newphone:grabBackground', wallPaperSelecionado)
  -- TriggerServerEvent("phone:saveWallpaper", exports['isPed']:isPed('cid'), wallPaperSelecionado)
  SetResourceKvp(exports['isPed']:isPed('cid').."-bg", wallPaperSelecionado)
  TriggerEvent('changeBG', wallPaperSelecionado)
end)

AddEventHandler('changeBG', function(bg)
  SendNUIMessage({
    openSection = "phoneBg",
    phoneBg = bg
  })
end)
local takePhoto = false
local time = 0

function CellFrontCamActivate(activate) return Citizen.InvokeNative(0x2491A93618B7D838, activate) end

function ToggleCamera()

  CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takePhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) and takePhoto then -- TAKE.. PIC
        if time == 0 then
          time = 10
            exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/864136156345532458/WMOSkd3n1T7evyimq86sVbUjmhWXZkdV4KDK7BQ0gdK_fV18UbXnpO7mEcij8_MPey6y', 'files[]', function(data)
              local resp = json.decode(data)

              TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.5, "photo-capture1", 0.03)
              
              DestroyMobilePhone()
              CellCamActivate(false, false)
              SetTimeout(2000, function()
                TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.5, "phone-notify", 0.10)

                SetNuiFocus(true,true)
                SendNUIMessage({
                  selfiebox = true,
                  openSection = "selfiebox",
                  imgLink = resp.attachments[1].proxy_url,
                  img = resp.attachments[1].proxy_url
                })
              end)
              
            takePhoto = false
            
          end)
        else
        end
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
end

Citizen.CreateThread(function()
  while true do
    Wait(1000)
      if time > 0 then
        time = time - 1
        if time == 0 then
          time = 0
        end
      end
    end
end)

RegisterNUICallback('closeSelfieBox', function()
  SendNUIMessage({
    openSection = "selfieboxClose",
  })
  SetNuiFocus(false, false)
end)

RegisterNUICallback('closeSelfi', function()
  SetNuiFocus(false, false)
end)

RegisterNUICallback('trackTaskLocation', function(data, cb)
    local taskID = findTaskIdFromBlockChain(data.TaskIdentifier)
    TriggerEvent("DoLongHudText","Location Set", 1)

    SetNewWaypoint(activeTasks[taskID]["Location"]["x"],activeTasks[taskID]["Location"]["y"])
end)


RegisterCommand('email', function()
  -- TriggerEvent("chatMessage", "Suspicious Individual", 8, "Look at your gps and find the house you'll be breaking in")
  TriggerEvent('phone:addnotification',"Suspicious Individual","Look at your gps and find the house you'll be breaking in")
end)

RegisterNetEvent("phone:error")
AddEventHandler("phone:error", function()
      SendNUIMessage({
        openSection = "error",
        textmessage = "<b>Network Error</b> <br><br> Please contact support if this error persists, thank you for using Syko's Phone Services.",
      })   
end)

-- RegisterNUICallback('manageGroup', function(data)
--   local groupid = data.GroupID
  
--   local rank = GroupRank(groupid)
--   if rank < 2 then
--     SendNUIMessage({
--       openSection = "error",
--       textmessage = "Permission Error",
--     })   
--     return
--   end

--   SendNUIMessage({
--       openSection = "error",
--       textmessage = "Loading, please wait.",
--   })   

--   TriggerServerEvent("group:pullinformation",groupid,rank)

-- end)

RegisterNUICallback('btnProperty', function(data, cb)
  loading()
  local realEstateRank = GroupRank("real_estate")
  if realEstateRank > 0 then
    SendNUIMessage({
        openSection = "RealEstate",
        RERank = realEstateRank
    })        
  end
end)



RegisterNUICallback('wenmo', function(data, cb)
  SendNUIMessage({
    openSection = "bankManage",
    groupData = {
      groupName = 'poop',
      bank = 'poop',
      groupId = 'poop',
      employees = 'poop',
    }
  })  
  loading()

      
  
end)


RegisterNUICallback('btnProperty2', function(data, cb)
  loading()
  TriggerServerEvent("ReturnHouseKeys", exports['isPed']:isPed('cid'))
end)

RegisterNUICallback('btnPayMortgage', function(data, cb)
  loading()
  TriggerEvent("housing:attemptpay")
end)

RegisterNUICallback('retrieveHouseKeys', function(data, cb)
  TriggerEvent("houses:retrieveHouseKeys")
  cb('ok')
end)

RegisterNUICallback('btnFurniture', function(data, cb)
  closeGui()
  --TriggerEvent("DoLongHudText", "Coming soon.", 2)
  TriggerEvent("openFurniture")
end)

RegisterNUICallback('btnPropertyModify', function(data, cb)
TriggerEvent("housing:info:realtor","modify")
end)

RegisterNUICallback('removeHouseKey', function(data, cb)
  TriggerEvent("houses:removeHouseKey", data.targetId)
  cb('ok')
end)


RegisterNUICallback('removeSharedKey', function(data, cb)
  local cid = exports["isPed"]:isPed("cid")
  TriggerServerEvent("houses:removeSharedKey", data.house_id, cid)
  cb('ok')
end)

RegisterNUICallback('btnPropertyReset', function(data, cb)
TriggerEvent("housing:info:realtor","reset")
end)

RegisterNUICallback('btnPropertyClothing', function(data, cb)
TriggerEvent("housing:info:realtor","setclothing")
end)

RegisterNUICallback('btnPropertyStorage', function(data, cb)
TriggerEvent("housing:info:realtor","setstorage")
end)

RegisterNUICallback('btnPropertySetGarage', function(data, cb)
TriggerEvent("housing:info:realtor","setgarage")
end)

RegisterNUICallback('btnPropertyWipeGarages', function(data, cb)
TriggerEvent("housing:info:realtor","wipegarages")
end)

RegisterNUICallback('btnPropertySetBackdoorInside', function(data, cb)
TriggerEvent("housing:info:realtor","backdoorinside")
end)

RegisterNUICallback('btnPropertySetBackdoorOutside', function(data, cb)
TriggerEvent("housing:info:realtor","backdooroutside")
end)

RegisterNUICallback('btnPropertyUpdateHouse', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnRemoveSharedKey', function(data, cb)
TriggerEvent("housing:info:realtor","update")
end)

RegisterNUICallback('btnPropertyOutstanding', function(data, cb)
  TriggerEvent("housing:info:realtor","PropertyOutstanding")
  end)

RegisterNUICallback('btnPropertyUnlock', function(data, cb)
  TriggerEvent("housing:info:realtor","unlock")
end)

RegisterNUICallback('btnPropertyUnlock2', function(data, cb)
  TriggerEvent("housing:info:realtor","unlock2")
end)

RegisterNUICallback('btnPropertyHouseCreationPoint', function(data, cb)
TriggerEvent("housing:info:realtor","creationpoint")
end)
RegisterNUICallback('btnPropertyStopHouse', function(data, cb)
TriggerEvent("housing:info:realtor","stop")
end)
RegisterNUICallback('btnAttemptHouseSale', function(data, cb)
TriggerEvent("housing:findsalecid",data.cid,data.price)
end)
RegisterNUICallback('btnTransferHouse', function(data, cb)
TriggerEvent("housing:transferHouseAttempt", data.cid)
end)
RegisterNUICallback('btnEvictHouse', function(data, cb)
TriggerEvent("housing:evictHouseAttempt")
end)
RegisterNUICallback('btnGiveKey', function(data, cb)
  TriggerEvent("houses:GiveKey")
end)
RegisterNUICallback('btnFurniture', function(data, cb)
  closeGui()
  TriggerEvent("openFurniture")
end)


-- real estate nui app responses end




-- local recentcalls = {}

-- RegisterNUICallback('getCallHistory', function()
--   SendNUIMessage({
--     openSection = "callHistory",
--     callHistory = recentcalls
--   })
-- end)

RegisterNUICallback('btnHousing', function()
  -- print("HOUSE BUTTON")
  newHouses = {}
  allNewHouses = {}
  myAccessHouse = {}
  local apt = RPC.execute("varial-newphone:apt")
  --local housing = exports['varial-housing']:housingForPhone()
  local apartment = exports['varial-apartments']:getMyCurrentApartment()
  myHousess = RPC.execute("varial-newphone:getCurrentOwned")
  accessHouse = RPC.execute('varial-newphone:getAccessHouse_2')
  TriggerServerEvent('checkKeys')
  local cid = exports["isPed"]:isPed("cid")
  for i,v in pairs(myHousess) do
    -- print("STATUS", v.status)
    table.insert(newHouses, {
      hid = v.hid,
      cid = v.cid,
      status = v.status,
    --  cat = exports['varial-housing']:getHousingCatFromPropertID(v.hid),
      
    })
  end
  for l,s in pairs(accessHouse) do
    -- print("STATUS", v.status)
    if tonumber(cid) ==  tonumber(s.cid) then
      table.insert(myAccessHouse, {
        house = s.house,
        cid = s.cid,
        status = s.status,
        -- name = s.name,
       -- cat = exports['varial-housing']:getHousingCatFromPropertID(s.house),
        
      })
    end
  end
  SendNUIMessage({
    openSection = "housing",
    apId = apt.id,
    sName = apartment.streetName,
    myHouse = newHouses,
    houses = housing,
    accessHouse = myAccessHouse,
  })
end)

RegisterNetEvent('updateHousing')
AddEventHandler('updateHousing', function()
  -- print("HOUSE BUTTON")
  newHouses = {}
  allNewHouses = {}
  myAccessHouse = {}
  local apt = RPC.execute("varial-newphone:apt")
 -- local housing = exports['varial-housing']:housingForPhone()
  local apartment = exports['varial-apartments']:getMyCurrentApartment()
  myHousess = RPC.execute("varial-newphone:getCurrentOwned")
  accessHouse = RPC.execute('varial-newphone:getAccessHouse_2')
  TriggerServerEvent('checkKeys')
  local cid = exports["isPed"]:isPed("cid")
  for i,v in pairs(myHousess) do
    -- print("STATUS", v.status)
    table.insert(newHouses, {
      hid = v.hid,
      cid = v.cid,
      status = v.status,
     -- cat = exports['varial-housing']:getHousingCatFromPropertID(v.hid),
      
    })
  end
  for l,s in pairs(accessHouse) do
    -- print("STATUS", v.status)
    if tonumber(cid) ==  tonumber(s.cid) then
      table.insert(myAccessHouse, {
        house = s.house,
        cid = s.cid,
        status = s.status,
        -- name = s.name,
       -- cat = exports['varial-housing']:getHousingCatFromPropertID(s.house),
        
      })
    end
  end
  SendNUIMessage({
    openSection = "housing",
    apId = apt.id,
    sName = apartment.streetName,
    myHouse = newHouses,
    houses = housing,
    accessHouse = myAccessHouse,
  })
end)

-- Citizen.CreateThread(function()
--   while true do
--     Wait(3000)
--     local myHouse = RPC.execute("varial-newphone:getCurrentOwned")
--     print("MY HOUSE", myHouse.hid,json.encode(myHouse))
--   end
-- end)

local pcs = {
  [1] = 1333557690,
  [2] = -1524180747, 
}


function IsNearPC()
  for i = 1, #pcs do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 0.75, pcs[i], 0, 0, 0)

    if DoesEntityExist(objFound) then
      TaskTurnPedToFaceEntity(PlayerPedId(), objFound, 3.0)
      return true
    end
  end

  if #(GetEntityCoords(PlayerPedId()) - vector3(1272.27, -1711.91, 54.78)) < 1.0 then
    SetEntityHeading(PlayerPedId(),14.0)
    return true
  end
  if #(GetEntityCoords(PlayerPedId()) - vector3(1275.4, -1710.52, 54.78)) < 5.0 then
    SetEntityHeading(PlayerPedId(),300.0)
    return true
  end


  return false
end

RegisterNetEvent("open:deepweb")
AddEventHandler("open:deepweb", function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
  guiEnabled = true
  SendNUIMessage({
    openSection = "deepweb" 
  })
end)

RegisterNetEvent("gangTasks:updated")
AddEventHandler("gangTasks:updated", function()
  local taskObject = {}
  for i = 1, #activeTasks do

    if activeTasks[i]["Gang"] ~= 0 and gang ~= 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then
      if gang == activeTasks[i]["Gang"] then
        taskObject[#taskObject + 1 ] = {
          name = TaskTitle[activeTasks[i]["TaskType"]],
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 0,
        }
      end
    elseif activeTasks[i]["Gang"] == 0 and tonumber(activeTasks[i]["taskOwnerCid"]) ~= cid then
      
      local passes = exports["isPed"]:isPed("passes")
      for z = 1, #passes do

        local passType = activeTasks[i]["Group"]
        if passes[z].pass_type == passType and (passes[z].rank == 2 or passes[z].rank > 3) then
          taskObject[#taskObject + 1 ] = {
            name = activeTasks[i]["TaskNameGroup"],
            assignedTo = activeTasks[i]["taskOwnerCid"],
            status = TaskState[activeTasks[i]["TaskState"]],
            identifier = activeTasks[i]["BlockChain"],
            groupId = passType,
            retrace = 0,
          }
        end

      end

    else
      if tonumber(activeTasks[i]["taskOwnerCid"]) == cid then

        local TaskName = ""
        if activeTasks[i]["Gang"] == 0 then
          TaskName = activeTasks[i]["TaskNameGroup"]
        else
          TaskName = TaskTitle[activeTasks[i]["TaskType"]]
        end
        taskObject[#taskObject + 1 ] = {
          name = TaskName,
          assignedTo = activeTasks[i]["taskOwnerCid"],
          status = TaskState[activeTasks[i]["TaskState"]],
          identifier = activeTasks[i]["BlockChain"],
          groupId = gang,
          retrace = 1
        }
      end
    end
  end

  SendNUIMessage({
    openSection = "addTasks",
    tasks = taskObject
  })
end)

RegisterNetEvent("purchasePhone")
AddEventHandler("purchasePhone", function()
  TriggerServerEvent("purchasePhone")
end)

RegisterNUICallback('btnMute', function()
  if phoneNotifications then
    TriggerEvent("DoLongHudText","Notifications Disabled.", 2)
  else
    TriggerEvent("DoLongHudText","Notifications Enabled.", 1)
  end
  phoneNotifications = not phoneNotifications
end)

RegisterNetEvent("tryTweet")
AddEventHandler("tryTweet", function(tweetinfo,message,user)
  if hasPhone() then
    TriggerServerEvent("AllowTweet",tweetinfo,message)
  end
end)

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)



RegisterNUICallback('btnGarage', function()
  local LocalPlayer = exports["varial-base"]:getModule("LocalPlayer")
  local Player = LocalPlayer:getCurrentCharacter()
  TriggerServerEvent("garages:loaded:in")
end)


RegisterNUICallback('btnHelp', function()
  closeGui()
  TriggerEvent("openWiki")
end)

RegisterNUICallback('carpaymentsowed', function()
  TriggerEvent("car:carpaymentsowed")
end)

RegisterNUICallback('sellVeh', function(data)
  TriggerEvent('DoLongHudText', 'Coming Soon')
end)

local timeSpawn = 0
RegisterNUICallback('vehspawn', function(data)
  local car, coords = RPC.execute("phone:attempt:sv", data.vehplate)
    canSpawnVehs = false
    if timeSpawn == 0 then
      timeSpawn = 30
      if car.vehicle_state == "Out" then
        SpawnVehicle(car.model, coords[1],coords[2],coords[3], car.fuel, car.data, car.license_plate, true,car.engine_damage,car.body_damage)
        startSpawnTime()
      else
        TriggerEvent('DoLongHudText', "Check you car in phone, its not yet out in garage.")
      end
    else
      TriggerEvent('DoLongHudText', "Please wait "..timeSpawn.." to use spawn again.")
    end
end)

function startSpawnTime()
  while true do
    Wait(1000)
    timeSpawn = timeSpawn-1
    if timeSpawn == 0 then
      break
    end
  end
end
RegisterNUICallback('vehtrack', function(data)
  TriggerServerEvent("get:vehicle:coords", data.vehplate)
end)


RegisterNUICallback('vehiclePay', function(data)
  TriggerServerEvent('car:dopayment', data.vehiclePlate)
end)

RegisterNetEvent("phone:carspawn", function(data,coords,state)
  for ind, value in pairs(data) do
    if state == "Out" then
      if #(vector3(coords[1],coords[2],coords[3]) - GetEntityCoords(PlayerPedId())) < 10.0 then
       -- DeleteBlip()
        trackVehicle = false
        SpawnVehicle(value.model, coords[1],coords[2],coords[3], value.fuel, value.data, value.license_plate, true,value.engine_damage,value.body_damage)
      else
        TriggerEvent("DoLongHudText","Nao podes tirar o veiculo de tao longe.", 2)
      end
    else
      TriggerEvent("DoLongHudText","Veiculo esta numa garagem.", 2)
    end
  end
end)

CurrentDisplayVehicle, ParkingSpot = nil, nil

function SpawnVehicle(vehicle, x,y,z, Fuel, customized, plate, IsViewing, enginehealth, bodyhealth)
  if DoesEntityExist(spawningVeh) then
    DeleteEntity(spawningVeh)
  end
	local car = GetHashKey(vehicle)
	local customized = json.decode(customized)
	Citizen.CreateThread(function()			
		Citizen.Wait(100)
        RequestModel(car)
        while not HasModelLoaded(car) do
            Citizen.Wait(0)
        end
        spawningVeh = CreateVehicle(car, x, y, z, true, false)
        SetModelAsNoLongerNeeded(car)
        DecorSetBool(spawningVeh, "PlayerVehicle", true)
        SetVehicleOnGroundProperly(spawningVeh)
        SetVehicleDirtLevel(spawningVeh, 0.0)
        SetEntityInvincible(spawningVeh, false) 
        SetVehicleNumberPlateText(spawningVeh, plate)
        SetVehicleProps(spawningVeh, customized)
        exports['varial-vehicles']:SetVehicleIdentifier(spawningVeh, vid)
        TriggerEvent("keys:addNew",spawningVeh, plate)
        SetVehicleHasBeenOwnedByPlayer(spawningVeh,true)
        local id = NetworkGetNetworkIdFromEntity(spawningVeh)
        SetNetworkIdCanMigrate(id, true)
        if not IsViewing then    
            CurrentDisplayVehicle = nil
            RPC.execute("varial-garages:states", "Out", plate, exports['varial-menu']:currentGarage(), pUpdatedFuel)
        end
    end)
end

function SetVehicleProps(veh, customized)
  SetVehicleModKit(veh, 0)
  if customized then
      
      SetVehicleWheelType(veh, customized.wheeltype)
      SetVehicleNumberPlateTextIndex(veh, 3)

      for i = 0, 16 do
          SetVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 17, 22 do
          ToggleVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 23, 24 do
          local isCustom = customized.mods[tostring(i)]
          if (isCustom == nil or isCustom == "-1" or isCustom == false or isCustom == 0) then
              isSet = false
          else
              isSet = true
          end
          SetVehicleMod(veh, i, customized.mods[tostring(i)], isCustom)
      end

      for i = 23, 48 do
          SetVehicleMod(veh, i, customized.mods[tostring(i)])
      end

      for i = 0, 3 do
          SetVehicleNeonLightEnabled(veh, i, customized.neon[tostring(i)])
      end

      if customized.extras ~= nil then
          for i = 1, 12 do
              local onoff = tonumber(customized.extras[i])
              if onoff == 1 then
                  SetVehicleExtra(veh, i, 0)
              else
                  SetVehicleExtra(veh, i, 1)
              end
          end
      end

      if customized.oldLiveries ~= nil and customized.oldLiveries ~= 24  then
          SetVehicleLivery(veh, customized.oldLiveries)
      end

      if customized.plateIndex ~= nil and customized.plateIndex ~= 4 then
          SetVehicleNumberPlateTextIndex(veh, customized.plateIndex)
      end

      -- Xenon Colors
      SetVehicleXenonLightsColour(veh, (customized.xenonColor or -1))
      SetVehicleColours(veh, customized.colors[1], customized.colors[2])
      SetVehicleExtraColours(veh, customized.extracolors[1], customized.extracolors[2])
      SetVehicleNeonLightsColour(veh, customized.lights[1], customized.lights[2], customized.lights[3])
      SetVehicleTyreSmokeColor(veh, customized.smokecolor[1], customized.smokecolor[2], customized.smokecolor[3])
      SetVehicleWindowTint(veh, customized.tint)
      SetVehicleInteriorColour(veh, customized.dashColour)
      SetVehicleDashboardColour(veh, customized.interColour)
  else

      SetVehicleColours(veh, 0, 0)
      SetVehicleExtraColours(veh, 0, 0)

  end
end

function findVehFromPlateAndLocate(plate)

  for ind, value in pairs(vehicles) do

    vehPlate = value.license_plate
  if vehPlate == plate then
    coordlocation = value.coords
    SetNewWaypoint(coordlocation[1], coordlocation[2], coordlocation[3])
    end
  end
end



function Trim(value)
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end



local recentspawnrequest = false
function findVehFromPlateAndSpawn(plate)

  if IsPedInAnyVehicle(PlayerPedId(), false) then
    return
  end

  for ind, value in pairs(vehicles) do

    vehPlate = value.license_plate
    if vehPlate == plate then
      state = value.vehicle_state
      coordlocation = value.coords

      if #(vector3(coordlocation[1],coordlocation[2],coordlocation[3]) - GetEntityCoords(PlayerPedId())) < 10.0 and state == "Out" then

        local DoesVehExistInProximity = CheckExistenceOfVehWithPlate(vehPlate)

        if not DoesVehExistInProximity and not recentspawnrequest then
          recentspawnrequest = true
          TriggerServerEvent("garages:phonespawn",vehPlate)
          Wait(10000)
          recentspawnrequest = false
        else
          print("Found vehicle already existing!")
        end

      end

    end

  end

end

RegisterNetEvent("phone:SpawnVehicle")
AddEventHandler('phone:SpawnVehicle', function(vehicle, plate, customized, state, Fuel, coordlocation)
  TriggerEvent("garages:SpawnVehicle", vehicle, plate, customized, state, Fuel, coordlocation)
end)




Citizen.CreateThread(function()
  local invehicle = false
  local plateupdate = "None"
  local vehobj = 0
  while true do
      Wait(1000)
      if not invehicle and IsPedInAnyVehicle(PlayerPedId(), false) then
        local playerPed = PlayerPedId()
        local veh = GetVehiclePedIsIn(playerPed, false)
          if GetPedInVehicleSeat(veh, -1) == PlayerPedId() then
            vehobj = veh
            local checkplate = GetVehicleNumberPlateText(veh)
            invehicle = true
            plateupdate = checkplate
            local coords = GetEntityCoords(vehobj)
            coords = { coords["x"], coords["y"], coords["z"] }
            TriggerServerEvent("vehicle:coords",plateupdate,coords)
          end
      end
      if invehicle and not IsPedInAnyVehicle(PlayerPedId(), false) then
        local coords = GetEntityCoords(vehobj)
        coords = { coords["x"], coords["y"], coords["z"] }
        TriggerServerEvent("vehicle:coords",plateupdate,coords)
        invehicle = false
        plateupdate = "None"
        vehobj = 0
      end  
  end
end)



function CheckExistenceOfVehWithPlate(platesent)
  local playerped = PlayerPedId()
  local playerCoords = GetEntityCoords(playerped)
  local handle, scannedveh = FindFirstVehicle()
  local success
  local rped = nil
  local distanceFrom
  repeat
      local pos = GetEntityCoords(scannedveh)
      local distance = #(playerCoords - pos)
        if distance < 50.0 then
          local checkplate = GetVehicleNumberPlateText(scannedveh)
          if checkplate == platesent then
            return true
          end
        end
      success, scannedveh = FindNextVehicle(handle)
  until not success
  EndFindVehicle(handle)
  return false
end

local currentVehicles = {}

RegisterNetEvent("phone:Garage")
AddEventHandler("phone:Garage", function(vehs)
  vehicles = vehs
  local showCarPayments = false
  local rankCarshop = exports["isPed"]:GroupRank("car_shop")
  local rankImport = exports["isPed"]:GroupRank("illegal_carshop")
  local job = exports["isPed"]:isPed("myjob")


  if rankCarshop > 0 or rankImport > 0 or job == "judge" or job == "police" or job == "sheriff" or job == "state"then
    showCarPayments = true
  end

  local parsedVehicleData = {}
  for ind, value in pairs(vehs) do
    enginePercent = value.engine_damage / 10
    bodyPercent = value.body_damage / 10
    vehName = value.name
    vehPlate = value.license_plate
    currentGarage = value.current_garage
    state = value.vehicle_state
    fuel = value.fuel
    model = value.model
    -- coordlocation = value.coords
    -- local carcoords = json.decode(coordlocation)
   -- coordlocation = vehCoords
    --local coordlocation = RPC.execute("GetVehCoords",vehPlate)
   -- print(carcoords[1])
   -- allowspawnattempt = 0
    --canSpawn = 0
    -- if #(vector3(coordlocation[1], coordlocation[2], coordlocation[3]) - GetEntityCoords(PlayerPedId())) < 20.0 and state == "Out" then
    --   allowspawnattempt = 1
    --   canSpawn = 1
    -- end
    
 
    table.insert(parsedVehicleData, {
      name = vehName,
      plate = vehPlate,
      garage = currentGarage,
      state = state,
      enginePercent = enginePercent,
      bodyPercent = bodyPercent,
      payments = value.payments_left, -- total payments left
      lastPayment = value.last_payment, -- Days left
      amountDue = value.financed, -- amount due
      coordlocation = coordlocation,
      fuel = fuel,
      model = model
    })

    for i = 1, #parsedVehicleData do
      if parsedVehicleData[i].plate == vehSpawnPlate and canSpawnVehs and canSpawnDist < 5 then
        parsedVehicleData[i] = {
          name = parsedVehicleData[i].name,
          plate = parsedVehicleData[i].plate,
          garage = parsedVehicleData[i].garage,
          state = parsedVehicleData[i].state,
          enginePercent = parsedVehicleData[i].enginePercent,
          bodyPercent = parsedVehicleData[i].bodyPercent,
          payments = parsedVehicleData[i].payments,
          lastPayment = parsedVehicleData[i].lastPayment,
          amountDue = parsedVehicleData[i].amountDue,
          coordlocation = parsedVehicleData[i].coordlocation,
          fuel = parsedVehicleData[i].fuel,
          model = parsedVehicleData[i].model,
        canSpawn = 1 
      }
      end
      
      
    end
    -- if vehPlate ~= nil then
    --   if value.license_plate == vehSpawnPlate and canSpawnVeh then
    --     print("MY CAR", value.fuel,vehPlate)
    --     -- lstnotifications[#lstnotifications + 1]
    --     parsedVehicleData[#parsedVehicleData+1] =  {canSpawn = 1}
    --   else
    --     parsedVehicleData[#parsedVehicleData+1] =  {canSpawn = 0}
    --   end
    -- end


  end
  
  SendNUIMessage({ openSection = "Garage", showCarPaymentsOwed = showCarPayments, vehicleData = parsedVehicleData})
end)



local pickuppoints = {
  [1] =  { ['x'] = 923.94,['y'] = -3037.88,['z'] = 5.91,['h'] = 270.81, ['info'] = ' Shipping Container BMZU 822693' },
  [2] =  { ['x'] = 938.02,['y'] = -3026.28,['z'] = 5.91,['h'] = 265.85, ['info'] = ' Shipping Container BMZU 822693' },
  [3] =  { ['x'] = 1006.17,['y'] = -3028.94,['z'] = 5.91,['h'] = 269.31, ['info'] = ' Shipping Container BMZU 822693' },
  [4] =  { ['x'] = 1020.42,['y'] = -3044.91,['z'] = 5.91,['h'] = 87.37, ['info'] = ' Shipping Container BMZU 822693' },
  [5] =  { ['x'] = 1051.75,['y'] = -3045.09,['z'] = 5.91,['h'] = 268.37, ['info'] = ' Shipping Container BMZU 822693' },
  [6] =  { ['x'] = 1134.92,['y'] = -2992.22,['z'] = 5.91,['h'] = 87.9, ['info'] = ' Shipping Container BMZU 822693' },
  [7] =  { ['x'] = 1149.1,['y'] = -2976.06,['z'] = 5.91,['h'] = 93.23, ['info'] = ' Shipping Container BMZU 822693' },
  [8] =  { ['x'] = 1121.58,['y'] = -3042.39,['z'] = 5.91,['h'] = 88.49, ['info'] = ' Shipping Container BMZU 822693' },
  [9] =  { ['x'] = 830.58,['y'] = -3090.46,['z'] = 5.91,['h'] = 91.15, ['info'] = ' Shipping Container BMZU 822693' },
  [10] =  { ['x'] = 830.81,['y'] = -3082.63,['z'] = 5.91,['h'] = 271.61, ['info'] = ' Shipping Container BMZU 822693' },
  [11] =  { ['x'] = 909.91,['y'] = -2976.51,['z'] = 5.91,['h'] = 271.02, ['info'] = ' Shipping Container BMZU 822693' },
}


function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
blip = 0

function CreateBlip(location)
    DeleteBlip()
    blip = AddBlipForCoord(location["x"],location["y"],location["z"])
    SetBlipSprite(blip, 514)
    SetBlipScale(blip, 1.0)
    SetBlipAsShortRange(blip, false)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Pick Up")
    EndTextCommandSetBlipName(blip)
end
function DeleteBlip()
  if DoesBlipExist(blip) then
    RemoveBlip(blip)
  end
end

function refreshmail()
    lstnotifications = {}
    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }
        lstnotifications[#lstnotifications+1]= message2
    end
    SendNUIMessage({openSection = "notifications", list = lstnotifications})
end

local weaponList = {
  [1] = 324215364,
  [2] = 736523883,
  [3] = 4024951519,
  [4] = 1627465347,
}

local weaponListSmall = {
  [1] = 2017895192,
  [2] = 584646201,
  [3] = 3218215474,
}

local luckList = {
  [1] =  "extended_ap",
  [2] =  "extended_sns",
  [3] =  "extended_micro",
  [4] =  "rifleammo",
  [5] =  "heavyammo",
  [6] =  "lmgammo",
}

-- RegisterNUICallback('btnDelivery', function()
--   TriggerEvent("trucker:confirmation")
-- end)

-- RegisterNUICallback('btnPackages', function()
--   insideDelivers = true
--   TriggerEvent("Trucker:GetPackages")
-- end)

-- RegisterNUICallback('btnTrucker', function()
--   TriggerEvent("Trucker:GetJobs")
-- end)

-- RegisterNUICallback('resetPackages', function()
--   insideDelivers = false
-- end)


-- RegisterNetEvent("phone:trucker")
-- AddEventHandler("phone:trucker", function(jobList)

--   local deliveryObjects = {}
--   for i, v in pairs(jobList) do
--     local nameTag = ""
--     local itemTag
--     local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(v.pickup[1], v.pickup[2], v.pickup[3], currentStreetHash, intersectStreetHash)
--     local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
--     local intersectStreetName = GetStreetNameFromHashKey(intersectStreetHash)

--     local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
--     local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
--     local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)
--     if v.active == 0 then
--         table.insert(deliveryObjects, {
--           targetStreet = currentStreetName2,
--           jobId = v.id,
--           jobType = v.JobType
--         })
--     end
--   end 
--   SendNUIMessage({
--     openSection = "deliveryJob",
--     deliveries = deliveryObjects
--   })
    
-- end)

-- local requestHolder = 0

-- RegisterNetEvent("phone:packages")
-- AddEventHandler("phone:packages", function(packages)
--   while insideDelivers do
--     if requestHolder ~= 0 then
--       SendNUIMessage({
--         openSection = "packagesWith"
--       })
--     else
--       SendNUIMessage({
--         openSection = "packages"
--       })
--     end
    
    
--     for i, v in pairs(packages) do
--       if GetPlayerServerId(PlayerId()) == v.source then
--         local currentStreetHash2, intersectStreetHash2 = GetStreetNameAtCoord(v.drop[1], v.drop[2], v.drop[3], currentStreetHash2, intersectStreetHash2)
--         local currentStreetName2 = GetStreetNameFromHashKey(currentStreetHash2)
--         local intersectStreetName2 = GetStreetNameFromHashKey(intersectStreetHash2)

--         SendNUIMessage({openSection = "addPackages", street2 = currentStreetName2, jobId = v.id ,distance = getDriverDistance(v.driver , v.drop)})
--       end
--     end 
--     Wait(4000)
--   end
-- end)


-- RegisterNetEvent("phone:OwnerRequest")
-- AddEventHandler("phone:OwnerRequest", function(holder)
--   requestHolder = holder
-- end)

-- RegisterNUICallback('btnRequest', function()
--   TriggerServerEvent("trucker:confirmRequest",requestHolder)
--   requestHolder = 0
-- end)




-- function getDriverDistance(driver , drop)
--   local dist = 0

--   local ped = GetPlayerPed(value)
--   if driver ~= 0 then
--     local current = #(vector3(drop[1],drop[2],drop[3]) - GetEntityCoords(ped))
--     if current < 15 then
--       dist = "Driver at store"
--     else
--       dist = current
--       dist = math.ceil(dist)
--     end
    
--   else
--     dist = "Waiting for driver"
--   end

--   return dist
-- end

RegisterNUICallback('selectedJob', function(data, cb)
    TriggerEvent("Trucker:SelectJob",data)
end)



-- gurgleList = {}
-- RegisterNetEvent('websites:updateClient')
-- AddEventHandler('websites:updateClient', function(passedList)
--   gurgleList = passedList

--   local gurgleObjects = {}

--   if not guiEnabled then
--     return
--   end

--   for i = 1, #gurgleList do
--     table.insert(gurgleObjects, {
--       webTitle = gurgleList[i]["Title"], 
--       webKeywords = gurgleList[i]["Keywords"], 
--       webDescription = gurgleList[i]["Description"] 
--     })
--   end

--   SendNUIMessage({ openSection = "gurgleEntries", gurgleData = gurgleObjects})
-- end)

function DrawRadioChatter(x,y,z, text,opacity)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    if opacity > 215 then
      opacity = 215
    end
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, opacity)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
local activeMessages = 0

RegisterNetEvent('radiotalkcheck')
AddEventHandler('radiotalkcheck', function(args,senderid)

  if hasRadio() and radioChannel ~= 0 then
    randomStatic(true)

    local ped = GetPlayerPed( -1 )

      if ( DoesEntityExist( ped ) and not IsEntityDead( ped )) then

        loadAnimDict( "random@arrests" )

        TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )

        SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
      end


    TriggerServerEvent("radiotalkconfirmed",args,senderid,radioChannel)
    Citizen.Wait(2500)
    ClearPedSecondaryTask(PlayerPedId())
  end

end)

function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function randomStatic(loud)
  local vol = 0.05
  if loud then
    vol = 0.9
  end
  local pickS = math.random(4)
  if pickS == 4 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic1",vol)
  elseif pickS == 3 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic2",vol)
  elseif pickS == 2 then
    TriggerEvent("InteractSound_CL:PlayOnOne","radiostatic3",vol)
  else
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",vol)
  end

end

RegisterNetEvent('radiotalk')
AddEventHandler('radiotalk', function(args,senderid,channel)

    local senderid = tonumber(senderid)

    table.remove(args,1)
    local radioMessage = ""
    for i = 1, #args do
        radioMessage = radioMessage .. " " .. args[i]
    end

    if channel == radioChannel and hasRadio() and radioMessage ~= nil then
      -- play radio click sound locally.
      TriggerEvent('chatMessage', "RADIO #" .. channel, 3, radioMessage, 5000)
      randomStatic(true)

      local radioMessage = ""
      for i = 1, #args do
        if math.random(50) > 25 then
          radioMessage = radioMessage .. " " .. args[i]
        else
          radioMessage = radioMessage .. " **BZZZ** "
        end
      end
      TriggerServerEvent("radiochatter:server",radioMessage)
    end
end)

RegisterNetEvent('radiochatter:client')
AddEventHandler('radiochatter:client', function(radioMessage,senderid)

    local senderid = tonumber(senderid) 
    local location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
    local dst = #(GetEntityCoords(PlayerPedId()) - location)
    activeMessages = activeMessages + 0.1
    if dst < 5.0 then
      -- play radio static sound locally.
      local counter = 350
      local msgZ = location["z"]+activeMessages
      if PlayerPedId() ~= GetPlayerPed(GetPlayerFromServerId(senderid)) then
        randomStatic(false)
        while counter > 0 and dst < 5.0 do
          location = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(senderid)))
          dst = #(GetEntityCoords(PlayerPedId()) - location)
          DrawRadioChatter(location["x"],location["y"],msgZ, "Radio Chatter: " .. radioMessage, counter)
          counter = counter - 1
          Citizen.Wait(1)
        end
      end
    end
    activeMessages = activeMessages - 0.1 
end)


RegisterNetEvent('radiochannel')
AddEventHandler('radiochannel', function(chan)
  local chan = tonumber(chan)
  if hasRadio() and chan < 1000 and chan > -1 then
    radioChannel = chan
    TriggerEvent("InteractSound_CL:PlayOnOne","radioclick",0.4)
    -- TriggerEvent('chatMessage', "RADIO CHANNEL " .. radioChannel, 3, "Active", 5000)
  end
end)

RegisterNetEvent('canPing')
AddEventHandler('canPing', function(target)
  if hasPhone() and not isDead then
    local crds = GetEntityCoords(PlayerPedId())
    TriggerServerEvent("requestPing", target, crds["x"],crds["y"],crds["z"])
  else
    TriggerEvent("DoLongHudText","You need a phone to use GPS!",2)
  end
end)

local pingcount = 0
local currentblip = 0
local currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
RegisterNetEvent('allowedPing')
AddEventHandler('allowedPing', function(x,y,z,src,name)
  if pingcount > 0 then
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you already have one in process!",2)
    return
  end
  
  if hasPhone() and not isDead then
    pingcount = 5
    currentping = { ["x"] = x,["y"] = y,["z"] = z, ["src"] = src }
    while pingcount > 0 do
      TriggerEvent("DoLongHudText",name .. " has given you a ping location, type /pingaccept to accept",1)
      Citizen.Wait(5000)
      pingcount = pingcount - 1
    end
  else
    TriggerEvent("DoLongHudText","Somebody sent you a GPS flag but you have no phone!",2)
  end
  pingcount = 0
  currentping = { ["x"] = 0.0,["y"] = 0.0,["z"] = 0.0, ["src"] = 0 }
end)


RegisterNetEvent("phoneEnabled")
AddEventHandler("phoneEnabled", function(phoneopensent)
  phoneopen = phoneopensent
end)

RegisterNUICallback('sethGps', function(data)
 --local house = exports["varial-housing"]:retrieveHousingTableMapped()
  for i,k in pairs(house) do

    if k.id == data.hid then
      if DoesBlipExist(currentblip) then
        RemoveBlip(currentblip)
      end
      currentblip = AddBlipForCoord(k.coords["x"], k.coords["y"], k.coords["z"])
      SetBlipSprite(currentblip, 40)
      SetBlipAsShortRange(currentblip, false)
      BeginTextCommandSetBlipName("STRING")
      SetBlipColour(currentblip, 4)
      SetBlipScale(currentblip, 1.2)
      AddTextComponentString("House GPS")
      EndTextCommandSetBlipName(currentblip)
      TriggerEvent("DoLongHudText","House GPS Set to your map.", 1)
      pingcount = 0
      Citizen.Wait(60000)
      if DoesBlipExist(currentblip) then
        RemoveBlip(currentblip)
      end
    end
  end
 
end)

RegisterNUICallback('unlockHouses', function(data)
  print('HID',data.hid, data.status)
  local hId = data.hid
  local status = data.status
  if status == "Unlock" then
    TriggerEvent('varial-newphone:h-Lock', hId,"Lock")
  else
    TriggerEvent('varial-newphone:h-Lock', hId,"Unlock")
  end
  TriggerServerEvent('varial-newphone:house:status',hId,status)
  Wait(200)
  TriggerEvent('updateHousing')
end)



RegisterNUICallback('sellOwnHouse', function(data)
  local price = RPC.execute('varial-newphone:getHousePrice', data.hid)
end)

RegisterNUICallback('giveAccess', function(data)
  local complete = RPC.execute('varial-newphone:GiveAccess', data.hid,data.cid)
  print("GIVE ACCESS",complete)
  
    
  if not complete then
    TriggerEvent("DoLongHudText", "You already gave a key to this person",2)
    return
  end
  TriggerEvent('DoLongHudText', 'You successfully give a key')
end)

RegisterNUICallback('houseAccess', function(data)
  print("DATA HID HERE", data.hid)
  local access = RPC.execute('varial-newphone:getAccessHouse', data.hid)
  local data = {
      {
        title = "Close",
        action = "varial-housing:close_access",
        key = {},
    },
  }
  local player = {}
  for i,k in pairs(access) do
    data[#data + 1] = {
          title = k.name,
          description = "House: "..k.house.." CID:"..k.cid,
          key = {"lockdown"},
          -- action = "varial-ui:apartmentsContext"
          children = {
            {
                title = "Remove Key",
                description = "Remove Access.",
                params = {k.cid, k.house},
                action = "varial-ui:apartmentsContext"
            }
          }
      }
  end
  exports["varial-contexts"]:showContext(data)
end)

AddEventHandler("varial-housing:close_access", function()
  exports["varial-contexts"]:hideContext()
end)

AddEventHandler('varial-ui:apartmentsContext', function(data)
  RPC.execute("varial-newphone:removeKeys",data[2],data[1])
  exports["varial-ui"]:hideContext(data)
end)

RegisterNetEvent('acceptPing')
AddEventHandler('acceptPing', function()
  if pingcount > 0 then
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
    currentblip = AddBlipForCoord(currentping["x"], currentping["y"], currentping["z"])
    SetBlipSprite(currentblip, 280)
    SetBlipAsShortRange(currentblip, false)
    BeginTextCommandSetBlipName("STRING")
    SetBlipColour(currentblip, 4)
    SetBlipScale(currentblip, 1.2)
    AddTextComponentString("Accepted GPS Marker")
    EndTextCommandSetBlipName(currentblip)
    TriggerEvent("DoLongHudText","Their GPS ping has been marked on the map", 1)
    TriggerServerEvent("pingAccepted",currentping["src"])
    pingcount = 0
    Citizen.Wait(60000)
    if DoesBlipExist(currentblip) then
      RemoveBlip(currentblip)
    end
  end
end)

function isRealEstateAgent()
  if GroupRank("real_estate") > 0 then
    return true
  else
    return false
  end
end

function hasDecrypt2()
    if exports["varial-inventory"]:hasEnoughOfItem("vpnxj",1,false,true) then
      return true
    else
      return false
    end
end

function hasTrucker()
    if exports["varial-base"]:getModule("LocalPlayer"):getVar("job") == "trucker"  then
      return true
    else
      return false
    end
end

function hasDecrypt()
    if exports["varial-inventory"]:hasEnoughOfItem("decrypterenzo",1,false) or exports["varial-inventory"]:hasEnoughOfItem("decryptersess",1,false) or exports["varial-inventory"]:hasEnoughOfItem("decrypterfv2",1,false) and not exports["isPed"]:isPed("disabled") or exports["varial-inventory"]:hasEnoughOfItem(80,1,false) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function hasDevice()
    if exports["varial-inventory"]:hasEnoughOfItem("mk2usbdevice",1,false) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function hasPhone()
    if
      (
      (exports["varial-inventory"]:hasEnoughOfItem("mobilephone",1,false) or 
      exports["varial-inventory"]:hasEnoughOfItem("stoleniphone",1,false) or 
      exports["varial-inventory"]:hasEnoughOfItem("stolens8",1,false) or
      exports["varial-inventory"]:hasEnoughOfItem("stolennokia",1,false) or
      exports["varial-inventory"]:hasEnoughOfItem("stolenpixel3",1,false) or
      exports["varial-inventory"]:hasEnoughOfItem("assphone",1,false) or
      exports["varial-inventory"]:hasEnoughOfItem("boomerphone",1,false))
      and not exports["isPed"]:isPed("disabled") and not exports["isPed"]:isPed("handcuffed")
      ) 
    then
      return true
    else
      return false
    end
end

function hasRadio()
    if (exports["varial-inventory"]:hasEnoughOfItem("radio",1,false) or exports["varial-inventory"]:hasEnoughOfItem("pdradio",1,false)) and not exports["isPed"]:isPed("disabled") then
      return true
    else
      return false
    end
end

function openGui()

  if recentopen then
    return
  end
  pPhoneOpen = true
  if hasPhone() then
    GiveWeaponToPed(PlayerPedId(), 0xA2719263, 0, 0, 1)
    guiEnabled = true
    SetNuiFocus(false,false)
    SetNuiFocus(true,true)

    local isREAgent = false
    if isRealEstateAgent() then
      isREAgent = true
    end

    local device = false
    if hasDevice() then
      device = true
    end

    local decrypt = false
    if hasDecrypt() then
      decrypt = true
    end

    local decrypt2 = false
    if hasDecrypt2() then
      decrypt2 = true
    end

    local trucker = false
    if hasTrucker() then
      trucker = true
    end 
    TriggerServerEvent('bank:get:balance')
   -- local near = exports['varial-housing']:isNearProperty()
    --local house = RPC.execute("varial-newphone:getHouses")
    -- print("NEAR HOUSE?",near,json.encode(house))
    local phoneBGrep = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")

    if phoneBGrep == " " or phoneBGrep =="" or phoneBGrep == nil then
      phoneBGrep = "https://i.imgur.com/jwjtesO.png"
    else
      phoneBGrep = GetResourceKvpString(exports['isPed']:isPed('cid').."-bg")
    end
    SendNUIMessage({
      openPhone = true,
      wifiZone = nearWifiZone, 
      pOpenPhone = true, 
      hasDevice = device, 
      hasDecrypt = decrypt, 
      hasDecrypt2 = decrypt2,
      hasTrucker = trucker, 
      bgPhone = phoneBG, 
      isRealEstateAgent = isREAgent, 
      playerId = GetPlayerServerId(PlayerId()),
      wallpaper = phoneBGrep,
      unrmsg = unReadMsg, 
      unrTwat = unReadTwt, 
      unrEmail = unReadEmail, 
      sanitation = sanitation,
      housing = house,
      nearProperty = near
    })
    TriggerEvent('phoneEnabled',true)
    TriggerEvent('animation:sms',true)
    -- TriggerServerEvent('varial-newphone:grabWallpaper')
        --TaskStartScenarioInPlace(PlayerPedId(), "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, 1)
        
    -- If this is the first time we've opened the phone, load all contacts
    
    lstContacts = {}
    TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
    doTimeUpdate()
  else
    closeGui()
    if not exports["isPed"]:isPed("disabled") then
      TriggerEvent("DoLongHudText","You do not have a phone.",2)
    else
      TriggerEvent("DoLongHudText","You cannot use your phone right now.",2)
    end
  end
  recentopen = false
end

RegisterNUICallback('btnPagerType', function(data, cb)
  TriggerServerEvent("secondaryjob:ServerReturnDate")
end)
local jobnames = {
  ["taxi"] = "Taxi Driver",
  ["towtruck"] = "Tow Truck Driver",
  ["trucker"] = "Delivery Driver",
}

RegisterNUICallback('newPostSubmit', function(data, cb)
  if data.advert == "" then
    TriggerEvent('DoLongHudText', 'You need to put words in fill.',2)
    return
  end
    TriggerServerEvent('phone:updatePhoneJob', data.advert)
end)

RegisterNUICallback('btnDecrypt', function()
  TriggerEvent("secondaryjob:accepttask")
end)


function miTrabajo()
    return exports['isPed']:isPed('job')
end

RegisterNUICallback('deleteYP', function()
  TriggerServerEvent('phone:deleteYP')
end)

RegisterNetEvent("yellowPages:retrieveLawyersOnline")
AddEventHandler("yellowPages:retrieveLawyersOnline", function()
  local isFound = false
  TriggerEvent('chatMessage', "", 2, "Searching for a lawyer...")
  for i = 1, #YellowPageArray do
    local job = string.lower(YellowPageArray[tonumber(i)].job)
    if string.find(job, 'attorney') or string.find(job, 'lawyer') or string.find(job, 'public defender') then
      isFound = true
      TriggerEvent('chatMessage', "", 2, "⚖️ " .. YellowPageArray[i].name .. " ☎️ " .. YellowPageArray[i].phonenumber)
    end
  end
  if not isFound then
    TriggerEvent('chatMessage', "", 2, "There are no lawyers available right now. 😢")
  end
end)


RegisterNUICallback('notificationsYP', function()
  TriggerServerEvent('getYP')
  Citizen.Wait(200)
  TriggerEvent("YPUpdatePhone")
end)


RegisterNetEvent('YPUpdatePhone')
AddEventHandler('YPUpdatePhone', function()

  lstnotifications = {}

  for i = 1, #YellowPageArray do
      lstnotifications[#lstnotifications + 1] = {
        id = tonumber(i),
        name = YellowPageArray[tonumber(i)].name,
        message = YellowPageArray[tonumber(i)].job,
        phoneNumber = YellowPageArray[tonumber(i)].phonenumber
      }
  end
  SendNUIMessage({openSection = "notificationsYP", list = lstnotifications})
end)

-- Close Gui and disable NUI
function closeGui()
  TriggerEvent("closeInventoryGui")
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  TriggerEvent('animation:sms',false)
  TriggerEvent('phoneEnabled',false)
  -- TriggerEvent('varial-newphone:UpdateStatePhone')
  pPhoneOpen = false
  recentopen = true
  Citizen.Wait(3000)
  recentopen = false
  insideDelivers = false
end

-- RegisterNetEvent('varial-newphone:UpdateStatePhone')
-- AddEventHandler('varial-newphone:UpdateStatePhone', function()
--     Wait(5)
--     print(callStatus, isCallInProgress)
--     if callStatus == isCallInProgress then 
--       print("PHONE MEDIO 3")
--       SendNUIMessage({openSection = "phonemedio"}) 
--     end
-- end)

function getCardinalDirectionFromHeading()
  local heading = GetEntityHeading(PlayerPedId())
  if heading >= 315 or heading < 45 then
      return "North Bound"
  elseif heading >= 45 and heading < 135 then
      return "West Bound"
  elseif heading >= 135 and heading < 225 then
      return "South Bound"
  elseif heading >= 225 and heading < 315 then
      return "East Bound"
  end
end

function closeGui2()
  SetNuiFocus(false,false)
  SendNUIMessage({openPhone = false})
  guiEnabled = false
  recentopen = true
  Citizen.Wait(3000)
  recentopen = false  
end

local mousenumbers = {
  [1] = 1,
  [2] = 2,
  [3] = 3, 
  [4] = 4, 
  [5] = 5, 
  [6] = 6, 
  [7] = 12, 
  [8] = 13, 
  [9] = 66, 
  [10] = 67, 
  [11] = 95, 
  [12] = 96,   
  [13] = 97,   
  [14] = 98,
  [15] = 169,
   [16] = 170,
}



-- Opens our phone
RegisterNetEvent('phoneGui2')
AddEventHandler('phoneGui2', function()
  openGui()
  
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
  closeGui()
  cb('ok')
end)

RegisterNetEvent('phone:close')
AddEventHandler('phone:close', function(number, message)
  closeGui()

end)



function testfunc()

end
RegisterNetEvent("TokoVoip:UpVolume");
AddEventHandler("TokoVoip:UpVolume", setVolumeUp);

RegisterNetEvent('refreshContacts')
AddEventHandler('refreshContacts', function()
  TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
  SendNUIMessage({openSection = "contacts"})
end)

RegisterNetEvent('refreshYP')
AddEventHandler('refreshYP', function()
  if guiEnabled then
    TriggerServerEvent('getYP')
    Citizen.Wait(250)
    TriggerEvent('YPUpdatePhone')
  end
end)


RegisterNUICallback('refreshContacts', function()
  TriggerEvent('contacts')
end)

-- Contact Callbacks
RegisterNUICallback('contacts', function(data, cb)
  TriggerServerEvent('phone:getSMSc')
  TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
  SendNUIMessage({openSection = "contacts"})
  cb('ok')
end)

RegisterNUICallback('newContact', function(data, cb)
  SendNUIMessage({openSection = "newContact"})
  cb('ok')
end)

RegisterNUICallback('newContactSubmit', function(data, cb)
  TriggerEvent('phone:addContact', data.name, tonumber(data.number))
  cb('ok')
end)

RegisterNUICallback('editContactSubmit', function(data, cb)
  SendNUIMessage({
    emptyContacts = true
  })
  TriggerServerEvent('phone:editContact', data.name, tonumber(data.number),data.oldName)
  Wait(100)
  TriggerServerEvent('phone:getContacts')
  cb('ok')
end)

RegisterNUICallback('updateMyWallpaper', function(data, cb)
  wallPaper = ""
  Wait(5)
  TriggerEvent('varial-newphone:grabBackground', data.name .."?auto=compress&cs=tinysrgb&h=350")
  -- TriggerServerEvent("phone:saveWallpaper",exports['isPed']:isPed('cid'), data.name .."?auto=compress&cs=tinysrgb&h=350")
  -- SetResourceKvp(exports['isPed']:isPed('cid')"-bg"
  cb('ok')
end)

RegisterNUICallback('removeContact', function(data, cb)
  TriggerServerEvent('phone:removeContact', data.name, data.number)
  cb('ok')
end)


myID = 0
mySourceID = 0

mySourceHoldStatus = false
TriggerEvent('phone:setCallState', isNotInCall)
costCount = 1

RegisterNetEvent('animation:phonecallstart')
AddEventHandler('animation:phonecallstart', function()
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",true)
  local lPed = PlayerPedId()
  RequestAnimDict("cellphone@")
  while not HasAnimDictLoaded("cellphone@") do
    Citizen.Wait(0)
  end
  local count = 0
  costCount = 1
  inPhone = false
  Citizen.Wait(200)
  ClearPedTasks(lPed)
  
  TriggerEvent("attachItemPhone","phone01")
  -- TriggerEvent("DoLongHudText","[E] Toggles Call.", 6)


  while callStatus ~= isNotInCall do

    if isDead then
      endCall()
    end


    if IsEntityPlayingAnim(lPed, "cellphone@", "cellphone_call_listen_base", 3) and not IsPedRagdoll(PlayerPedId()) then
    else 



      if IsPedRagdoll(PlayerPedId()) then
        Citizen.Wait(1000)
      end
      TaskPlayAnim(lPed, "cellphone@", "cellphone_call_listen_base", 1.0, 1.0, -1, 49, 0, 0, 0, 0)
    end
    Citizen.Wait(1)
    count = count + 1

    if IsControlJustPressed(0, 38) then
      TriggerEvent("phone:holdToggle")
    end

    if onhold then
      if count == 800 then
         count = 0
        --  TriggerEvent("DoLongHudText","Call On Hold.", 1)
      end
    end

      --check if not unarmed
    local curw = GetSelectedPedWeapon(PlayerPedId())
    noweapon = `WEAPON_UNARMED`
    if noweapon ~= curw then
      SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end

  end
  ClearPedTasks(lPed)
  TaskPlayAnim(lPed, "cellphone@", "cellphone_call_out", 2.0, 2.0, 800, 49, 0, 0, 0, 0)
  Citizen.Wait(700)
  TriggerEvent("destroyPropPhone")
  TriggerEvent("incall",false)
end)

-- RegisterNetEvent('phone:makecall')
-- AddEventHandler('phone:makecall', function(pnumber)
--   local pnumber = tonumber(pnumber)
--   if callStatus == isNotInCall and not isDead and hasPhone() then
--     local dialingName = getContactName(pnumber)
--     TriggerEvent('phone:setCallState', isDialing, dialingName)
--     TriggerEvent("animation:phonecallstart")
--     recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = pnumber, ["name"] = dialingName }
--     TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, true)
--   else
--     TriggerEvent("It appears you are already in a call, injured or without a phone, please type /hangup to reset your calls.", 2)
--   end
-- end)




local PayPhoneHex = {
  [1] = 1158960338,
  [2] = -78626473,
  [3] = 1281992692,
  [4] = -1058868155,
  [5] = -429560270,
  [6] = -2103798695,
  [7] = 295857659,
}

RegisterNetEvent("pass:coords:vehicle")
AddEventHandler("pass:coords:vehicle", function(plate,coords)
  -- print(coords,plate)
  vehSpawnPlate = plate
  vehCoords = coords
  local VehicleCoords = coords
  local car = AddBlipForCoord(VehicleCoords[1],VehicleCoords[2],VehicleCoords[3])
  SetBlipSprite(car, 225)
  SetBlipScale(car, 1.2)
  SetBlipAsShortRange(car, false)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("Lost Vehicle")
  EndTextCommandSetBlipName(car)
  TriggerEvent("DoLongHudText", "Vehicle marked on the map!")
  trackVehicle = true

  Citizen.CreateThread(function()
    while trackVehicle do
      local dist = #(vector3(VehicleCoords[1],VehicleCoords[2],VehicleCoords[3]) - GetEntityCoords(PlayerPedId()))
      canSpawnVehs = true
      canSpawnDist = dist
      -- spawnStatus = true
      -- spawnStatus(true)
      Wait(1000)
      if dist < 5.0 then
        RemoveBlip(car)
        insideTrack = true
      end
      if dist > 5.0 and insideTrack then
        canSpawnVehs = false
        insideTrack = false
        return
      end
    end
  end)
  if displaymarker then
    print("OK")
  else
    print("NOK")
  end
end)

function checkForPayPhone()
  for i = 1, #PayPhoneHex do
    local objFound = GetClosestObjectOfType( GetEntityCoords(PlayerPedId()), 5.0, PayPhoneHex[i], 0, 0, 0)
    if DoesEntityExist(objFound) then
      return true
    end
  end
  return false
end

AddEventHandler('phone:makepayphonecall', function(pnumber) 
  if not checkForPayPhone() then
    TriggerEvent("DoLongHudText","You are not near a payphone.",2)
    return
  end

  PhoneBooth = GetEntityCoords( PlayerPedId() )
  AnonCall = true

  local pnumber = tonumber(pnumber)
  if callStatus == isNotInCall and not isDead then
    TriggerEvent('phone:setCallState', isDialing)
    TriggerEvent("animation:phonecallstart")
    TriggerEvent("InteractSound_CL:PlayOnOne","payphonestart",0.5)
    TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), pnumber, false)
    TriggerServerEvent("phone:RemovePayPhoneMoney")
  else
    TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
  end
end)

RegisterNetEvent("payphone:ui")
AddEventHandler("payphone:ui", function()
local ph = exports["varial-applications"]:KeyboardInput({
  header = "Payphone",
  rows = {
    {
      id = 1,
      txt = "Number"
    }
  }
})
if ph then
  if ph[1].input ~= nil then
    TriggerEvent("phone:makepayphonecall", ph[1].input)
  end
end
end)

--[[ The following happens for regular calls too ]]

-- RegisterNUICallback('callContact', function(data, cb)
--   -- closeGui()
--   -- Wait(1500)
--   if callStatus == isNotInCall and not isDead and hasPhone() then
--     local dialingName = getContactName(data.number)
--     SendNUIMessage({
--       openSection = 'callnotify',
--       pCNumber = dialingName
--     })
--     if exports['varial-newphone']:pOpen() == false then 
--       -- print("FUCK THIS SHIT")
--         SendNUIMessage({openSection = "phonemedio"}) 
--     end
--     TriggerEvent('phone:setCallState', isDialing, data.name == "" and data.number or data.name)
--     TriggerEvent("animation:phonecallstart")
--     -- print("FUCK THIS SHIT 2")
--     TriggerServerEvent('phone:callContact', exports['isPed']:isPed('cid'), data.number, true)
--   else
--     TriggerEvent("DoLongHudText","It appears you are already in a call, injured or with out a phone, please type /hangup to reset your calls.",2)
--   end
--   cb('ok')
-- end)

debugn = false
function t(trace)
  print(trace)
end

RegisterNetEvent('phone:failedCall')
AddEventHandler('phone:failedCall', function()
    t("Failed Call")
    endCall()
end)


RegisterNetEvent('phone:hangup')
AddEventHandler('phone:hangup', function()
    t("Call Hangup")
    endCall()
end)

local callid = 0

RegisterNetEvent('phone:endCalloncommand')
AddEventHandler('phone:endCalloncommand', function()
    TriggerServerEvent('phone:EndCall', mySourceID, callid, true)
    SendNUIMessage({
      openSection = 'callnotifyEnd'
    })
    SendNUIMessage({
      openSection = 'phonemedioclose'
    })
end)

RegisterNetEvent('phone:otherClientEndCall')
AddEventHandler('phone:otherClientEndCall', function()
    TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
    -- TriggerEvent("DoLongHudText", "Your call was ended!", 2)
    callid = 0
    myID = 0
    mySourceID = 0
    mySourceHoldStatus = false
    TriggerEvent('phone:setCallState', isNotInCall)
    onhold = false
    SendNUIMessage({
      openSection = 'callnotifyEnd'
    })
    SendNUIMessage({
      openSection = 'phonemedioclose'
    })
end)

-- RegisterNUICallback('btnAnswer', function()
--     -- closeGui()
--     TriggerEvent("phone:answercall")
-- end)

-- RegisterNUICallback('btnHangup', function()
--     -- closeGui()
--     TriggerEvent("phone:hangup")
--     -- print("DADA",mySourceID, callid)
--     TriggerServerEvent('phone:EndCall', mySourceID, callid, true)
--     SendNUIMessage({
--       openSection = 'callnotifyEnd'
--     })
-- end)

-- RegisterCommand('answer', function()
--   TriggerEvent("phone:answercall")
-- end)

RegisterCommand('openGui', function()
  openGui()
end)



RegisterNetEvent('phone:answercall')
AddEventHandler('phone:answercall', function()
    if callStatus == isReceivingCall and not isDead then
    answerCall()
    TriggerEvent("animation:phonecallstart")
    TriggerEvent("DoLongHudText","You have answered a call.", 1)
    callTimer = 0
  else
    TriggerEvent("DoLongHudText","You are not being called, injured, or you took too long.", 2)
  end
end)


RegisterNetEvent('phone:initiateCall')
AddEventHandler('phone:initiateCall', function(pnumber)
    TriggerEvent("DoLongHudText","You have started a call.",1)
    local dialingName = getContactName(pnumber)
    local pnumber = tonumber(pnumber)
    recentcalls[#recentcalls + 1] = { ["type"] = 2, ["number"] = pnumber, ["name"] = dialingName }
    -- print("INITIAL CALL",dialingName,pnumber)
    initiatingCall(dialingName)
    print("Calling?")
end)


RegisterNetEvent('phone:addToCall')
AddEventHandler('phone:addToCall', function(voipchannel)
  exports['varial-voice']:addPlayerToCall(tonumber(voipchannel))
  if exports['varial-newphone']:pOpen() == false then
    print("PHONE MEDIO 2") 
    SendNUIMessage({openSection = "phonemedio"}) 
  end
end)

RegisterNetEvent('phone:callFullyInitiated')
AddEventHandler('phone:callFullyInitiated', function(srcID,sentSource)
 TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
  myID = srcID
  SendNUIMessage({callisAnswer = true})
  mySourceID = sentSource
  TriggerEvent('phone:setCallState', isCallInProgress)
  callTimer = 0
  TriggerEvent("phone:callactive")
  
end)


function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end
RegisterNetEvent('phone:callactive')
AddEventHandler('phone:callactive', function()
    Citizen.Wait(100)
    local held1 = false
    local held2 = false
    while callStatus == isCallInProgress do
      local phoneString = ""
      Citizen.Wait(1)

      if onhold then
        phoneString = phoneString .. "They are on Hold | "
        if not held1 then
          TriggerEvent("DoLongHudText","You have put the caller on hold.",888)
          held1 = true
        end
      else
        phoneString = phoneString .. "Call Active | "
        if held1 then
          TriggerEvent("DoLongHudText","Your call is no longer on hold.",888)
          held1 = false
        end
      end

      if mySourceHoldStatus then
        phoneString = phoneString .. "You are on hold"
        if not held2 then
          TriggerEvent("DoLongHudText","You are on hold.",2)
          held2 = true
        end
      else
        phoneString = phoneString .. "Caller Active"
        if held2 then
          TriggerEvent("DoLongHudText","You are no longer on hold.",2)
          held2 = false
        end
      end
      drawTxt(0.97, 1.46, 1.0,1.0,0.33, phoneString, 255, 255, 255, 255)  -- INT: kmh
    end
end)



RegisterNetEvent('phone:id')
AddEventHandler('phone:id', function(sentcallid)
  callid = sentcallid
end)

RegisterNetEvent('phone:setCallState')
AddEventHandler('phone:setCallState', function(pCallState, pCallInfo)
  callStatus = pCallState
  SendNUIMessage({
    openSection = 'callState',
    callState = pCallState,
    callInfo = pCallInfo
  })
end)

RegisterNetEvent('phone:receiveCall')
AddEventHandler('phone:receiveCall', function(phoneNumber, srcID, calledNumber)
  -- print("RECEIVE CALL",phoneNumber, srcID, getContactName(calledNumber))
  if hasPhone() then
    local callFrom = getContactName(calledNumber)

    SendNUIMessage({
      openSection = 'callnotify',
      pCNumber = callFrom
    })

    if exports['varial-newphone']:pOpen() == false then 
      SendNUIMessage({openSection = "phonemedio"}) 
    end
    
    recentcalls[#recentcalls + 1] = { ["type"] = 1, ["number"] = calledNumber, ["name"] = callFrom }

    if callStatus == isNotInCall then
      myID = 0
      mySourceID = srcID
      TriggerEvent('phone:setCallState', isReceivingCall, callFrom)

      receivingCall(callFrom) -- Send contact name if exists, if not send number
    else
      TriggerEvent("DoLongHudText","You are receiving a call from " .. callFrom .. " but are currently already in one, sending busy response.",2)
    end
  end
end)
callTimer = 0
function initiatingCall(name)
  callTimer = 8
  -- TriggerEvent("DoLongHudText","You are making a call, please hold.", 1)
  -- phoneCallNotification("icall","Calling",name)
  while (callTimer > 0 and callStatus == isDialing) do
    TriggerEvent("InteractSound_CL:PlayOnOne","cellcall",0.5)
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus == isDialing or callTimer == 0 then
    endCall()
  end
end

function receivingCall(callFrom)
  callTimer = 8
  -- phoneCallNotification("rcall","Calling",callFrom)
  while (callTimer > 0 and callStatus == isReceivingCall) do
    if hasPhone() then
      Citizen.Wait(1)
      -- TriggerEvent("DoLongHudText","Call from: " .. callFrom .. " /answer | /hangup", 1)
      if phoneNotifications then
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 2.0, 'cellcall', 0.5)
      end
    end
    Citizen.Wait(2500)
    callTimer = callTimer - 1
  end
  if callStatus ~= isCallInProgress then
    endCall()
  end
end

RegisterNetEvent('varial-newphone:RemoveCall')
AddEventHandler('varial-newphone:RemoveCall', function()
    SendNUIMessage({
      openSection = 'callnotifyEnd'
    })
    SendNUIMessage({
      openSection = 'phonemedioclose'
    })
end)

function answerCall()

  if mySourceID ~= 0 then

    --NetworkSetVoiceChannel(mySourceID+1)
    --NetworkSetTalkerProximity(0.0)

    TriggerServerEvent("phone:StartCallConfirmed",mySourceID)
    TriggerEvent('phone:setCallState', isCallInProgress)
    TriggerEvent("phone:callactive")
  end
end

RegisterNetEvent('phone:removefromToko')
AddEventHandler('phone:removefromToko', function(playerRadioChannel)
  exports['varial-voice']:removePlayerFromCall()
end)

function endCall()
  TriggerEvent("InteractSound_CL:PlayOnOne","demo",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  TriggerEvent('varial-newphone:RemoveCall')
  onhold = false
  mySourceHoldStatus = false
  callid = 0
end

function endCall2()
  TriggerEvent("InteractSound_CL:PlayOnOne","payphoneend",0.1)
  if tonumber(mySourceID) ~= 0 then
    TriggerServerEvent("phone:EndCall",mySourceID,callid)
  end

  if tonumber(myID) ~= 0 then
    TriggerServerEvent("phone:EndCall",myID,callid)
  end 

  myID = 0
  mySourceID = 0
  TriggerEvent('phone:setCallState', isNotInCall)
  onhold = false
  mySourceHoldStatus = false
  callid = 0
  --closeGui()
  --[[ 
  NetworkSetTalkerProximity(1.0)
  Citizen.Wait(300)
  NetworkClearVoiceChannel()
  Citizen.Wait(300)
  NetworkSetTalkerProximity(18.0)
  ]]
end


RegisterNetEvent('phone:holdToggle')
AddEventHandler('phone:holdToggle', function()
  if myID == nil then
    myID = 0
  end
  if myID ~= 0 then
    if not onhold then
      TriggerEvent("DoShortHudText", "Call on hold.",10)
      onhold = true

      --[[  
      NetworkSetTalkerProximity(1.0)
      Citizen.Wait(300)
      NetworkClearVoiceChannel()
      Citizen.Wait(300)
      NetworkSetTalkerProximity(18.0)
      ]]

      TriggerServerEvent("OnHold:Server",mySourceID,true)
    else
      TriggerEvent("DoShortHudText", "No longer on hold.",10)
      TriggerServerEvent("OnHold:Server",mySourceID,false)
      onhold = false

      --NetworkSetVoiceChannel(myID+1)
      --NetworkSetTalkerProximity(0.0)
    end
  else

    if mySourceID ~= 0 then
      if not onhold then
        TriggerEvent("DoShortHudText", "Call on hold.",10)
        onhold = true

        --[[ 
        NetworkSetTalkerProximity(1.0)
        Citizen.Wait(300)
        NetworkClearVoiceChannel()
        Citizen.Wait(300)
        NetworkSetTalkerProximity(18.0)
        ]]

        TriggerServerEvent("OnHold:Server",mySourceID,true)
      else
        TriggerEvent("DoShortHudText", "No longer on hold.",10)
        TriggerServerEvent("OnHold:Server",mySourceID,false)
        onhold = false

        --NetworkSetVoiceChannel(mySourceID+1)
        --NetworkSetTalkerProximity(0.0)
      end
    end
  end
end)



RegisterNetEvent('OnHold:Client')
AddEventHandler('OnHold:Client', function(newHoldStatus,srcSent)
    mySourceHoldStatus = newHoldStatus
    if mySourceHoldStatus then
        local playerId = GetPlayerFromServerId(srcSent)
        MumbleSetVolumeOverride(playerId, -1.0)
        -- TriggerEvent("DoLongHudText","You just got put on hold.", 1)
    else
        if not onhold then
          local playerId = GetPlayerFromServerId(srcSent)
          MumbleSetVolumeOverride(playerId, 1.0)
        end
        -- TriggerEvent("DoLongHudText","Your caller is back on the line.", 1)
    end
end)
----------


curNotifications = {}
casinoNotification = {}

RegisterNetEvent('phone:casino_paid')
AddEventHandler('phone:casino_paid', function(message)
  if exports['varial-newphone']:pOpen() == false then 
    SendNUIMessage({openSection = "emailnotify", pEHandle = 'Payment Received.', pEMessages = message})
    SendNUIMessage({openSection = "phonemedio", timeout = "5200", pOpen = exports['varial-newphone']:pOpen()}) 
  end
  casinoNotification[#casinoNotification+1] = { ["name"] = name, ["message"] = message, ['time'] = time }
end)

RegisterNetEvent('phone:addnotification')
AddEventHandler('phone:addnotification', function(name, message)
  TriggerEvent('addUnreadEmail')
    -- SendNUIMessage({openSection = "emailnotify", pEHandle = 'Email Received.', pEMessages = message})
    if phasPhone() then
      phoneNotification("email",message,"Email Received")
    end
    curNotifications[#curNotifications+1] = { ["name"] = name, ["message"] = message, ['time'] = time }
end)

RegisterNetEvent('YellowPageArray')
AddEventHandler('YellowPageArray', function(pass)
    local notdecoded = json.encode(pass)
    YellowPages = notdecoded

    YellowPageArray = pass
end)


function createGeneralAreaBlip(alertX, alertY, alertZ)
  local genX = alertX + math.random(-50, 50)
  local genY = alertY + math.random(-50, 50)
  local alertBlip = AddBlipForRadius(genX,genY,alertZ,75.0) 
  SetBlipColour(alertBlip,1)
  SetBlipAlpha(alertBlip,80)
  SetBlipSprite(alertBlip,9)
  Wait(60000)
  RemoveBlip(alertBlip)
end

local lastTime = 0;
RegisterNetEvent('phone:triggerPager')
AddEventHandler('phone:triggerPager', function()
  local job = exports["isPed"]:isPed("myjob")
  if job == "doctor" or job == "ems" then
    local currentTime = GetGameTimer()
    if lastTime == 0 or lastTime + (5 * 60 * 1000) < currentTime then
      TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'pager', 0.4)
      SendNUIMessage({
        openSection = "newpager"
      })
      lastTime = currentTime
    end
  end
end)


local customGPSlocations = {
  [1] = { ["x"] = 484.77066040039, ["y"] = -77.643089294434, ["z"] = 77.600166320801, ["info"] = "Garage A"},
  [2] = { ["x"] = -331.96115112305, ["y"] = -781.52337646484, ["z"] = 33.964477539063,  ["info"] = "Garage B"},
  [3] = { ["x"] = -451.37295532227, ["y"] = -794.06591796875, ["z"] = 30.543809890747, ["info"] = "Garage C"},
  [4] = { ["x"] = 399.51190185547, ["y"] = -1346.2742919922, ["z"] = 31.121940612793, ["info"] = "Garage D"},
  [5] = { ["x"] = 598.77319335938, ["y"] = 90.707237243652, ["z"] = 92.829048156738, ["info"] = "Garage E"},
  [6] = { ["x"] = 641.53442382813, ["y"] = 205.42562866211, ["z"] = 97.186958312988, ["info"] = "Garage F"},
  [7] = { ["x"] = 82.359413146973, ["y"] = 6418.9575195313, ["z"] = 31.479639053345, ["info"] = "Garage G"},
  [8] = { ["x"] = -794.578125, ["y"] = -2020.8499755859, ["z"] = 8.9431390762329, ["info"] = "Garage H"},
  [9] = { ["x"] = -669.15631103516, ["y"] = -2001.7552490234, ["z"] = 7.5395741462708, ["info"] = "Garage I"},
  [10] = { ["x"] = -606.86322021484, ["y"] = -2236.7624511719, ["z"] = 6.0779848098755, ["info"] = "Garage J"},
  [11] = { ["x"] = -166.60482788086, ["y"] = -2143.9333496094, ["z"] = 16.839847564697, ["info"] = "Garage K"},
  [12] = { ["x"] = -38.922565460205, ["y"] = -2097.2663574219, ["z"] = 16.704851150513, ["info"] = "Garage L"},
  [13] = { ["x"] = -70.179389953613, ["y"] = -2004.4139404297, ["z"] = 18.016941070557, ["info"] = "Garage M"},
  [14] = { ["x"] = -195.1579, ["y"] = -1172.7583, ["z"] = 23.0440, ["info"] = "Garage Impound Lot"},
  [15] = { ["x"] = 364.27685546875, ["y"] = 297.84490966797, ["z"] = 103.49515533447, ["info"] = "Garage O"},
  [16] = { ["x"] = -338.31619262695, ["y"] = 266.79782104492, ["z"] = 85.741966247559, ["info"] = "Garage P"},
  [17] = { ["x"] = 273.66683959961, ["y"] = -343.83737182617, ["z"] = 44.919876098633, ["info"] = "Garage Q"},
  [18] = { ["x"] = 66.215492248535, ["y"] = 13.700443267822, ["z"] = 69.047248840332, ["info"] = "Garage R"},
  [19] = { ["x"] = 3.3330917358398, ["y"] = -1680.7877197266, ["z"] = 29.170293807983, ["info"] = "Garage Imports"},
  [20] = { ["x"] = 286.67013549805, ["y"] = 79.613700866699, ["z"] = 94.362899780273, ["info"] = "Garage S"},
  [21] = { ["x"] = 211.79, ["y"] = -808.38, ["z"] = 30.833, ["info"] = "Garage T"},
  [22] = { ["x"] = 447.65, ["y"] = -1021.23, ["z"] = 28.45, ["info"] = "Garage Police Department"},
  [23] = { ["x"] = 447.65, ["y"] = -1021.23, ["z"] = 28.45, ["info"] = "Garage Paleto PD"},
  [24] = { ["x"] = -25.59, ["y"] = -720.86, ["z"] = 32.22, ["info"] = "Garage House"},
}

local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,houses,rented)

  

  SendNUIMessage({openSection = "GPS"})

  if loadedGPS then

    return

  end

  for i = 1, #customGPSlocations do

    SendNUIMessage({openSection = "AddGPSLocation", info = customGPSlocations[i]["info"], house_id = i, house_type = 69})

    Citizen.Wait(1)

  end



  loadedGPS = true

end)



RegisterNetEvent('GPSLocations')

AddEventHandler('GPSLocations', function()

	if GPSblip ~= nil then

		RemoveBlip(GPSblip)

		GPSblip = nil

	end	

	TriggerEvent("GPSActivated",false)

	TriggerEvent("openGPS",robberycoordsMansions,robberycoords,rentedOffices)

end)



RegisterNUICallback('loadUserGPS', function(data)

     TriggerEvent("GPS:SetRoute",data.house_id,data.house_type)

end)



-- RegisterNUICallback('btnCamera', function()

--   SetNuiFocus(true,true)

-- end)



local loadedGPS = false

RegisterNetEvent('openGPS')

AddEventHandler('openGPS', function(mansions,house,rented)

  -- THIS IS FUCKING PEPEGA TOO.....





  if loadedGPS then

    SendNUIMessage({openSection = "GPS"})

    return

  end

  local mapLocationsObject = {

    custom = { info = customGPSlocations, houseType = 69 },

    mansions = { info = mansions, houseType = 2 },

    houses = { info = house, houseType = 1 },

    rented = { info = rented, houseType = 3 }

  }

  SendNUIMessage({openSection = "GPS", locations = mapLocationsObject })

  loadedGPS = true

end)



RegisterNUICallback('loadGPS', function()

  TriggerEvent("GPSLocations")

end)

RegisterNUICallback('pinger', function()

  SendNUIMessage({openSection = "pinger"})
end)


RegisterNUICallback('btnCamera', function()
  SetNuiFocus(false,false)
  SetNuiFocus(true,true)
end)

RegisterNUICallback('notifications', function()

    lstnotifications = {}

    for i = 1, #curNotifications do

        local message2 = {
          id = tonumber(i),
          name = curNotifications[tonumber(i)].name,
          message = curNotifications[tonumber(i)].message
        }

        lstnotifications[#lstnotifications+1]= message2
    end

    
  SendNUIMessage({openSection = "notifications", list = lstnotifications})

end)


RegisterNUICallback('btnPagerToggle', function()
  TriggerEvent("togglePager")
end)

RegisterNetEvent("house:returnKeys")
AddEventHandler("house:returnKeys", function(pSharedKeys)
  SendNUIMessage({
    openSection = "manageKeys",
    sharedKeys = pSharedKeys
  })
end)


RegisterNetEvent('phone:deleteSMS')
AddEventHandler('phone:deleteSMS', function(id)
  table.remove( lstMsgs, tablefindKeyVal(lstMsgs, 'id', tonumber(id)))
  phoneMsg("Message Removed!")
end)

function getContactName(number)
  if (#lstContacts ~= 0) then
    for k,v in pairs(lstContacts) do
      -- print(v)
      if v ~= nil then
        if (v.number ~= nil and tonumber(v.number) == tonumber(number)) then
          return v.name
        end
      end
    end
  end

  return number
end

RegisterNetEvent('varial-spawn:confirm_spawned')
AddEventHandler('varial-spawn:confirm_spawned', function()
  serverSpawn = true
end)

Citizen.CreateThread(function()
  while true do
    Wait(1)
    if serverSpawn then
      TriggerServerEvent('phone:getContacts')
      serverSpawn = false
    end
  end
end)
-- Contact Events
RegisterNetEvent('phone:loadContacts')
AddEventHandler('phone:loadContacts', function(contacts)
  lstContacts = {}

  if (#contacts ~= 0) then
    for k,v in pairs(contacts) do
      if v ~= nil then
        local contact = {
        }
        if activeNumbersClient['active' .. tonumber(v.number)] then
        
          contact = {
            name = v.name,
            number = v.number,
            activated = 1
          }
        else
    
          contact = {
            name = v.name,
            number = v.number,
            activated = 0
          }
        end
        lstContacts[#lstContacts+1]= contact

        SendNUIMessage({
          newContact = true,
          contact = contact,
        })
      end
    end
  else
       SendNUIMessage({
        emptyContacts = true
      })
  end
end)

RegisterNetEvent('phone:addContact')
AddEventHandler('phone:addContact', function(name, number)
  if(name ~= nil and number ~= nil) then
    number = tonumber(number)
    TriggerServerEvent('phone:addContact', name, number)
  else
     phoneMsg("You must fill in a name and number!")
  end
end)

RegisterNetEvent('phone:newContact')
AddEventHandler('phone:newContact', function(name, number)
  local contact = {
      name = name,
      number = number
  }
  lstContacts[#lstContacts+1]= contact

  SendNUIMessage({
    newContact = true,
    contact = contact,
  })
  phoneMsg("Contact Saved!")
  TriggerServerEvent('phone:getContacts', exports['isPed']:isPed('cid'))
end)

RegisterNetEvent('phone:deleteContact')
AddEventHandler('phone:deleteContact', function(name, number)

  local contact = {
      name = name,
      number = number
  }

  table.remove( lstContacts, tablefind(lstContacts, contact))
  
  SendNUIMessage({
    removeContact = true,
    contact = contact,
  })
  TriggerEvent('resetPhone')

end)

RegisterNUICallback('removeContact', function(data, cb)
  TriggerServerEvent('deleteContact', data.name, data.number)
  cb('ok')
end)

function tablefind(tab,el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end

function tablefindKeyVal(tab,key,val)
  for index, value in pairs(tab) do
    if value ~= nil  and value[key] ~= nil and value[key] == val then
      return index
    end
  end
end


RegisterNetEvent('resetPhone')
AddEventHandler('resetPhone', function()
     SendNUIMessage({
      emptyContacts = true
    })

end)

local weather = ""
RegisterNetEvent("kWeatherSync")
AddEventHandler("kWeatherSync", function(pWeather)
  weather = pWeather
end)

RegisterNUICallback('getWeather', function(data, cb)
  SendNUIMessage({openSection = "weather", weather = weather})
  cb("ok")
end)

function MyPlayerId()
  for i=0,256 do
    if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == PlayerPedId()) then return i end
  end
  return nil
end



function Voip(intPlayer, boolSend)
end

RegisterNetEvent('sendMessagePhoneN')
AddEventHandler('sendMessagePhoneN', function(phonenumberlol)
  TriggerServerEvent('message:tome', phonenumberlol)

  local closestPlayer, closestDistance = GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 5.0 then
    TriggerServerEvent('message:inDistanceZone', GetPlayerServerId(closestPlayer), phonenumberlol)
  else    
  end
end)
function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local closestPed = -1
	local ply = PlayerPedId()
	local plyCoords = GetEntityCoords(ply, 0)
	if not IsPedInAnyVehicle(PlayerPedId(), false) then

		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			if(target ~= ply) then
				local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
				local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
				if(closestDistance == -1 or closestDistance > distance) then
					closestPlayer = value
					closestPed = target
					closestDistance = distance
				end
			end
		end
		return closestPlayer, closestDistance, closestPed
	end
end

Citizen.CreateThread(function()
  while true do
      if nearWifiZone then
        Wait(1000)
          SendNUIMessage({wifiZone = nearWifiZone, materials = materials})
      else
        Wait(1000)
        SendNUIMessage({wifiZone = nearWifiZone})
      end
  end
end)

function getBuying()
  return materials
end
exports('getBuying', getBuying)

connectedWifi = false
RegisterNUICallback('connectWifi', function(data, cb)
  connectedWifi = true
    SendNUIMessage({
      darkMarket = true
    })
end)

AddEventHandler("varial-polyzone:enter", function(zone, data)
  if zone == "wifi1" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi2" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi3" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi4" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi5" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi6" then
    nearWifiZone = true
    materials = zone
  elseif zone == "wifi7" then
    nearWifiZone = true
    materials = zone
  end
end)

AddEventHandler("varial-polyzone:exit", function(zone)
  if zone == "wifi1" or zone == "wifi2" or zone == "wifi3" or zone == "wifi4" or zone == "wifi5" or zone == "wifi6" or zone == "wifi7" then
     nearWifiZone = false
     connectedWifi = false
     SendNUIMessage({darkMarket = false})
  end
end)

RegisterNUICallback('jobcenter-setgps', function(data)

  if data.item == "sanitation" then
    SetNewWaypoint(-336.21273803711, -1533.8173828125)
    TriggerEvent("DoLongHudText", "Setting GPS")
  elseif data.item == "fishing" then
    SetNewWaypoint(1301.1343994141,4319.1103515625)
    TriggerEvent("DoLongHudText", "Setting GPS")
  elseif data.item == "poultry" then
    SetNewWaypoint(2387.9135742188,5046.1362304688)
    TriggerEvent("DoLongHudText", "Setting GPS")
  elseif data.item == "hunting" then
    SetNewWaypoint(-692.23541259766, 5833.5258789063)
    TriggerEvent("DoLongHudText", "Setting GPS")
  elseif data.item == "mining" then
    SetNewWaypoint(-605.2197265625, 2110.3420410156)
    TriggerEvent("DoLongHudText", "Setting GPS")
  end
  
  if data.item == "oxy" then
    TriggerServerEvent("varial-deliveries:JobCenter")
  elseif data.item == "chopshop" then
    TriggerServerEvent("varial-chopshop:JobCenter")
  end

end)

-- RegisterCommand('phone', function(source,args)
--   print('PHONE')
--   SendNUIMessage({
--     openSection = "android"
--   })
-- end)

-- RegisterCommand('house', function()
--   local isComplete, propertyID, dist, zone = Housing.func.findClosestProperty()
--   print("HOUSING",isComplete, propertyID, dist, zone)
-- end)

RegisterNUICallback('checkHouse', function()
  TriggerEvent('varial-housing:phone:check')
end)

RegisterNUICallback('editHouse', function()
  print("EDITING")
  TriggerEvent('varial-housing:phone:check', "edit")
end)

RegisterNUICallback('sellsHouse', function()
  print("EDITING")
  TriggerEvent('varial-housing:phone:check', "edit")
end)

AddEventHandler('varial-newphone:sentHouse', function(hasPrice,id,street,price,category)
  print("SENT HOUSE",isRealEstateAgent(),id,street,price)
  SendNUIMessage({
    openSection = "nearHouse",
    realtor = isRealEstateAgent(),
    hasPrice = hasPrice,
    id = id,
    street = street,
    price = price,
    category = category,
  })
end)

AddEventHandler('varial-newphone:editingHouse', function(id,street,price)
  print("EDITING HERE")
  SendNUIMessage({
    openSection = "sellsHouse",
    id = id,
    street = street,
    price = price,
  })
end)

RegisterNUICallback('purchaseHouse', function(data)
  print('DATa',data.name,data.price)
  if rentEnabled then
     print("can purchase")
    --  TriggerEvent('varial-housing:buyed')
    --  action = "varial-housing:buyed",
    --         key = { 
    --             propertyId = pPropertyId, 
    --             total = total, 
    --             tax = taxPercent, 
    --             seller = pSeller
    --         },
     return
  end
  TriggerEvent('DoLongHudText','Purchasing is not enabled for this house',2)

end)

AddEventHandler('varial-newphone:noProperty', function()
  SendNUIMessage({
    openSection = "noProperty"
  })
end)

RegisterNUICallback('editHousePrice', function(data)
  TriggerServerEvent('varial-housing:editPrice', data.hid,data.price)
end)

AddEventHandler('varial-newphone:EnableSellRent', function()
    exports['varial-ui']:openApplication('textbox', {
    callbackUrl = 'varial-newphone:SellRentEnable',
    -- params = {key = pParams.propertyId},
    key = 1,
    items = {
        {
          icon = "fa-id-card",
          label = "Paypal (Enabled Sell/Rent)",
          name = "sell",
        },
    },
    show = true
  })
end)

RegisterUICallback("varial-newphone:SellRentEnable", function(data, cb)
  -- print('THIS IS ENABLED RENT/SALE FOR PLAYER', data[1].value,json.encode(data))
  TriggerServerEvent('varial-housing:rent_activate_sv', data[1].value)
  exports["varial-ui"]:hideContextMenu()
  cb({ data = {}, meta = { ok = true, message = '' } })
end)

function enabledRentSelling()
  if rentEnabled then
    Citizen.SetTimeout(30000, function()
      rentEnabled = false
    end)
  end
end