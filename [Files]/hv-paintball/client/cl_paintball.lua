local inArena = false

Citizen.CreateThread(function()
  exports["varial-polyzone"]:AddBoxZone("paintball_arena", vector3(2341.91, 2558.8, 46.66), 150, 120, {
    name="paintball_arena",
    heading=0,
    debugPoly=false,
    minZ=43.06,
    maxZ=73.06
  }) 
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
  if name == "paintball_arena" then
    inArena = true
  end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "paintball_arena" then
        inArena = false
        removeGuns()
    end
end)

RegisterNetEvent('evan:paintball:gun')
AddEventHandler('evan:paintball:gun', function()
  if not exports["varial-inventory"]:hasEnoughOfItem("2285322324",1,false) then
    TriggerEvent("player:receiveItem","2285322324", 1, true)
    TriggerEvent("DoLongHudText", "Match Started, Get In The Arena", 2) 
  else 
    TriggerEvent("DoLongHudText", "You Are Already In a Match", "2")
  end 
end)

RegisterNetEvent('evan:paintball:ammo')
AddEventHandler('evan:paintball:ammo', function()
  if not exports["varial-inventory"]:hasEnoughOfItem("paintballs",5,false) then
    TriggerEvent("player:receiveItem","paintballs", 5)
  else 
    TriggerEvent("DoLongHudText", "You Already Have 5 Bullets", "2")
  end 
end)

function removeGuns()
  local qty = exports["varial-inventory"]:getQuantity("2285322324")
  if qty and qty > 0 then
    TriggerEvent("inventory:removeItem", "2285322324", qty)
    SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
  end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if inArena == false then
            removeGuns()
        end
    end
end)

RegisterNetEvent("varial-paintball:menu")
AddEventHandler("varial-paintball:menu", function()
	TriggerEvent('varial-context:sendMenu', {
		{
			id = "1",
			header = "Grab PaintBall Gun",
			txt = "PaintBall Gun | +1 Gun",
			params = {
				event = "evan:paintball:gun",
			}
		},
    {
			id = "2",
			header = "Grab PaintBalls",
			txt = "Gun ammunition | +5 Ammo",
			params = {
				event = "evan:paintball:ammo",
			}
		},
		{
			id = "3",
			header = "Close Menu",
			txt = "Exit the menu!",
			params = {
				event = "",
			}
		},
	})
end)

-- CUSTOM ARENA
Enabled = {
  ['Playground_1'] = true,
  ['Terrain_1'] = true,
  ['Vegetation_1'] = true,
}

IPLs = {
  Playground_1 = {
      "gabz_npa_hyperpipe",
  },
  Terrain_1 = {
      "gabz_npa_terrain1",
  },
  Vegetation_1 = {
      "gabz_npa_fern_proc",
      "gabz_npa_grass_mix_proc",
      "gabz_npa_grass_proc",
      "gabz_npa_grass_sm_proc",
      "gabz_npa_grass_xs_proc",
      "gabz_npa_log_proc",
      "gabz_npa_stones_proc",
      "gabz_npa_trees"
  },
}

-- do not touch
Citizen.CreateThread(function()
  Citizen.Wait(60000)
  for category, iplName in pairs(IPLs) do
    if Enabled[category] then
      for k,v in pairs(iplName) do
        RequestIpl(v)
      end
    end
  end
end)