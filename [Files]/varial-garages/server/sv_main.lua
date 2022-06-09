RPC.register("varial-garages:selectMenu", function(pGarage, pJob)
	local pSrc = source
	if pGarage == 'garagepd' then
		if pJob == 'police' or pJob == 'state' or pJob == 'sheriff' then
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "Shared Vehicles",
					txt = "Access the shared garage",
					params = {
						event = "varial-garages:PoliceMenu"
					}
				},
				{
					id = 2,
					header = "Personal Vehicles",
					txt = "List of all the personal vehicles.",
					params = {
						event = "varial-garages:openPersonalGarage"
					}
				},
			})
		else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "Personal Vehicles",
					txt = "List of all the personal vehicles.",
					params = {
						event = "varial-garages:openPersonalGarage"
					}
				},
			})
		end
	elseif pGarage == 'garageems' then
		if pJob == 'ems' then
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "Shared Vehicles",
					txt = "List of all the shared vehicles.",
					params = {
						event = "varial-garages:openSharedGarage"
					}
				},
				{
					id = 2,
					header = "Personal Vehicles",
					txt = "List of all the personal vehicles.",
					params = {
						event = "varial-garages:openPersonalGarage"
					}
				},
			})
		else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "Personal Vehicles",
					txt = "List of all the personal vehicles.",
					params = {
						event = "varial-garages:openPersonalGarage"
					}
				},
			})
		end
	else
		TriggerClientEvent('varial-context:sendMenu', pSrc, {
			{
				id = 1,
				header = "Personal Vehicles",
				txt = "List of all the personal vehicles.",
				params = {
					event = "varial-garages:openPersonalGarage"
				}
			},
		})
	end
end)

RPC.register("varial-garages:select", function(pGarage)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE cid = @cid AND current_garage = @garage', { ['@cid'] = char.id, ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('varial-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].model,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "varial-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine_damage = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body_damage = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
					pPassed = json.encode(vehicles)
				end
            end
        else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "No Vehicles",
					txt = "All vehicles are out!"
				},
			})
            return
        end
	end)
end)

RPC.register("varial-garages:attempt:sv", function(data)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()


    local enginePercent = data.engine_damage / 10
	local bodyPercent = data.body_damage / 10
	TriggerClientEvent('varial-context:sendMenu', pSrc, {
		{
			id = 1,
			header = "< Go Back",
			txt = "Return to your list of all your vehicles.",
			params = {
				event = "varial-garages:open"
			}
		},
		{
			id = 2,
			header = "Take Out Vehicle",
			txt = "Spawn the vehicle!",
			params = {
				event = "varial-garages:takeout",
				args = {
					pVeh = data.id
				}
			}
			
		},
		{
			id = 3,
			header = "Vehicle Status",
			txt = "Garage: "..data.current_garage.." | Engine: "..enginePercent.."% | Body: "..bodyPercent.."%"
		},
	})
end)

RPC.register("varial-garages:spawned:get", function(pID)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE id = @id', {['@id'] = pID}, function(vehicles)
		args = {
			model = vehicles[1].model,
			fuel = vehicles[1].fuel, 
			customized = vehicles[1].data,
			plate = vehicles[1].license_plate,
		}

		if vehicles[1].current_garage == "Impound Lot" and vehicles[1].vehicle_state == 'Normal Impound' then
			if user:getCash() >= 100 then
				user:removeMoney(100)
				TriggerClientEvent("varial-garages:attempt:spawn", pSrc, args, true)
			else
				TriggerClientEvent('DoLongHudText', pSrc, "You need $100", 2)
				return
			end
		else
			TriggerClientEvent("varial-garages:attempt:spawn", pSrc, args, true)
		end

	end)
end)

RPC.register("varial-garages:states", function(pState, plate, garage, fuel)
    local pSrc = source
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE license_plate = ?', {plate}, function(pIsValid)
		if pIsValid[1] then
			pExist = true
			exports.oxmysql:execute("UPDATE characters_cars SET vehicle_state = @state, current_garage = @garage, fuel = @fuel, coords = @coords WHERE license_plate = @plate", {
				['garage'] = garage, 
				['state'] = pState, 
				['plate'] = plate,  
				['fuel'] = fuel, 
				['coords'] = nil
			})
		else
			pExist = false
		end
	end)

	Citizen.Wait(100)
	return pExist
end)



RegisterServerEvent('updateVehicle')
AddEventHandler('updateVehicle', function(vehicleMods,plate)
	vehicleMods = json.encode(vehicleMods)
	exports.oxmysql:execute("UPDATE characters_cars SET data=@mods WHERE license_plate = @plate",{['mods'] = vehicleMods, ['plate'] = plate})
	print('updated')
end)

RegisterNetEvent("garages:loaded:in", function()
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
    local owner = char.id

    exports.oxmysql:execute('SELECT * FROM characters_cars WHERE cid = @cid', { ['@cid'] = owner}, function(vehicles)
		TriggerClientEvent('phone:Garage', src, vehicles)
    end)
end)

function ResetGaragesServer()
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE repoed = ?', {"0"}, function(vehicles)
		for k, v in ipairs(vehicles) do
			if v.vehicle_state == "Out" then
				exports.oxmysql:execute("UPDATE characters_cars SET vehicle_state = @state, coords = @coords WHERE license_plate = @plate", {['state'] = 'In', ['coords'] = nil, ['plate'] = v.license_plate})
			end
		end
	end)
end

Citizen.CreateThread(function()
    ResetGaragesServer();
end)

RPC.register("varial-garages:selectSharedGarage1", function(pGarage, pJob)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	if pJob == 'police' or pJob == 'state' or pJob == 'sheriff' then
		pType = 'bcso'
	elseif pJob == 'ems' then
		pType = 'medical'
	end
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE garage_info = @garage_info AND current_garage = @garage', { ['@garage_info'] = pType, ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('varial-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].name,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "varial-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine_damage = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body_damage = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
					pPassed = json.encode(vehicles)
				end
            end
        else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "No Vehicles",
					txt = "All vehicles are out!"
				},
			})
            return
        end
	end)
end)

RPC.register("varial-garages:selectSharedGarage2", function(pGarage, pJob)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	if pJob == 'police' or pJob == 'state' or pJob == 'sheriff' then
		pType = 'sasp'
	elseif pJob == 'ems' then
		pType = 'medical'
	end
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE garage_info = @garage_info AND current_garage = @garage', { ['@garage_info'] = pType, ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('varial-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].name,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "varial-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine_damage = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body_damage = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
					pPassed = json.encode(vehicles)
				end
            end
        else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "No Vehicles",
					txt = "All vehicles are out!"
				},
			})
            return
        end
	end)
end)

RPC.register("varial-garages:selectSharedGarage", function(pGarage, pJob)
    local pSrc = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(pSrc)
    local char = user:getCurrentCharacter()
	if pJob == 'police' or pJob == 'state' or pJob == 'sheriff' then
		pType = 'lspd'
	elseif pJob == 'ems' then
		pType = 'medical'
	end
	exports.oxmysql:execute('SELECT * FROM characters_cars WHERE garage_info = @garage_info AND current_garage = @garage', { ['@garage_info'] = pType, ['@garage'] = pGarage}, function(vehicles)
        if vehicles[1] ~= nil then
            for i = 1, #vehicles do
				if vehicles[i].vehicle_state ~= "Out" then
					TriggerClientEvent('varial-context:sendMenu', pSrc, {
						{
							id = vehicles[i].id,
							header = vehicles[i].name,
							txt = "Plate: "..vehicles[i].license_plate,
							params = {
								event = "varial-garages:attempt:spawn",
								args = {
									id = vehicles[i].id,
									engine_damage = vehicles[i].engine_damage,
									current_garage = vehicles[i].current_garage,
									body_damage = vehicles[i].body_damage,
									model = vehicles[i].model,
									fuel = vehicles[i].fuel, 
									customized = vehicles[i].data,
									plate = vehicles[i].license_plate
								}
							}
						},
					})
					pPassed = json.encode(vehicles)
				end
            end
        else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "No Vehicles",
					txt = "All vehicles are out!"
				},
			})
            return
        end
	end)
end)



RPC.register("varial-garages:PoliceMenu", function(pGarage, pJob)
	local pSrc = source
	if pGarage == 'garagepd' then
		if pJob == 'police' or pJob == 'state' or pJob == 'sheriff' then
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "LSPD Garage",
					txt = "Access the shared garage",
					params = {
						event = "varial-garages:openSharedGarage"
					}
				},
				{
					id = 2,
					header = "BCSO Garage",
					txt = "Access the shared garage",
					params = {
						event = "varial-garages:openSharedGarage1"
					}
				},
				{
					id = 3,
					header = "SASP Garage",
					txt = "Access the shared garage",
					params = {
						event = "varial-garages:openSharedGarage2"
					}
				},
			})
		else
			TriggerClientEvent('varial-context:sendMenu', pSrc, {
				{
					id = 1,
					header = "Personal Vehicles",
					txt = "List of all the personal vehicles.",
					params = {
						event = "varial-garages:openPersonalGarage"
					}
				},
			})
		end
	end
end)