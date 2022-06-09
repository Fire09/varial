local spawnedKeys = {}
local isDead = false
local allPeds = {}
local inArea = false

RegisterNetEvent('pd:deathcheck')
AddEventHandler('pd:deathcheck', function()
  isDead = not isDead
  if isDead then
    spawnedKeys = {}
    for _, ped in pairs(allPeds) do
      if DoesEntityExist(ped) then
        DeleteEntity(ped)
      end
    end
    allPeds = {}
    if not inArea then return end
    DoScreenFadeOut(4000)
    Wait(6000)
    ClearPedTasksImmediately(PlayerPedId())
    SetEntityCoords(PlayerPedId(), vector3(-1131.62, 5410.5, 2.89))
    Wait(2000)
    DoScreenFadeIn(2000)
    Wait(2000)
    TriggerEvent("chatMessage", "Military", 1, "This is a controlled military zone, do not attempt to enter.", "feed", false, {{
      i18n = { "This is a controlled military zone, do not attempt to enter." },
    }})
  end
end)

local function cleanUp()
  if not inArea then return end
  inArea = false
  spawnedKeys = {}
  for _, ped in pairs(allPeds) do
    if DoesEntityExist(ped) then
      DeleteEntity(ped)
    end
  end
  allPeds = {}
end

local function spawnPedToDestroy(k, coords)
  if spawnedKeys[k] then
    local ped = spawnedKeys[k]
    TaskShootAtEntity(ped, PlayerPedId(), 10000, `FIRING_PATTERN_FULL_AUTO`)
    return
  end
  Citizen.CreateThread(function()
    RequestModel(`s_m_m_marine_01`)
    while not HasModelLoaded(`s_m_m_marine_01`) do
      Wait(0)
    end
    local ped = CreatePed(4, `s_m_m_marine_01`, coords, 0, 1)
    allPeds[#allPeds + 1] = ped
    spawnedKeys[k] = ped
    while not DoesEntityExist(ped) do
      Wait(0)
    end
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    if math.random() < 0.2 then
      GiveWeaponToPed(ped, -1312131151, 9999, false, true)
      SetCurrentPedWeapon(ped, -1312131151, true)
      SetPedAmmo(ped, -1312131151, 9999)
      SetAmmoInClip(ped, -1312131151, 9999)
    else
      GiveWeaponToPed(ped, 1192676223, 9999, false, true)
      SetCurrentPedWeapon(ped, 1192676223, true)
      SetPedAmmo(ped, 1192676223, 9999)
      SetAmmoInClip(ped, 1192676223, 9999)
    end
    Wait(0)
    TaskShootAtEntity(ped, PlayerPedId(), 10000, `FIRING_PATTERN_FULL_AUTO`)
  end)
end

Citizen.CreateThread(function()
  while true do
    Wait(2500)
    if not isDead then
      local coords = GetEntityCoords(PlayerPedId())
      coords = vector4(coords.x, coords.y, coords.z, 0.0)
      local spawnedCount = 0
      for k, spawnCoords in pairs(SPAWN_COORDS) do
        if #(coords - spawnCoords) < 150 then
          spawnedCount = spawnedCount + 1
          spawnPedToDestroy(k, spawnCoords)
        end
      end
      if spawnedCount > 0 then
        inArea = true
      else
        cleanUp()
      end
    end
  end
end)
