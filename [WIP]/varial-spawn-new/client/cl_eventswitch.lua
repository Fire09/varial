function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("varial-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  TriggerEvent("varial-base:initialSpawnModelLoaded")
  -- Main events leave alone 

  TriggerEvent("Relog")

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent('rehab:changeCharacter')
  TriggerEvent("resetinhouse")
  TriggerEvent("fx:clear")
  TriggerServerEvent('tattoos:retrieve') -- HEY THIS DOESN'T WORK RIGHT.
  TriggerServerEvent("raid_clothes:retrieve_tats")
  TriggerServerEvent('Blemishes:retrieve')
  TriggerServerEvent("currentconvictions")
  TriggerServerEvent("GarageData")
  TriggerServerEvent("Evidence:checkDna")
  TriggerEvent("banking:viewBalance")
  TriggerServerEvent("police:getLicensesCiv")
  TriggerServerEvent('varial-doors:requestlatest')
  TriggerServerEvent("item:UpdateItemWeight")
  TriggerServerEvent("varial-weapons:getAmmo")
  TriggerServerEvent("ReturnHouseKeys")
  TriggerServerEvent('varial-scoreboard:AddPlayer')
  TriggerServerEvent("requestOffices")
  Wait(500)
  --TriggerServerEvent("police:getAnimData")
  --TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  --TriggerServerEvent('NPX-scoreboard:AddPlayer')
  TriggerEvent("varial-base:PolyZoneUpdate")
  TriggerServerEvent("retreive:licenes:server")
  -- Anything that might need to wait for the client to get information, do it here.
  Wait(3000)
  TriggerServerEvent("bones:server:requestServer")
  TriggerEvent("apart:GetItems")

  Wait(4000)
  TriggerServerEvent('distillery:getDistilleryLocation')
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('varial-hud:EnableHud', true)
  TriggerServerEvent("SpawnEventsServer")
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('varial-base:sv:player_control')
  TriggerServerEvent('varial-base:sv:player_settings')

  TriggerServerEvent("TokoVoip:clientHasSelecterCharacter")
  TriggerEvent("spawning", false)
  TriggerEvent("attachWeapons")
  TriggerEvent("tokovoip:onPlayerLoggedIn", true)

  TriggerEvent("x-ui:initHud")

  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))
  --TriggerServerEvent("stocks:retrieveclientstocks")

  if Spawn.isNew then
      Wait(1000)
      if not exports["varial-inventory"]:hasEnoughOfItem("mobilephone", 1, false) then
          TriggerEvent("player:receiveItem", "mobilephone", 1)
      end
      if not exports["varial-inventory"]:hasEnoughOfItem("idcard", 1, false) then
          TriggerEvent("player:receiveItem", "idcard", 1)
      end

      TriggerServerEvent('varial-base:addLicenses')

      -- commands to make sure player is alive and full food/water/health/no injuries
      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("status:needs:restore", src)

      TriggerServerEvent("varial-spawn-new:newPlayerFullySpawned")
  end
  SetPedMaxHealth(PlayerPedId(), 200)
  --SetPlayerMaxArmour(PlayerId(), 100) -- This is setting players armor on relog??
  Spawn.isNew = false
  TriggerServerEvent('varial-phone:grabWallpaper')
  TriggerServerEvent('banking-loaded-in')
  TriggerServerEvent('varial-base:updatedphoneLicenses')
  TriggerServerEvent('getallplayers')
  runGameplay()
end
RegisterNetEvent("varial-spawn-new:characterSpawned");
AddEventHandler("varial-spawn-new:characterSpawned", Login.characterSpawned);


