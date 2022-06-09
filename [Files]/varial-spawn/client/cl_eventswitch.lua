function Login.playerLoaded() end

function Login.characterLoaded()
  -- Main events leave alone 
  TriggerEvent("varial-base:playerSpawned")
  TriggerEvent("playerSpawned")
  TriggerServerEvent('character:loadspawns')
  -- Main events leave alone 

  TriggerEvent("Relog")

  -- Everything that should trigger on character load 
  TriggerServerEvent('checkTypes')
  TriggerServerEvent('isVip')
  TriggerEvent('rehab:changeCharacter')
  TriggerEvent("resetinhouse")
  TriggerEvent("fx:clear")
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
  TriggerServerEvent("requestOffices")
  TriggerServerEvent('varial-base:addLicenses')
  Wait(500)
  TriggerServerEvent('commands:player:login')
  TriggerServerEvent("police:getAnimData")
  TriggerServerEvent("police:getEmoteData")
  TriggerServerEvent("police:SetMeta")
  TriggerServerEvent("retreive:licenes:server")
  TriggerServerEvent("clothing:checkIfNew")
  -- Anything that might need to wait for the client to get information, do it here.
  Wait(3000)
  TriggerServerEvent("bones:server:requestServer")
  TriggerEvent("apart:GetItems")

  Wait(4000)
  TriggerServerEvent('distillery:getDistilleryLocation')
  TriggerServerEvent("retreive:jail",exports["isPed"]:isPed("cid"))	
  TriggerServerEvent("bank:getLogs")
  TriggerEvent('varial-hud:EnableHud', true)
  exports.spawnmanager:setAutoSpawn(false)
  TriggerServerEvent('varial-phone:grabWallpaper')
  TriggerServerEvent('banking-loaded-in')
  TriggerServerEvent('varial-base:updatedphoneLicenses')
  TriggerServerEvent('getallplayers')
  TriggerEvent("varial-base:PolyZoneUpdate")
  TriggerServerEvent('varial-scoreboard:AddPlayer')
  TriggerServerEvent("server:currentpasses")
  TriggerServerEvent('dispatch:setcallsign')
  TriggerServerEvent('varial-base:addLicenses')
end

function Login.characterSpawned()

  isNear = false
  TriggerServerEvent('varial-base:sv:player_control')
  TriggerServerEvent('varial-base:sv:player_settings')

  TriggerServerEvent("TokoVoip:clientHasSelecterCharacter")
  TriggerEvent("spawning", false)
  TriggerEvent("attachWeapons")
  TriggerEvent("tokovoip:onPlayerLoggedIn", true)


  TriggerServerEvent("request-dropped-items")
  TriggerServerEvent("server-request-update", exports["isPed"]:isPed("cid"))

  if Spawn.isNew then
      Wait(1000)
      local src = GetPlayerServerId(PlayerId())
      TriggerServerEvent("reviveGranted", src)
      TriggerEvent("Hospital:HealInjuries", src, true)
      TriggerServerEvent("ems:healplayer", src)
      TriggerEvent("heal", src)
      TriggerEvent("player:receiveItem", "present", 1)
      TriggerEvent("inventory:removeItem","present", 1)
      TriggerEvent("status:needs:restore", src)
  end

  SetPedMaxHealth(PlayerPedId(), 200)
  --SetPlayerMaxArmour(PlayerId(), 100) -- This is setting players armor on relog??
  Spawn.isNew = false
  exports.spawnmanager:setAutoSpawn(false)
  runGameplay()
end
RegisterNetEvent("varial-spawn:characterSpawned");
AddEventHandler("varial-spawn:characterSpawned", Login.characterSpawned);
