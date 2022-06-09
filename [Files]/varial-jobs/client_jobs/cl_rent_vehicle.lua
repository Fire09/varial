Config = Config or {}

Config.RentalShit = {
    { x= 110.59, y=-1090.72, z= 29.31, name = "Manel", heading = 17.39, model = "a_m_y_smartcaspat_01" },
}

Citizen.CreateThread(function()
  for _,v in pairs(Config.RentalShit) do
      loadmodel(v.model)
      loaddict("mini@strip_club@idles@bouncer@base")

      manel =  CreatePed(1, v.model, v.x, v.y, v.z-1, v.heading, false, true)
      FreezeEntityPosition(manel, true)
      SetEntityInvincible(manel, true)
      SetBlockingOfNonTemporaryEvents(manel, true)
      TaskPlayAnim(manel,"mini@strip_club@idles@bouncer@base", "base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)

function loadmodel(model)
  while not HasModelLoaded(model) do
      RequestModel(model)
      Wait(10)
  end
end

function loaddict(dict)
  while not HasAnimDictLoaded(dict) do
      RequestAnimDict(dict)
      Wait(10)
  end
end

RegisterNetEvent("varial-rentals:vehicles")
AddEventHandler("varial-rentals:vehicles", function()

  TriggerEvent('varial-context:sendMenu', {
      {
          id = 1,
          header = "Rent a vehicle",
          txt = "",
          params = {
              event = ""
          }
      },
      {
        id = 2, 
        header = "Rent Vehicle",
        txt = "Bison | $500",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916463231780941845/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "bison",
          }
        }
      },
      {
        id = 4, 
        header = "Rent Vehicle",
        txt = "Futo | $450",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916463826881359882/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "futo",
          }
        }
      },
      {
        id = 5, 
        header = "Rent Vehicle",
        txt = "Buffalo | $750",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916463990090137620/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "buffalo",
          }
        }
      },
      {
        id = 6, 
        header = "Rent Vehicle",
        txt = "Jackal | $625",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916464156251684915/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "jackal",
          }
        }
      },
      {
        id = 7,
        header = "Rent a vehicle",
        txt = "Sultan | $1000",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916464156251684915/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "sultan",
          }
        }
    },
      {
        id = 8, 
        header = "Rent Vehicle",
        txt = "Youga | $400",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916464299025772584/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "youga",
          }
        }
      },
      {
        id = 9, 
        header = "Rent Vehicle",
        txt = "Faggio | $350",
        url = "https://cdn.discordapp.com/attachments/901123512503267349/916464431955857438/unknown.png",
        params = {
          event = "varial-rentals:attemptvehiclespawn",
          args = {
              vehicle = "faggio",
          }
        }
      }
    })

end)


local vehicleList = {
  { name = "Bison", model = "bison", price = 500 },
  { name = "Futo", model = "futo", price = 450 },
  { name = "Buffalo", model = "buffalo", price = 750 },
  { name = "Jackal", model = "jackal", price = 625 },
  { name = "Sultan", model = "sultan", price = 1000 },
  { name = "Youga", model = "youga", price = 400 },
  { name = "Faggio", model = "faggio", price = 350 },
}

RegisterNetEvent("varial-rentals:attemptvehiclespawn")
AddEventHandler("varial-rentals:attemptvehiclespawn", function(data)
  local vehicle = data.vehicle
  if IsAnyVehicleNearPoint(117.84, -1079.95, 29.23, 3.0) then
    TriggerEvent("DoLongHudText", "There's a vehicle in the way!", 2)
    return
  else
    TriggerServerEvent("varial-rentals:attemptPurchase",vehicle)
  end 
end)

RegisterNetEvent("varial-rentals:attemptvehiclespawnfail")
AddEventHandler("varial-rentals:attemptvehiclespawnfail", function()
    TriggerEvent("DoLongHudText", "Not enough money!", 2)
end)

RegisterNetEvent("varial-rentals:vehiclespawn")
AddEventHandler("varial-rentals:vehiclespawn", function(data, cb)

 -- print(data)

  local model = data

  RequestModel(model)
  while not HasModelLoaded(model) do
      Citizen.Wait(0)
  end
  SetModelAsNoLongerNeeded(model)

  local rentalVehicleEvanRP = CreateVehicle(model, vector4(117.84,-1079.95,29.23,355.92), true, false)

  Citizen.Wait(100)

  SetEntityAsMissionEntity(rentalVehicleEvanRP, true, true)
  SetModelAsNoLongerNeeded(model)
  SetVehicleOnGroundProperly(rentalVehicleEvanRP)

  --TaskWarpPedIntoVehicle(PlayerPedId(), rentalVehicleEvanRP, -1)
  SetVehicleNumberPlateText(rentalVehicleEvanRP, "Rental"..tostring(math.random(1000, 9999)))
  TriggerEvent("keys:addNew",rentalVehicleEvanRP,plate)

  local plateText = GetVehicleNumberPlateText(rentalVehicleEvanRP)
  local player = exports["varial-base"]:getModule("LocalPlayer")
  
  local information = {
    ["Plate"] = plateText,
    ["Vehicle"] = data,
    ["Rentee"] = ""..player.character.first_name.." "..player.character.last_name,
  }
  
  TriggerEvent("player:receiveItem", "rentalpapers", 1, true, information)


  local timeout = 10
  while not NetworkDoesEntityExistWithNetworkId(rentalVehicleEvanRP) and timeout > 0 do
      timeout = timeout - 1
      Wait(1000)
  end

end)