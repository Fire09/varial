local nearBuy = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("police_buy", vector3(464.53, -1012.86, 28.43), 1.6, 1.45, {
		name="police_buy",
		heading=0,
    }) 
end)

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("Swat_buy", vector3(464.57, -1020.73, 28.10), 1.6, 1.45, {
		name="Swat_buy",
		heading=0,
    }) 
end)

RegisterNetEvent('varial-polyzone2:enter')
AddEventHandler('varial-polyzone2:enter', function(name)
    local job = exports["isPed"]:isPed("myJob")
    if name == "Swat_buy" then
        exports['varial-interaction']:showInteraction('[E] Purchase Swat Vehicle')
		if job == 'swat' then
            nearBuy = true
            TriggerEvent("varial-garages:openBuyMenuSWAT")
        else
            TriggerEvent('DoLongHudText', "You Are Not SWAT!", 2)
        end
    end
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "police_buy" then
		local job = exports["isPed"]:isPed("myJob")
		if job == 'police' or job == 'state' or job == 'sheriff' then
            nearBuy = true
            AtPoliceBuy()
			exports['varial-interaction']:showInteraction('[E] Purchase Vehicle')
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "police_buy" then
        nearBuy = false
    end
    exports['varial-interaction']:hideInteraction()
end)


RegisterNetEvent('varial-polyzone2:exit')
AddEventHandler('varial-polyzone2:exit', function(name)
    if name == "swat_buy" then
        nearBuy = false
    end
    exports['varial-interaction']:hideInteraction()
end)

function AtPoliceBuy()
	Citizen.CreateThread(function()
        while nearBuy do
            Citizen.Wait(5)
            local plate = GetVehicleNumberPlateText(vehicle)
            local job = exports["isPed"]:isPed("myJob")
            if job == 'police' or job == 'state' or job == 'sheriff' then
                if IsControlJustReleased(0, 38) then
                    print('????')
                    TriggerEvent('varial-garages:openBuyMenu')
                end
            end
        end
    end)
end

RegisterNetEvent('varial-garages:openBuyMenuSWAT')
AddEventHandler('varial-garages:openBuyMenuSWAT', function()
    TriggerEvent('varial-context:sendMenu', {
		{
			id = 1,
			header = "SWAT Truck",
			txt = "Purchase for $150,000",
			params = {
				event = "varial-garages:PurchasedSWATTruck"
			}
		},
        {
			id = 2,
			header = "Police Prison Transport Bus",
			txt = "Purchase for $10,000",
			params = {
				event = "varial-garages:PurchasedPrisonBus"
			}
		},

	})
end)


AddEventHandler("varial-garages:openBuyMenu", function()
	exports["varial-context"]:showContext(MenuData["police_personal_buy"])
end)


RegisterNetEvent('varial-garages:openBuyMenu2')
AddEventHandler('varial-garages:openBuyMenu2', function()
    TriggerEvent('varial-context:sendMenu', {
		{
			id = 1,
			header = "EMS Ambulance",
			txt = "Purchase for $20,000",
			params = {
				event = "varial-garages:PurchasedAmbo"
			}
		},
	})
end)

RegisterNetEvent('varial-garages:PurchasedAmbo')
AddEventHandler('varial-garages:PurchasedAmbo', function()
    if exports["isPed"]:isPed("mycash") >= 20000 then
        TriggerServerEvent('varial-banking:removeMoney', 20000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Ambulance', 'emsnspeedo', '20000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedVic')
AddEventHandler('varial-garages:PurchasedVic', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('varial-banking:removeMoney', 50000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Vic', 'npolvic', '80000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)
    
RegisterNetEvent('varial-garages:PurchasedCharger')
AddEventHandler('varial-garages:PurchasedCharger', function()
    if exports["isPed"]:isPed("mycash") >= 50000 then
        TriggerServerEvent('varial-banking:removeMoney', 50000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Charger', 'npolchar', '120000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedExplorer')
AddEventHandler('varial-garages:PurchasedExplorer', function()
    if exports["isPed"]:isPed("mycash") >= 80000 then
        TriggerServerEvent('varial-banking:removeMoney', 80000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Explorer', 'npolexp', '95000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedCorvette')
AddEventHandler('varial-garages:PurchasedCorvette', function()
    if exports["isPed"]:isPed("mycash") >= 100000 then
        TriggerServerEvent('varial-banking:removeMoney', 100000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Charger', 'npolvette', '175000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedMustang')
AddEventHandler('varial-garages:PurchasedMustang', function()
    if exports["isPed"]:isPed("mycash") >= 100000 then
        TriggerServerEvent('varial-banking:removeMoney', 100000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Charger', 'npolstang', '175000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedChallenger')
AddEventHandler('varial-garages:PurchasedChallenger', function()
    if exports["isPed"]:isPed("mycash") >= 100000 then
        TriggerServerEvent('varial-banking:removeMoney', 100000)
        TriggerEvent('varial-garages:PurchasedVeh', 'Police Charger', 'npolchal', '175000')
    else
        TriggerEvent('DoLongHudText', "You do not have enough money!", 2)
    end
end)

RegisterNetEvent('varial-garages:PurchasedVeh')
AddEventHandler('varial-garages:PurchasedVeh', function(name, veh, price)
    local ped = PlayerPedId()
    local name = name	
    local vehicle = veh
    local price = price		
    local model = veh
    local colors = table.pack(GetVehicleColours(veh))
    local extra_colors = table.pack(GetVehicleExtraColours(veh))

    local mods = {}

    for i = 0,24 do
        mods[i] = GetVehicleMod(veh,i)
    end

    FreezeEntityPosition(ped,false)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(0)
    end

    local job = exports["isPed"]:isPed("myJob")
    if job == 'police' or job == 'state' or job == 'sheriff' then
        personalvehicle = CreateVehicle(model,462.81759643555,-1019.5252685547,28.100341796875,87.874015808105,true,false)
        SetEntityHeading(personalvehicle, 87.874015808105)
    elseif job == 'ems' then
        personalvehicle = CreateVehicle(model,333.1516418457,-575.947265625,28.791259765625,340.15747070312,true,false)
        SetEntityHeading(personalvehicle, 340.15747070312)
    end
        
    SetModelAsNoLongerNeeded(model)

    for i,mod in pairs(mods) do
        SetVehicleModKit(personalvehicle,0)
        SetVehicleMod(personalvehicle,i,mod)
    end

    SetVehicleOnGroundProperly(personalvehicle)

    local plate = GetVehicleNumberPlateText(personalvehicle)
    SetVehicleHasBeenOwnedByPlayer(personalvehicle,true)
    local id = NetworkGetNetworkIdFromEntity(personalvehicle)
    SetNetworkIdCanMigrate(id, true)
    Citizen.InvokeNative(0x629BFA74418D6239,Citizen.PointerValueIntInitialized(personalvehicle))
    SetVehicleColours(personalvehicle,colors[1],colors[2])
    SetVehicleExtraColours(personalvehicle,extra_colors[1],extra_colors[2])
    TaskWarpPedIntoVehicle(PlayerPedId(),personalvehicle,-1)
    SetEntityVisible(ped,true)			
    local primarycolor = colors[1]
    local secondarycolor = colors[2]	
    local pearlescentcolor = extra_colors[1]
    local wheelcolor = extra_colors[2]
    local VehicleProps = exports['varial-base']:FetchVehProps(personalvehicle)
    local model = GetEntityModel(personalvehicle)
    local vehname = GetDisplayNameFromVehicleModel(model)
    TriggerEvent("keys:addNew",personalvehicle, plate)
    TriggerServerEvent('varial-garages:FinalizedPur', plate, name, vehicle, price, VehicleProps)
    Citizen.Wait(100)
    exports['varial-interaction']:hideInteraction()
end)