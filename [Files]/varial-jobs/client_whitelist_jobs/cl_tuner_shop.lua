--// Registers

RegisterNetEvent("tunershop:register")
AddEventHandler("tunershop:register", function(registerID)
    local rank = exports["isPed"]:GroupRank("tuner_shop")
    if rank >= 1 then 
        local order = exports["varial-applications"]:KeyboardInput({
            header = "Create Receipt",
            rows = {
                {
                    id = 0,
                    txt = "Amount"
                },
                {
                    id = 1,
                    txt = "Comment"
                }
            }
        })
        if order then
            TriggerServerEvent("tuner_shop:OrderComplete", registerID, order[1].input, order[2].input)
        end
    else
        TriggerEvent("DoLongHudText", "You cant use this", 2)
    end
end)

RegisterNetEvent("tunershop:get:receipt")
AddEventHandler("tunershop:get:receipt", function(registerid)
    TriggerServerEvent('tunershop:retreive:receipt', registerid)
end)

RegisterNetEvent('tunershop:cash:in')
AddEventHandler('tunershop:cash:in', function()
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("tunershop:update:pay", cid)
end)

--// Trade In Recipt

MintTunerShopTradeInreceipt = false

Citizen.CreateThread(function()
    exports["varial-polyzone"]:AddBoxZone("varial_tunershop_receipt", vector3(-1187.76, -904.62, 13.98), 1.5, 1.6, {
        name="varial_tunershop_receipt",
        heading=305,
        debugPoly=false,
        minZ=10.78,
        maxZ=14.78
    })
end)

RegisterNetEvent('varial-polyzone:enter')
AddEventHandler('varial-polyzone:enter', function(name)
    if name == "varial_tunershop_receipt" then
        MintTunerShopTradeInreceipt = true     
        TunerShopReceipts()
            local rank = exports["isPed"]:GroupRank("tuner_shop")
            if rank >= 1 then 
            exports['varial-interaction']:showInteraction("[E] Trade In Receipts")
        end
    end
end)

RegisterNetEvent('varial-polyzone:exit')
AddEventHandler('varial-polyzone:exit', function(name)
    if name == "varial_tunershop_receipt" then
        MintTunerShopTradeInreceipt = false
        exports['varial-interaction']:hideInteraction()
    end
end)

function TunerShopReceipts()
	Citizen.CreateThread(function()
        while MintTunerShopTradeInreceipt do
            Citizen.Wait(5)
			if IsControlJustReleased(0, 38) then
                    local rank = exports["isPed"]:GroupRank("tuner_shop")
                    if rank >= 1 then 
                    TriggerEvent('tunershop:cash:in')
                end
			end
		end
	end)
end