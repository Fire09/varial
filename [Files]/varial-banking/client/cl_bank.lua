banking = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("banking", vector3(149.97, -1040.54, 29.37), 1.5, 2, {
        name="banking",
        heading=157.96,
        debugPoly=false,
        minZ=27.6,
        maxZ=31.99
    })

    exports["varial-polyzone"]:AddBoxZone("banking", vector3(-1212.980, -330.841, 37.787), 1.5, 2, {
        name="banking",
        heading=208.95,
        debugPoly=false,
        minZ=36.68,
        maxZ=40.38
    })

	exports["varial-polyzone"]:AddBoxZone("banking", vector3(-2962.582, 482.627, 15.703), 1.5, 2, {
        name="banking",
        heading=264.78,
        debugPoly=false,
        minZ=14.6,
        maxZ=18.1
    })

	exports["varial-polyzone"]:AddBoxZone("banking", vector3(-112.202, 6469.295, 31.626), 1.5, 2, {
        name="banking",
        heading=320.61,
        debugPoly=false,
        minZ=30.6,
        maxZ=33.7
    })

	exports["varial-polyzone"]:AddBoxZone("banking", vector3(314.187, -278.621, 54.170), 1.5, 2, {
        name="banking",
        heading=161.0,
        debugPoly=false,
        minZ=53.23,
        maxZ=56.82
    })

	exports["varial-polyzone"]:AddBoxZone("banking", vector3(-350.8, -49.53, 49.04), 1.5, 2, {
        name="banking",
        heading=163.22,
        debugPoly=false,
        minZ=48.04,
        maxZ=51.44
    })

	exports["varial-polyzone"]:AddBoxZone("banking", vector3(1175.06, 2706.64, 38.09), 1.5, 2, {
        name="banking",
        heading=359.12,
        debugPoly=false,
        minZ=36.99,
        maxZ=40.59
    })
    exports["varial-polyzone"]:AddBoxZone("banking", vector3(-1310.405, -824.9673, 17.14841), 1.5, 2, {
        name="banking",
        heading=39,
        debugPoly=false,
        minZ=15.99,
        maxZ=19.59
    })
    exports["varial-polyzone"]:AddBoxZone("banking", vector3(-1308.636, -823.724, 17.14841), 1.5, 2, {
        name="banking",
        heading=39,
        debugPoly=false,
        minZ=15.99,
        maxZ=19.59
    })
    exports["varial-polyzone"]:AddBoxZone("banking", vector3(-1307.098, -822.4764, 17.14841), 1.5, 2, {
        name="banking",
        heading=39,
        debugPoly=false,
        minZ=15.99,
        maxZ=19.59
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "banking" then
        banking = true
        bankingopen()
        exports["varial-interaction"]:showInteraction("[E] Bank")
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "banking" then
        banking = false
    end
    exports["varial-interaction"]:hideInteraction()
end)

function bankingopen()
    Citizen.CreateThread(function()
        while banking do
            Citizen.Wait(5)
            if IsControlJustReleased(0, 38) then
                TriggerEvent("bank:openbank")
            end
        end
    end)
end