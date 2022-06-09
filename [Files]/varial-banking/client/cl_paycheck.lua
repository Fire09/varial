Citizen.CreateThread(function()    
    exports["varial-polyzone"]:AddBoxZone("receipt_sell", vector3(242.94, 224.48, 106.29), 1.6, 1.4, {
      name="receipt_sell",
      heading=70,
     -- debugPoly=false,
      minZ=105.29,
      maxZ=106.69
    })
  end)
  
  RegisterNetEvent('varial-polyzone:enter')
  AddEventHandler('varial-polyzone:enter', function(name)
      if name == "receipt_sell" then
          NearReceipt = true
          exports['varial-interaction']:showInteraction("Use receipt here")
      end
  end)
  
  RegisterNetEvent('varial-polyzone:exit')
  AddEventHandler('varial-polyzone:exit', function(name)
      if name == "receipt_sell" then
          NearReceipt = false
      end
      exports['varial-interaction']:hideInteraction()
  end)
  
  exports("NearReceiptShit", function()
      return NearReceipt
  end)