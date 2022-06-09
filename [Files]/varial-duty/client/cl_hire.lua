-- POLICE HIRE/FIRE --

RegisterNetEvent("varial-duty:HireLaw:Menu")
AddEventHandler("varial-duty:HireLaw:Menu", function()
    local valid = exports["varial-applications"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Department"
            },
            {
                id = 2,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("varial-duty:HireLaw", valid[1].input, valid[2].input, valid[3].input)
    end
end)

RegisterNetEvent("varial-duty:FireLaw:Menu")
AddEventHandler("varial-duty:FireLaw:Menu", function()
    local valid = exports["varial-applications"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("varial-duty:FireLaw", valid[1].input)
    end
end)

-- END POLICE HIRE/FIRE --

-- EMS HIRE/FIRE --

RegisterNetEvent("varial-duty:HireEMS:Menu")
AddEventHandler("varial-duty:HireEMS:Menu", function()
    local valid = exports["varial-applications"]:KeyboardInput({
        header = "Hire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
            {
                id = 1,
                txt = "Enter Rank"
            },
        }
    })
    if valid then
        TriggerServerEvent("varial-duty:HireEMS", valid[1].input, valid[2].input)
    end
end)

RegisterNetEvent("varial-duty:FireEMS:Menu")
AddEventHandler("varial-duty:FireEMS:Menu", function()
    local valid = exports["varial-applications"]:KeyboardInput({
        header = "Fire Menu",
        rows = {
            {
                id = 0,
                txt = "Enter CID"
            },
        }
    })
    if valid then
        TriggerServerEvent("varial-duty:FireEMS", valid[1].input)
    end
end)

-- END EMS HIRE/FIRE --