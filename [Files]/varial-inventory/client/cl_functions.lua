

local fixingvehicle = false
local justUsed = false
local itemsUsedRecently = 0
local lastCounter = 0 
local HeadBone = 0x796e;

local jailBounds = PolyZone:Create({
  vector2(1855.8966064453, 2701.9802246094),
  vector2(1775.4013671875, 2770.5339355469),
  vector2(1646.7535400391, 2765.9870605469),
  vector2(1562.7836914063, 2686.6459960938),
  vector2(1525.3662109375, 2586.5190429688),
  vector2(1533.7038574219, 2465.5300292969),
  vector2(1657.5997314453, 2386.9389648438),
  vector2(1765.8286132813, 2404.4763183594),
  vector2(1830.1740722656, 2472.1193847656),
  vector2(1855.7557373047, 2569.0361328125)
}, {
    name = "jail_bounds",
    minZ = 30,
    maxZ = 70.5,
    debugGrid = false,
    gridDivisions = 25
})

RegisterNetEvent('inventory:DegenLastUsedItem')
AddEventHandler('inventory:DegenLastUsedItem', function(percent)
    local cid = exports["isPed"]:isPed("cid")
    print("Degen applied to ".. LastUsedItemId .. " ID: " .. LastUsedItem .. " at %" .. percent)
    TriggerServerEvent("inventory:degItem",LastUsedItem,percent,LastUsedItemId,cid)
end)

local validWaterItem = {
    ["oxygentank"] = true,
    ["water"] = true,
    ["vodka"] = true,
    ["beer"] = true,
    ["whitewine"] = true,
    ["whiskey"] = true,
    ["coffee"] = true,
    ["tea"] = true,
    ["fishtaco"] = true,
    ["fish_taco"] = true,
    ["taco"] = true,
    ["burrito"] = true,
    ["churro"] = true,
    ["hotdog"] = true,
    ["greencow"] = true,
    ["donut"] = true,
    ["eggsbacon"] = true,
    ["icecream"] = true,
    ["mshake"] = true,
    ["sandwich"] = true,
    ["hamburger"] = true,
    ["fish_sandwich"] = true,
    ["cola"] = true,
    ["jailfood"] = true,
    ["bleederburger"] = true,
    ["heartstopper"] = true,
    ["torpedo"] = true,
    ["meatfree"] = true,
    ["moneyshot"] = true,
    ["fries"] = true,
    ["slushy"] = true,
    ["nightvision"] = true,


}



Citizen.CreateThread(function()
    TriggerServerEvent("inv:playerSpawned");
end)

RegisterNetEvent('inventory-jail')
AddEventHandler('inventory-jail', function(startPosition, cid, name)
    if (hasEnoughOfItem("okaylockpick",1,false)) then
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPoly = jailBounds:isPointInside(coord)
        if inPoly  then
             TriggerServerEvent("server-inventory-open", startPosition, cid, "1", name);
        end
    end
end)


function getCloestVeh()
    playerped = PlayerPedId()
    coordA = GetEntityCoords(playerped, 1)
    coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    targetVehicle = getVehicleInDirection(coordA, coordB)
    return targetVehicle
end

RegisterNetEvent('RunUseItem')
AddEventHandler('RunUseItem', function(itemid, slot, inventoryName, isWeapon, iteminfo, quality)

    if itemid == nil then
        return
    end
    local player = PlayerPedId()
    local ItemInfo = GetItemInfo(slot)
    local currentVehicle = GetVehiclePedIsUsing(player)
    LastUsedItem = ItemInfo.id
    LastUsedItemId = itemid
    if ItemInfo.quality == nil then return end
    if ItemInfo.quality < 1 then
        TriggerEvent("DoLongHudText","Item is too worn.",2)
        if isWeapon then
            TriggerEvent("brokenWeapon")
        end
        return
    end

    if justUsed then
        itemsUsedRecently = itemsUsedRecently + 1
        if itemsUsedRecently > 10 and itemsUsedRecently > lastCounter+5 then
            lastCounter = itemsUsedRecently
            TriggerServerEvent("exploiter", "Tried using " .. itemsUsedRecently .. " items in < 500ms ")
        end
        return
    end

    justUsed = true

    if (not hasEnoughOfItem(itemid,1,false)) then
        TriggerEvent("DoLongHudText","You dont appear to have this item on you?",2) 
        justUsed = false
        itemsUsedRecently = 0
        lastCounter = 0
        return
    end

    if itemid == "-72657034" then
        TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        TriggerEvent("inventory:removeItem",itemid, 1)
        justUsed = false
        itemsUsedRecently = 0
        lastCounter = 0
        return
    end

    if itemid == "craftbench" then
        TriggerEvent('varial-crafting:placecraftbench')
    end

    if not isValidUseCase(itemid,isWeapon) then
        justUsed = false
        itemsUsedRecently = 0
        lastCounter = 0
        return
    end

    if (itemid == nil) then
        justUsed = false
        itemsUsedRecently = 0
        lastCounter = 0
        return
    end

    if (isWeapon) then
        if tonumber(ItemInfo.quality) > 0 then
            TriggerEvent("equipWeaponID",itemid,ItemInfo.information,ItemInfo.id)
        end
        justUsed = false
        itemsUsedRecently = 0
        lastCounter = 0
        Wait(1500)
        TriggerEvent("AttachWeapons")
        return
    end
    
    if itemid == "smokegrenadeswat" or itemid == "smokegrenadenpa" then
        if tonumber(ItemInfo.quality) > 0 then
            TriggerEvent("equipWeaponID",-37975472,ItemInfo.information,ItemInfo.id, itemid)
        end
        justUsed = false
        retardCounter = 0
        lastCounter = 0
        return
    end

    if (itemid == "adrenaline") then
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,1000,"POG GAMING Adrenaline","inventory:adrenaline",true,itemid,playerVeh)
    end



    TriggerEvent("hud-display-item",itemid,"Used")

    Wait(800)

    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)

     if (not IsPedInAnyVehicle(player)) then
         if (itemid == "Suitcase") then
            TriggerEvent('attach:suitcase')
         end

         if (itemid == "Boombox") then
                 TriggerEvent('attach:boombox')
         end
         if (itemid == "Box") then
             TriggerEvent('attach:box')
         end
         if (itemid == "DuffelBag") then
                 TriggerEvent('attach:blackDuffelBag')
         end
         if (itemid == "MedicalBag") then
                 TriggerEvent('attach:medicalBag')
         end
         if (itemid == "SecurityCase") then
                 TriggerEvent('attach:securityCase')
         end
         if (itemid == "Toolbox") then
                 TriggerEvent('attach:toolbox')
         end
     end

    local remove = false
    local itemreturn = false
    local drugitem = false
    local fooditem = false
    local drinkitem = false
    local healitem = false

    if (itemid == "joint" or itemid == "lsconfidentialjoint" or itemid == "alaskanthunderfuckjoint" or itemid == "chiliadkushjoint" or itemid == "whitewine" or itemid == "weed5oz" or itemid == "weedq" or itemid == "beer" or itemid == "vodka" or itemid == "whiskey" or itemid == "lsdtab") then
        drugitem = true
    end

    if (itemid == "cane") then
        TriggerEvent('attach:cane')
    end
    
    if (itemid == "fakeplate") then
      TriggerEvent("fakeplate:change")
    end

    if (itemid == "miningpickaxe") then
        TriggerEvent('varial-start-mining')
    end

    if (itemid == "tuner") then

      local finished = exports["varial-taskbar"]:taskBar(2000,"Connecting Tuner Laptop",false,false,playerVeh)
      if (finished == 100) then
        TriggerEvent("tuner:open")
      end
    end

    if (itemid == "electronickit" or itemid == "lockpick") then
      TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
      
    end
    if (itemid == "locksystem") then
      TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
    end

    if (itemid == "thermite") then
      TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
    end

    if (itemid == "blackmarket") then
        TriggerEvent('varial-blackmarket:open')
    end

    if (itemid == "thermalcharge") then
        TriggerEvent('varial-bobcat:firstdoor')
        TriggerEvent('varial-bobcat:seconddoor')
    
    end  

    if (itemid == "huntingbait") then
        TriggerEvent('varial-hunting:usedBait')
    end

    if (itemid == "nightvision") then
        TriggerEvent('nightvision:toggle')
    end

    if (itemid == "grapplegun" or itemid == "grapplegunpd") then
        TriggerEvent('Ghost:UseGrappleGun')
      end


    if (itemid == "spikes") then 
        TriggerEvent('placespikes')
    end
    
    if (itemid == "pdbadge") then
        TriggerServerEvent("varial-police:showBadge", json.decode(ItemInfo.information))
    end
    

    if(itemid == "evidencebag") then
        TriggerEvent("evidence:startCollect", itemid, slot)
        local itemInfo = GetItemInfo(slot)
        local data = itemInfo.information
        if data == '{}' then
            TriggerEvent("DoLongHudText","Start collecting evidence!",1) 
            TriggerEvent("inventory:updateItem", itemid, slot, '{"used": "true"}')
            --
        else
            local dataDecoded = json.decode(data)
            if(dataDecoded.used) then
                print('YOURE ALREADY COLLECTING EVIDENCE YOU STUPID FUCK')
            end
        end
    end

    if (itemid == "lsdtab" or itemid == "badlsdtab") then
        TriggerEvent("animation:PlayAnimation","pill")
        local finished = exports["varial-taskbar"]:taskBar(3000,"Placing LSD Strip on 👅",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("Evidence:StateSet",2,1200)
            TriggerEvent("Evidence:StateSet",24,1200)
            TriggerEvent("fx:run", "lsd", 180, nil, (itemid == "badlsdtab" and true or false))
            remove = true
        end
    end

    if (itemid == "pixellaptop")  then
        TriggerServerEvent("ethicalpixel-boosting:usedlaptop")
    end    

    if (itemid == "disabler")  then
        TriggerServerEvent("ethicalpixel-boosting:useddisabler")
    end  

    if (itemid == "decryptersess" or itemid == "decrypterfv2" or itemid == "decrypterenzo") then
      if (#(GetEntityCoords(player) - vector3( 1275.49, -1710.39, 54.78)) < 3.0) then
          local finished = exports["varial-taskbar"]:taskBar(25000,"Decrypting Data",false,false,playerVeh)
          if (finished == 100) then
            TriggerEvent("pixerium:check",3,"request:BankUpdate",true)
          end
      end

      if #(GetEntityCoords(player) - vector3( 2328.94, 2571.4, 46.71)) < 3.0 then
          local finished = exports["varial-taskbar"]:taskBar(25000,"Decrypting Data",false,false,playerVeh)
          if finished == 100 then
            TriggerEvent("pixerium:check",3,"robbery:decrypt2",true)
          end
      end

      if #(GetEntityCoords(player) - vector3( 1208.73,-3115.29, 5.55)) < 3.0 then
          local finished = exports["varial-taskbar"]:taskBar(25000,"Decrypting Data",false,false,playerVeh)
          if finished == 100 then
            TriggerEvent("pixerium:check",3,"robbery:decrypt3",true)
          end
      end
      
    end

    if (itemid == "pix1") then
      if (#(GetEntityCoords(player) - vector3( 1275.49, -1710.39, 54.78)) < 3.0) then
          local finished = exports["varial-taskbar"]:taskBar(25000,"Decrypting Data",false,false,playerVeh)
          if (finished == 100) then
            TriggerEvent("Crypto:GivePixerium",math.random(1,2))
            remove = true
          end
      end
    end  

    if (itemid == "pix2") then
      if (#(GetEntityCoords(player) - vector3( 1275.49, -1710.39, 54.78)) < 3.0) then
          local finished = exports["varial-taskbar"]:taskBar(25000,"Decrypting Data",false,false,playerVeh)
          if (finished == 100) then
            TriggerEvent("Crypto:GivePixerium",math.random(5,12))
            remove = true
          end
      end
    end

    if (itemid == "femaleseed") then
        TriggerEvent("varial-state:stateSet",4,1600)
        TriggerEvent("varial-weed:plantSeed", itemid)
     end
 
     if (itemid == "maleseed") then
         TriggerEvent("varial-state:stateSet",4,1600)
         TriggerEvent("varial-weed:plantSeed", itemid)
     end

    if (itemid == "weedoz") then
 
      local finished = exports["varial-taskbar"]:taskBar(5000,"Packing Q Bags",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("weedq", 40, true)
        end
        
    end

    if ( itemid == "smallbud" and hasEnoughOfItem("qualityscales",1,false) ) then
        local finished = exports["varial-taskbar"]:taskBar(1000,"Packing Joint",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("joint2", 80, true)    
        end
    end

    if (itemid == "heistlaptop3") then
        local police = exports["varial-duty"]:LawAmount()
        if police >= 3 then
            TriggerServerEvent("varial-fleeca:laptop1")  
        else
            TriggerEvent('DoLongHudText', 'Not enough police', 2)
        end
    end

    if (itemid == "weedq") then
        local finished = exports["varial-taskbar"]:taskBar(1000,"Rolling Joints",false,false,playerVeh)
        if (finished == 100) then
            CreateCraftOption("joint", 80, true)    
        end
    end

    if (itemid == "lighter") then
        TriggerEvent("animation:PlayAnimation","lighter")
          local finished = exports["varial-taskbar"]:taskBar(2000,"Starting Fire",false,false,playerVeh)
        if (finished == 100) then
            
        end
    end

    if (itemid == "joint" or itemid == "joint2" or itemid == "lsconfidentialjoint" or itemid == "alaskanthunderfuckjoint" or itemid == "chiliadkushjoint") then
        local finished = exports["varial-taskbar"]:taskBar(2000,"Smoking Joint",false,false,playerVeh)
        if (finished == 100) then
            Wait(200)
            TriggerEvent("animation:PlayAnimation","weed")
            TriggerEvent("Evidence:StateSet",3,1000)
            TriggerEvent("Evidence:StateSet",4,1000)        
            TriggerEvent("stress:timed2",1000,"WORLD_HUMAN_SMOKING_POT")
            remove = true
        end
    end

    if (itemid == "blunt") then
        local finished = exports["varial-taskbar"]:taskBar(2000,"Smoking Joint",false,false,playerVeh)
        if (finished == 100) then
            local roll = math.random(1, 3)
            if roll == 1 then
                remove = true
            elseif roll == 2 then
                print('nothing')
            elseif roll == 3 then
                print('nothing')
            end
            Wait(200)
            TriggerEvent("animation:PlayAnimation","weed")
            TriggerEvent("Evidence:StateSet",3,1000)
            TriggerEvent("Evidence:StateSet",4,1000)        
            TriggerEvent("stress:timed2",1000,"WORLD_HUMAN_SMOKING_POT")
        end
    end

    if (itemid == "vodka" or itemid == "beer" or itemid == "whiskey" or itemid == "absinthe" or itemid == "whitewine" or itemid == "redwine" or itemid == "drink1" or itemid == "drink2" or itemid == "drink3" or itemid == "drink4" or itemid == "drink5" or itemid == "drink6"
    or itemid == "drink7" or itemid == "drink8" or itemid == "drink9" or itemid == "drink10" or itemid == "shot1" or itemid == "shot2" or itemid == "shot3" or itemid == "shot4" or itemid == "shot5" or itemid == "shot6"
    or itemid == "shot7" or itemid == "shot8" or itemid == "shot9" or itemid == "shot10") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drink","",true,itemid,playerVeh)
        TriggerEvent("varial-hud:ChangeThirst", 35)
        TriggerEvent("Evidence:StateSet", 8, 600)
        local alcoholStrength = 0.5
        if itemid == "vodka" or itemid == "whiskey" or itemid == "whitewine" or itemid == "redwine" then alcoholStrength = 1.0 end
        if itemid == "absinthe" then alcoholStrength = 2.5 end
        if itemid == "drink1" or itemid == "drink2" or itemid == "drink3" or itemid == "drink4" or itemid == "drink5" or itemid == "drink6"
        or itemid == "drink7" or itemid == "drink8" or itemid == "drink9" or itemid == "drink10" then
            alcoholStrength = 0.6
        end
        if itemid == "shot1" or itemid == "shot2" or itemid == "shot3" or itemid == "shot4" or itemid == "shot5" or itemid == "shot6"
        or itemid == "shot7" or itemid == "shot8" or itemid == "shot9" or itemid == "shot10" then
            alcoholStrength = 0.8
        end
        TriggerEvent("fx:run", "alcohol", 180, alcoholStrength, -1, (itemid == "absinthe" and true or false))
    end

    if ( itemid == "martini" or itemid == "GlassOfWhiskey" or itemid == "margarita") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drinking "..itemid,"",true,itemid,playerVeh)
        TriggerEvent('varial-hud:ChangeThirst', 50)
        TriggerEvent("Evidence:StateSet", 8, 600)
        local alcoholStrength = 0.5
        if itemid == "martini" or itemid == "GlassOfWhiskey" or itemid == "margarita" then alcoholStrength = 1.0 end
        TriggerEvent("fx:run", "alcohol", 180, alcoholStrength)
    end


    if ( itemid == "glassofredwine" or itemid == "glassofwhitewine") then
        AttachPropAndPlayAnimation("amb@world_human_drinking@coffee@male@idle_a", "idle_c", 49,6000,"Drinking Wine","",true,itemid,playerVeh)
        TriggerEvent('varial-hud:ChangeThirst', 50)
        TriggerEvent("Evidence:StateSet", 8, 600)
        local alcoholStrength = 0.5
        if itemid == "vodka" or itemid == "whiskey" then alcoholStrength = 1.0 end
        TriggerEvent("fx:run", "alcohol", 180, alcoholStrength)
    end

    if (itemid == "coffee") then
        TriggerEvent("animation:PlayAnimation","drink")
        local finished = exports['varial-taskbar']:taskBar(6000, 'Drinking Coffee')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('coffee', 1) then
                TriggerEvent('varial-hud:ChangeThirst', 50)
                TriggerEvent('coffee:drink')
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on the floor?', 2)
            end
        end
    end
    
    if (itemid == "tea") then
        TriggerEvent("animation:PlayAnimation","drink")
        local finished = exports['varial-taskbar']:taskBar(6000, 'Drinking Tea')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('tea', 1) then 
                TriggerEvent('varial-hud:ChangeThirst', 55)
                TriggerEvent('coffee:drink') 
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on the floor?', 2)
            end
        end
    end

    if (itemid == "fishtaco" or itemid == "salad" or itemid == "sushiplate") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(7000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('fishtaco', 1) or exports['varial-inventory']:hasEnoughOfItem('salad', 1) or exports['varial-inventory']:hasEnoughOfItem('sushiplate', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 50)
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on the floor?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "fish_taco") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating Taco')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('fish_taco', 1) then
                TriggerEvent("destroyProp")
                remove = true
                TriggerEvent('varial-tacos')
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on the floor?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end
    
    if (itemid == "chocobar") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating Chocolate Bar')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('chocobar', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 12)
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "chips") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(7000, 'Eating Fries')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('chips', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 15)
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "taco" or itemid == "burrito") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('taco', 1) or exports['varial-inventory']:hasEnoughOfItem('burrito', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 30)
                TriggerEvent('varial-tacos')
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "churro" or itemid == "hotdog") then
        TriggerEvent("animation:PlayAnimation","drink")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('churro', 1) or exports['varial-inventory']:hasEnoughOfItem('hotdog', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 30)
                TriggerEvent('food:Condiment') 
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "greencow") then
        TriggerEvent("animation:PlayAnimation","drink")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Drinking')
        if finishied == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('greencow', 1) then
                TriggerEvent('varial-hud:ChangeThirst', 35)
                TriggerEvent('food:Condiment')
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "donut" or itemid == "eggsbacon") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('donut', 1) or exports['varial-inventory']:hasEnoughOfItem('eggsbacon', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 30)
                TriggerEvent('food:Condiment')
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "icecream" or itemid == "vanillaicecream") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","food:IceCream",true,itemid,playerVeh)
        TriggerEvent('varial-hud:ChangeHunger', 30)
    end

    if (itemid == "mshake") then
        TaskItem("amb@world_human_drinking@beer@female@idle_a", "idle_a", 49,6000,"Drinking Milkshake","food:IceCream",true,itemid,playerVeh)
        TriggerEvent('varial-hud:ChangeThirst', 45)
    end


    if (itemid == "advlockpick") then
             
        local myJob = exports["isPed"]:isPed("myJob")
        if myJob ~= "news" then
            TriggerEvent('inv:advancedLockpick',inventoryName,slot)
            TriggerEvent("InventoryAdvanced:lockPick",false,inventoryName,slot)
            TriggerEvent('dummie-check:boosting')
        else
            TriggerEvent("DoLongHudText","Nice news reporting, you shit lord idiot.")
        end   

    end


     if (itemid == "Gruppe6Card") then
        TriggerEvent("DoLongHudText","What you think this is some kind of joke?")
        -- local police = exports["varial-duty"]:LawAmount()
        -- if police >= 0 then
        --     local coordA = GetEntityCoords(GetPlayerPed(-1), 1)
        --     local coordB = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 100.0, 0.0)
        --     local targetVehicle = getVehicleInDirection(coordA, coordB)
        --     if targetVehicle ~= 0 and GetHashKey("stockade") == GetEntityModel(targetVehicle) then
        --         local entityCreatePoint = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0, -4.0, 0.0)
        --         local coords = GetEntityCoords(GetPlayerPed(-1))
        --         local aDist = GetDistanceBetweenCoords(coords["x"], coords["y"],coords["z"], entityCreatePoint["x"], entityCreatePoint["y"],entityCreatePoint["z"])
        --         local cityCenter = vector3(-204.92, -1010.13, 29.55) -- alta street train station
        --         local timeToOpen = 45000
        --         local distToCityCenter = #(coords - cityCenter)
        --         if distToCityCenter > 1000 then
        --             local multi = math.floor(distToCityCenter / 1000)
        --             timeToOpen = timeToOpen + (30000 * multi)
        --         end
        --         if aDist < 2.0 then
        --             --TriggerEvent("alert:noPedCheck", "banktruck")
        --             FreezeEntityPosition(GetPlayerPed(-1),true)
        --             local finished = exports["varial-taskbar"]:taskBar(timeToOpen,"Unlocking Vehicle",false,false,playerVeh)
        --             if finished == 100 then
        --                 FreezeEntityPosition(GetPlayerPed(-1),false)
        --                 remove = true
        --                 TriggerEvent("varial-heists:start_hitting_truck", targetVehicle)
        --             else
        --                 TriggerEvent("evidence:bleeding")
        --             end
        --         else
        --             TriggerEvent("DoLongHudText","You need to do this from behind the vehicle.")
        --         end
        --     end
        -- else
        --     TriggerEvent('DoLongHudText', 'Not enough Police around', 2)
        -- end
    end


    if (itemid == "usbdevice") then
        local finished = exports["varial-taskbar"]:taskBar(15000,"Scanning For Networks",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("hacking:attemptHack")
        end
        
    end

    if (itemid == "weed12oz") then
        TriggerServerEvent("exploiter", "Someone ate a box with 12oz of weed for no reason / removing item in unintended way")
        TriggerEvent("inv:weedPacking") -- cannot find the end of this call anywhere
        remove = true
    end

    if (itemid == "heavyammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1788949567,50,true)
            remove = true
        end
    end


    if (itemid == "trackerdisabler" ) then
        TriggerEvent('varial-boosting:delayTracker')
        remove = false
    end

    if (itemid == "huntingammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1285032059,5,true)
            remove = true
        end
    end

    if (itemid == "pistolammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1950175060,50,true)
            remove = true
        end
    end

    if (itemid == "pistolammoPD") then
        local finished = exports["varial-taskbar"]:taskBar(2500,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1950175060,50,true)
            remove = true
        end
    end

    if (itemid == "rifleammoPD") then
        print('dumbasssdasdasd')
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",218444191,50,true)
            remove = true
        end
    end

    if (itemid == "shotgunammoPD") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",218444191,50,true)
            remove = true
        end
    end

    if (itemid == "subammoPD") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1820140472,50,true)
            remove = true
        end
    end

    if (itemid == "snowballammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo", `AMMO_SNOWBALL_2`, 50, true)
            remove = true
        end
    end

    if (itemid == "rifleammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",218444191,50,true)
            remove = true
        end
    end

    if (itemid == "sniperammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",218444191,50,true)
            remove = true
        end
    end

    if (itemid == "airsoftammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if ( finished == 100 and hasEnoughOfItem(itemid, 1, false) ) then
            TriggerEvent("actionbar:ammo",-100695554,250,true)
            remove = true
        end
    end

    -- if (itemid == "sniperammo") then
    --     local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
    --     if (finished == 100) then
    --         TriggerEvent("actionbar:ammo",1285032059,5,true)
    --         remove = true
    --     end
    -- end

    if (itemid == "shotgunammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",-1878508229,50,true)
            remove = true
        end
    end

    if (itemid == "subammo") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1820140472,50,true)
            remove = true
        end
    end


    if (itemid == "paintballs") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1916856719,100,true)
            remove = true
        end
    end

    if (itemid == "rubberslugs") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",1517835987,10,true)
            remove = true
        end
    end

    if (itemid == "taserammo") then
        local finished = exports["varial-taskbar"]:taskBar(2000,"Reloading",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",-1575030772,3,true)
            remove = true
        end
    end

    if (itemid == "empammo") then
        local finished = exports["varial-taskbar"]:taskBar(30000,"Recharging EMP",false,false,playerVeh)
        if (finished == 100) then
            TriggerEvent("actionbar:ammo",2034517757,2,true)
            remove = true
        end
    end

    if (itemid == "tyrerepairkit") then
        local veh = getCloestVeh()
        if DoesEntityExist(veh) and IsEntityAVehicle(veh) and #(GetEntityCoords(veh) - GetEntityCoords(PlayerPedId())) < 5.0 then
            ExecuteCommand('e mechanic3')
            FreezeEntityPosition(playerped,true)
            local finished = exports["varial-taskbar"]:taskBar(20000,"Fixing tires",false,false,playerVeh)
            if (finished == 100) then
                for i = 0, 5 do
                    SetVehicleTyreFixed(targetVehicle, i) 
                    TriggerEvent('veh.randomDegredation',10,targetVehicle,3)
                    ClearPedTasks(playerped)
                    FreezeEntityPosition(playerped, false)
                    TriggerEvent('DoLongHudText', 'Repair Complete !')
                    remove = true
                end
            end
        else
            TriggerEvent('DoShortHudText', 'No vehicle nearby !',2)
      end
   end

    if (itemid == "armor" or itemid == "pdarmor") then
        local finished = exports["varial-taskbar"]:taskBar(15000,"Putting on Armor",true,false,playerVeh)
        if (finished == 100) then
            StopAnimTask(PlayerPedId(), 'clothingshirt', 'try_shirt_positive_d', 1.0)
            SetPlayerMaxArmour(PlayerId(), 60)
            SetPedArmour( player, 60)
            TriggerEvent("UseBodyArmor")
            remove = true
        end
    end

    if (itemid == "wearablechain") then
        TriggerEvent('ghost:togglechain')
    end 

    if (itemid == "cbrownie" or itemid == "cgummies") then
        TriggerEvent("animation:PlayAnimation","pill")
        local finished = exports["varial-taskbar"]:taskBar(3000,"Consuming edibles 😉",false,false,playerVeh)
        if (finished == 100) then
            if exports['varial-inventory']:hasEnoughOfItem('cbrownie', 1) or exports['varial-inventory']:hasEnoughOfItem('cgummies', 1) then
                TriggerEvent("Evidence:StateSet",3,1200)
                TriggerEvent("Evidence:StateSet",7,1200)
                TriggerEvent("fx:run", "weed", 180, -1, false)
                remove = true
            else
                TriggerEvent('destroyProp')
                TriggerEvent('DoLongHudText', 'Oh it fell on then floor ?', 2)
            end
        end
    end

    if (itemid == "bodybag") then
        local finished = exports["varial-taskbar"]:taskBar(10000,"Opening bag",true,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerEvent( "player:receiveItem", "humanhead", 1 )
            TriggerEvent( "player:receiveItem", "humantorso", 1 )
            TriggerEvent( "player:receiveItem", "humanarm", 2 )
            TriggerEvent( "player:receiveItem", "humanleg", 2 )
        end
    end

    if (itemid == "ownerreceipt") then
        local myJob = exports["isPed"]:isPed("myJob")
        local itemInfo = GetItemInfo(slot)
        if itemInfo ~= nil then
            if itemInfo.information ~= nil then
                local decoded = json.decode(itemInfo.information)
                
                if exports['varial-banking']:NearReceiptShit() then
                    local amount = decoded.Price 
                    local percentwotip = math.ceil(decoded.Price * 0.60)                     
                    local WorkerPercent = percentwotip
                    local SendToSociety = amount - percentwotip

                    TriggerServerEvent('society:update', SendToSociety, myJob, "add")
                    RPC.execute("varial-jobs:addcash", WorkerPercent)
                    remove = true
                end
            end
        end
    end
    
    if (itemid == "present") then
        local finished = exports["varial-taskbar"]:taskBar(2500,"Opening present",true,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerEvent( "player:receiveItem", "mobilephone", 1 )
            TriggerEvent( "player:receiveItem", "heartstopper", 1 )
            TriggerEvent( "player:receiveItem", "softdrink", 1 )
            TriggerEvent( "player:receiveItem", "idcard", 1 )
            TriggerEvent( "player:receiveItem", "bandage", 5 )
            TriggerEvent( "player:receiveItem", "lockpick", 1 )
        end
    end

    if (itemid == "bodygarbagebag") then
        local finished = exports["varial-taskbar"]:taskBar(10000,"Opening trash bag",false,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerServerEvent('loot:useItem', itemid)
        end
    end

    if (itemid == "foodsupplycrate") then
        TriggerEvent("DoLongHudText","Make sure you have a ton of space in your inventory! 100 or more.",2)
        local finished = exports["varial-taskbar"]:taskBar(20000,"Opening the crate (ESC to Cancel)",false,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerEvent( "player:receiveItem", "heartstopper", 10 )
            TriggerEvent( "player:receiveItem", "moneyshot", 10 )
            TriggerEvent( "player:receiveItem", "bleederburger", 10 )
            TriggerEvent( "player:receiveItem", "fries", 10 )
            TriggerEvent( "player:receiveItem", "cola", 10 )
        end
    end

    if (itemid == "organcooler") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Opening cooler",true,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerEvent( "player:receiveItem", "humanheart", 1 )
            TriggerEvent( "player:receiveItem", "organcooleropen", 1 )
        end
    end

    if itemid == "humanhead" then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 10000, "Eating (ESC to Cancel)", "inv:wellfed", true,itemid,playerVeh,true,"humanskull")
    end

    if (itemid == "humantorso" or itemid == "humanarm" or itemid == "humanhand" or itemid == "humanleg" or itemid == "humanfinger") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 10000, "Eating (ESC to Cancel)", "inv:wellfed", true,itemid,playerVeh,true,"humanbone")
    end

    if (itemid == "humanear" or itemid == "humanintestines" or itemid == "humanheart" or itemid == "humaneye" or itemid == "humanbrain" or itemid == "humankidney" or itemid == "humanliver" or itemid == "humanlungs" or itemid == "humantongue" or itemid == "humanpancreas") then
        TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 10000, "Eating (ESC to Cancel)", "inv:wellfed", true,itemid)
    end

    if (itemid == "Bankbox") then
        if (hasEnoughOfItem("locksystem",1,false)) then
            local finished = exports["varial-taskbar"]:taskBar(10000,"Opening bank box.",false,false,playerVeh)
            if (finished == 100) then
                remove = true
                TriggerEvent("inventory:removeItem","locksystem", 1)  

                TriggerServerEvent('loot:useItem', itemid)
            end
        else
            TriggerEvent("DoLongHudText","You are missing something to open the box with",2)
        end
    end

    if (itemid == "Securebriefcase") then
        if (hasEnoughOfItem("Bankboxkey",1,false)) then
            local finished = exports["varial-taskbar"]:taskBar(5000,"Opening briefcase.",false,false,playerVeh)
            if (finished == 100) then
                remove = true
                TriggerEvent("inventory:removeItem","Bankboxkey", 1)  

                TriggerServerEvent('loot:useItem', itemid)
            end
        else
            TriggerEvent("DoLongHudText","You are missing something to open the briefcase with",2)
        end
    end

    if (itemid == "Largesupplycrate") then
        if (hasEnoughOfItem("2227010557",1,false)) then
            local finished = exports["varial-taskbar"]:taskBar(15000,"Opening supply crate.",false,false,playerVeh)
            if (finished == 100) then
                remove = true
                TriggerEvent("inventory:removeItem","2227010557", 1)  

                TriggerServerEvent('loot:useItem', itemid)
            end
        else
            TriggerEvent("DoLongHudText","You are missing something to open the crate with",2)
        end
    end

    if (itemid == "xmasgiftcoal") then
        local finished = exports["varial-taskbar"]:taskBar(15000, "Opening Gift", false, false, playerVeh)
        if (finished == 100) then
            remove = true
            TriggerServerEvent('loot:useItem', itemid)
        end
    end

    if (itemid == "Smallsupplycrate") then
        if (hasEnoughOfItem("2227010557",1,false)) then
            local finished = exports["varial-taskbar"]:taskBar(15000,"Opening supply crate.",false,false,playerVeh)
            if (finished == 100) then
                remove = true
                TriggerEvent("inventory:removeItem","2227010557", 1)  

                TriggerServerEvent('loot:useItem', itemid)
            end
        else
            TriggerEvent("DoLongHudText","You are missing something to open the crate with",2)
        end
    end

    if (itemid == "Mediumsupplycrate") then
        if (hasEnoughOfItem("2227010557",1,false)) then
            local finished = exports["varial-taskbar"]:taskBar(15000,"Opening supply crate.",false,false,playerVeh)
            if (finished == 100) then
                remove = true
                TriggerEvent("inventory:removeItem","2227010557", 1)  

                TriggerServerEvent('loot:useItem', itemid)
            end
        else
            TriggerEvent("DoLongHudText","You are missing something to open the crate with",2)
        end
    end

    if (itemid == "fishingrod") then
        TriggerEvent("varial-fishing:start-fishing")
    end

    if (itemid == "fishingtacklebox") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Opening",true,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerServerEvent('loot:useItem', itemid)
        end
    end

    if (itemid == "fishingchest") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Opening",true,false,playerVeh)
        if (finished == 100) then
            remove = true
            TriggerEvent( "player:receiveItem", "goldbar", math.random(1,5) )
        end
    end

    if (itemid == "fishinglockbox") then
        local finished = exports["varial-taskbar"]:taskBar(5000,"Opening",true,false,playerVeh)
        if (finished == 100) then
            --remove = true
            --TriggerServerEvent('loot:useItem', itemid)
            TriggerEvent("DoLongHudText","Add your map thing here DW you fucking fuck fuck",2)
        end
    end


    if (itemid == "binoculars") then 
        TriggerEvent("binoculars:Activate") 
    end

    if (itemid == "methtable") then
        TriggerEvent("placemethtable", 538990259)
    end
    
    if (itemid == "camera") then
        TriggerEvent("camera:Activate")
    end
    
    if (itemid == "mrbench" and currentVehicle == 0) then
        print("???")
        TriggerEvent("varial-craftbench:place", `gr_prop_gr_bench_03b`)
    end

    if (itemid == "nitrous") then
        local currentVehicle = GetVehiclePedIsIn(player, false)
        if IsPedInAnyVehicle(PlayerPedId(), true) then
            if not IsToggleModOn(currentVehicle,18) then
                TriggerEvent("DoLongHudText","You need a Turbo to use NOS!",2)
            else
                local finished = 0
                local cancelNos = false
                Citizen.CreateThread(function()
                    while finished ~= 100 and not cancelNos do
                Citizen.Wait(100)
                    if GetEntitySpeed(GetVehiclePedIsIn(player, false)) > 5 then
                    exports["varial-taskbar"]:closeGuiFail()
                    TriggerEvent("DoLongHudText","Stop Driving Dumbfuck!",2)
                    cancelNos = true
                    end
                end
            end)
                TriggerEvent("carmod:nos")
            end
        end
    end

    if (itemid == "lockpick") then
        TriggerEvent("inv:lockPick",false,inventoryName,slot)
        TriggerEvent('dummie-check:boosting')
    end
		
    if (itemid == "radio" or itemid == "emsradio" or itemid == "shortradio" or itemid == "civradio") then
        TriggerEvent('radioGui')
    end
		
    if (itemid == "umbrella") then
        TriggerEvent("animation:PlayAnimation","umbrella")
    end

    if (itemid == "repairkit") then
      TriggerEvent('veh:repairing',inventoryName,slot,itemid)
      TriggerEvent("inventory:DegenLastUsedItem", 5)
    end

    if (itemid =="advrepairkit") then
      TriggerEvent('veh:repairing',inventoryName,slot,itemid)
           
    end
    if (itemid == "securityblue" or itemid == "securityblack" or itemid == "securitygreen" or itemid == "securitygold" or itemid == "securityred")  then
        TriggerEvent("robbery:scanLock",false,itemid)       
    end

    if (itemid == "Gruppe6Card2")  then
        TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
    end

    if (itemid == "Gruppe6Card222")  then
        TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
    end    

    if (itemid == "Gruppe6Card22")  then
        TriggerServerEvent("robbery:triggerItemUsedServer",itemid)
    end 

    if (itemid == "ciggy") then
        local finished = exports["varial-taskbar"]:taskBar(2000,"Lighting Up",false,false,playerVeh)
        if (finished == 100) then
            Wait(200)
            TriggerEvent("animation:PlayAnimation","smoke")      
            TriggerEvent("stress:timed",600,"WORLD_HUMAN_SMOKING_POT")
            remove = true
            Wait(20000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    end

    if (itemid == "cigar") then
        if (finished == 100) then
            Wait(200)
            TriggerEvent("animation:PlayAnimation","cigar")    
            TriggerEvent("stress:timed",600,"WORLD_HUMAN_SMOKING_POT")
            remove = true
            Wait(6000)
            ClearPedTasksImmediately(GetPlayerPed(-1))
        end
    end

    if (itemid == "oxygentank") then
        local finished = exports["varial-taskbar"]:taskBar(30000,"Oxygen Tank",true,false,playerVeh)
        if (finished == 100) then        
            TriggerEvent("UseOxygenTank")
            remove = true
        end
    end

    if (itemid == "safecrackingkit") then
        TriggerEvent('varial-robberies:HitSafes')
    end

    if (itemid == "safecrackingkit") then
        TriggerEvent('varial-robberies:HitRegister')
    end

    if (itemid == "bandage") then
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,10000,"Healing","healed:minors",true,itemid,playerVeh)
    end

    if (itemid == "coke50g") then
        TriggerEvent('inventory:removeItem', 'coke50g', 1)
        local finished = exports['varial-taskbar']:taskBar(5000, 'Unpacking Cocaine')
        if finished == 100 then
            TriggerEvent('player:receiveItem', 'coke5g', 50)
        end
    end

    if (itemid == "bakingsoda") then 
        CreateCraftOption("1gcrack", 80, true)
    end

    if (itemid == "glucose") then 
        CreateCraftOption("1gcocaine", 80, true) 
    end

    if (itemid == "idcard") then 
        local ItemInfo = GetItemInfo(slot)
        TriggerServerEvent("police:showID",ItemInfo.information)   
    end

    if (itemid == "drivingtest") then 
        local ItemInfo = GetItemInfo(slot)
        if (ItemInfo.information ~= "No information stored") then
            local data = json.decode(ItemInfo.information)
            TriggerServerEvent("driving:getResults", data.ID)
        end
    end

    if (itemid == "coke5g") then
        TriggerEvent("attachItemObjectnoanim","drugpackage01")
        TriggerEvent("Evidence:StateSet",2,1200)
        TriggerEvent("Evidence:StateSet",6,1200)
        TaskItem("anim@amb@nightclub@peds@", "missfbi3_party_snort_coke_b_male3", 49, 5000, "Coke Gaming", "hadcocaine", true,itemid,playerVeh)
    end

    if (itemid == "1gcrack") then 
        TriggerEvent("attachItemObjectnoanim","crackpipe01")
        TriggerEvent("Evidence:StateSet",2,1200)
        TriggerEvent("Evidence:StateSet",6,1200)
        TaskItem("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 49, 5000, "Smoking Quack", "hadcrack", true,itemid,playerVeh)
    end

    if (itemid == "treat") then
        local model = GetEntityModel(player)
        if model == GetHashKey("a_c_chop") then
            TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 1200, "Treat Num's", "hadtreat", true,itemid,playerVeh)
        end
    end

    if (itemid == "IFAK") then
        TaskItem("amb@world_human_clipboard@male@idle_a", "idle_c", 49,2000,"Applying IFAK","healed:useOxy",true,itemid,playerVeh)
    end

    if (itemid == "aspirin") then
        TriggerEvent("animation:PlayAnimation","pill")
        TriggerEvent("useOxy")
        TriggerEvent("healed:useOxy")
        remove = true
    end

    if (itemid == "oxy") then
        TriggerEvent("animation:PlayAnimation","pill")
        TriggerEvent("useOxy")
        TriggerEvent("healed:useOxy")
        remove = true
    end

    if (itemid == "sandwich" or itemid == "hamburger" or itemid == "fish_sandwich" or itemid == "salad" or itemid == "salmon_on_rice") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('sandwich', 1) or exports['varial-inventory']:hasEnoughOfItem('hamburger', 1) or exports['varial-inventory']:hasEnoughOfItem('fish_sandwich', 1) or exports['varial-inventory']:hasEnoughOfItem('salad', 1) or exports['varial-inventory']:hasEnoughOfItem('salmon_on_rice', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 30)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    -- Pearls items maybe later make certain foods do differnt effects ?

    if (itemid == "skinnedbass" or itemid == "skinnedsalmon" or itemid == "skinnedmarlin" or itemid == "skinnedshark" or itemid == "cookedcrab" or itemid == "cookedshrimp") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('skinnedbass', 1) or exports['varial-inventory']:hasEnoughOfItem('skinnedsalmon', 1) or exports['varial-inventory']:hasEnoughOfItem('skinnedmarlin', 1) or exports['varial-inventory']:hasEnoughOfItem('skinnedshark', 1) or exports['varial-inventory']:hasEnoughOfItem('cookedcrab', 1) or exports['varial-inventory']:hasEnoughOfItem('cookedshrimp', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 46)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "cookedsalmon" or itemid == "cookedshark" or itemid == "cookedrice" or itemid == "platedshrimp" or itemid == "platedbass" or itemid == "cookedshrimp") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('cookedsalmon') or exports['varial-inventory']:hasEnoughOfItem('cookedshark', 1) or exports['varial-inventory']:hasEnoughOfItem('cookedrice', 1) or exports['varial-inventory']:hasEnoughOfItem('platedshrimp', 1) or exports['varial-inventory']:hasEnoughOfItem('platedbase', 1) or exports['varial-inventory']:hasEnoughOfItem('cookedshrimp', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 50)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "platedsalmon" or itemid == "platedmarlin") then
        TriggerEvent("animation:PlayAnimation","eat")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Eating')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('platedsalmon', 1) or exports['varial-inventory']:hasEnoughOfItem('platedmarlin', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeHunger', 50)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    -- [ End of pearls]

    if (itemid == "cola" or itemid == "soda" or itemid == "water") then
        TriggerEvent("animation:PlayAnimation","drink")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Drinking')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('cola', 1) or exports['varial-inventory']:hasEnoughOfItem('soda', 1) or exports['varial-inventory']:hasEnoughOfItem('water', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeThirst', 30)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    
    if (itemid == "softdrink") then
        TriggerEvent("animation:PlayAnimation","drink")
        TriggerEvent("attachItem", itemid)
        local finished = exports['varial-taskbar']:taskBar(6000, 'Drinking')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('softdrink', 1) then
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeThirst', 50)
                remove = true
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "jailfood" or itemid == "bleederburger" or itemid == "heartstopper" or itemid == "torpedo" or itemid == "meatfree" or itemid == "moneyshot" or itemid == "fries") then
        AttachPropAndPlayAnimation("mp_player_inteat@burger", "mp_player_int_eat_burger", 49,6000,"Eating","inv:wellfed",true,itemid,playerVeh)
        --attachPropsToAnimation(itemid, 6000)
        --TaskItem("mp_player_inteat@burger", "mp_player_int_eat_burger", 49, 6000, "Eating", "inv:wellfed", true,itemid)
    end

    if (itemid == "methbag" or itemid == "methlabproduct") then
        TriggerEvent("attachItemObjectnoanim","crackpipe01")
        TriggerEvent("Evidence:StateSet",2,1200)
        TriggerEvent("Evidence:StateSet",6,1200)
        TaskItem("switch@trevor@trev_smoking_meth", "trev_smoking_meth_loop", 49, 1500, "Smoking Meth", "hadcocaine", true, itemid,playerVeh)
    end

    if itemid == "slushy" then
        TriggerEvent("healed:useOxy")
        TriggerEvent("animation:PlayAnimation","drink")
        TriggerEvent("attachItem", "cup")
        local finished = exports['varial-taskbar']:taskBar(10000, 'Drinking Slushy')
        if finished == 100 then
            if exports['varial-inventory']:hasEnoughOfItem('slushy', 1) then
                remove = true
                TriggerEvent("destroyProp")
                TriggerEvent('varial-hud:ChangeThirst', 30)
                TriggerEvent('varial-hud:ChangeHunger', 30)
            else
                TriggerEvent('DoLongHudText', 'oh shit, it fell on the floor ?', 2)
                TriggerEvent("destroyProp")
            end
        else
            TriggerEvent("destroyProp")
        end
    end

    if (itemid == "shitlockpick") then
        lockpicking = true
        TriggerEvent("animation:lockpickinvtestoutside") 
        local finished = exports["varial-taskbar"]:taskBar(2500,math.random(5,20))
        if (finished == 100) then    
            TriggerEvent("police:uncuffMenu")
        end
        lockpicking = false
        remove = true
    end

    if (itemid == "watch") then
        TriggerEvent("carHud:compass")
    end

    if (itemid == "harness") then
        local veh = GetVehiclePedIsIn(player, false)
        local driver = GetPedInVehicleSeat(veh, -1)
        if (PlayerPedId() == driver) then
            TriggerEvent("vehicleMod:useHarnessItem")
            remove = true
        end
    end

    if remove then
        TriggerEvent("inventory:removeItem",itemid, 1)
    end

    Wait(500)
    itemsUsedRecently = 0
    justUsed = false


end)

function AttachPropAndPlayAnimation(dictionary,animation,typeAnim,timer,message,func,remove,itemid,vehicle)
    if itemid == "hamburger" or itemid == "heartstopper" or itemid == "bleederburger" or itemid == "fish_sandwich" then
        TriggerEvent("attachItem", "hamburger")
    elseif itemid == "sandwich" then
        TriggerEvent("attachItem", "sandwich")
    elseif itemid == "donut" then
        TriggerEvent("attachItem", "donut")
    elseif itemid == "water" or itemid == "cola" or itemid == "vodka" or itemid == "whiskey" or itemid == "beer" or itemid == "coffee" then
        TriggerEvent("attachItem", itemid)
    elseif itemid == "fishtaco" or itemid == "taco" or itemid == "fish_taco" then
        TriggerEvent("attachItem", "taco")
    elseif itemid == "greencow" then
        TriggerEvent("attachItem", "energydrink")
    elseif itemid == "slushy" then
        TriggerEvent("attachItem", "cup")
    end
    TaskItem(dictionary, animation, typeAnim, timer, message, func, remove, itemid,vehicle)
    TriggerEvent("destroyProp")
end

RegisterNetEvent('randPickupAnim')
AddEventHandler('randPickupAnim', function()
    loadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low',5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
    Wait(1000)
    ClearPedSecondaryTask(PlayerPedId())
end)

local clientInventory = {};
RegisterNetEvent('current-items')
AddEventHandler('current-items', function(inv)
    clientInventory = inv
    checkForAttachItem()
    TriggerEvent("AttachWeapons")
end)

function checkForAttachItem()
    local AttatchItems = {
        "stolentv",
        "stolenmusic",
        "stolencoffee",
        "stolenmicrowave",
        "stolencomputer",
        "stolenart",
        "darkmarketpackage",
        "weedpackage",
        "methpackage",
        "boxscraps",
        "dodopackagesmall",
        "dodopackagemedium",
        "dodopackagelarge",
        "housesafe",
        "fridge",
        "haybale"
    }

    local itemToAttach = "none"
    for k,v in pairs(AttatchItems) do
        if getQuantity(v) >= 1 then
            itemToAttach = v
            print(itemToAttach)
            break
        end
    end

    TriggerEvent("animation:carry",itemToAttach,true)
end

RegisterNetEvent('SniffRequestCID')
AddEventHandler('SniffRequestCID', function(src)
    local cid = exports["isPed"]:isPed("cid")
    TriggerServerEvent("SniffCID",cid,src)
end)

function GetItemInfo(checkslot)
    for i,v in pairs(clientInventory) do
        if (tonumber(v.slot) == tonumber(checkslot)) then
            local info = {["information"] = v.information,["id"] = v.id, ["quality"] = v.quality, ["item_id"] = v.item_id, ["amount"] = v.amount }
            return info
        end
    end
    return "No information stored";
end

-- item id, amount allowed, crafting.
function CreateCraftOption(id, add, craft)
    TriggerEvent("CreateCraftOption", id, add, craft)
end

-- Animations
function loadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end

function TaskItem(dictionary,animation,typeAnim,timer,message,func,remove,itemid,playerVeh,itemreturn,itemreturnid)
    loadAnimDict( dictionary ) 
    TaskPlayAnim( PlayerPedId(), dictionary, animation, 8.0, 1.0, -1, typeAnim, 0, 0, 0, 0 )
    local timer = tonumber(timer)
    if timer > 0 then
        local finished = exports["varial-taskbar"]:taskBar(timer,message,true,false,playerVeh)
        if finished == 100 or timer == 0 then
            TriggerEvent(func)

            if remove then
                TriggerEvent("inventory:removeItem",itemid, 1)
            end
            if itemreturn then
                TriggerEvent( "player:receiveItem",itemreturnid, 1 )
            end

        end
    else
        TriggerEvent(func)
    end
end

function GetCurrentWeapons()
    local returnTable = {}
    for i,v in pairs(clientInventory) do
        if (tonumber(v.item_id)) then
            local t = { ["hash"] = v.item_id, ["id"] = v.id, ["information"] = v.information, ["name"] = v.item_id, ["slot"] = v.slot }
            returnTable[#returnTable+1]=t
        end
    end   
    if returnTable == nil then 
        return {}
    end
    return returnTable
end

function getQuantity(itemid)
    local amount = 0
    for i,v in pairs(clientInventory) do
        if (v.item_id == itemid) then
            amount = amount + v.amount
        end
    end
    return amount
end

function hasEnoughOfItem(itemid,amount,shouldReturnText)
    if shouldReturnText == nil then shouldReturnText = true end
    if itemid == nil or itemid == 0 or amount == nil or amount == 0 then if shouldReturnText then TriggerEvent("DoLongHudText","I dont seem to have " .. itemid .. " in my pockets.",2) end return false end
    amount = tonumber(amount)
    local slot = 0
    local found = false

    if getQuantity(itemid) >= amount then
        return true
    end 
    return false
end

function isValidUseCase(itemID,isWeapon)
    local player = PlayerPedId()
    local playerVeh = GetVehiclePedIsIn(player, false)
    if playerVeh ~= 0 then
        local model = GetEntityModel(playerVeh)
        if IsThisModelACar(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
            if IsEntityInAir(playerVeh) then
                Wait(1000)
                if IsEntityInAir(playerVeh) then
                    TriggerEvent("DoLongHudText","You appear to be flying through the air",2) 
                    return false
                end
            end
        end
    end

    if not validWaterItem[itemID] and not isWeapon then
        if IsPedSwimming(player) then
            local targetCoords = GetEntityCoords(player, 0)
            Wait(700)
            local plyCoords = GetEntityCoords(player, 0)
            if #(targetCoords - plyCoords) > 1.3 then
                TriggerEvent("DoLongHudText","Cannot be moving while swimming to use this.",2) 
                return false
            end
        end

        if IsPedSwimmingUnderWater(player) then
            TriggerEvent("DoLongHudText","Cannot be underwater to use this.",2) 
            return false
        end
    end

    return true
end

-- DNA

RegisterNetEvent('evidence:addDnaSwab')
AddEventHandler('evidence:addDnaSwab', function(dna)
    TriggerEvent("DoLongHudText", "DNA Result: " .. dna,1)    
end)

RegisterNetEvent('CheckDNA')
AddEventHandler('CheckDNA', function()
    TriggerServerEvent("Evidence:checkDna")
end)

RegisterNetEvent('evidence:swabNotify')
AddEventHandler('evidence:swabNotify', function()
    TriggerEvent("DoLongHudText", "DNA swab taken.",1)
end)


function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end


-- DNA AND EVIDENCE END

-- this is the upside down world, be careful.

function getVehicleInDirection(coordFrom, coordTo)
    local offset = 0
    local rayHandle
    local vehicle

    for i = 0, 100 do
        rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z + offset, 10, PlayerPedId(), 0)   
        a, b, c, d, vehicle = GetRaycastResult(rayHandle)
        
        offset = offset - 1

        if vehicle ~= 0 then break end
    end
    
    local distance = Vdist2(coordFrom, GetEntityCoords(vehicle))
    
    if distance > 25 then vehicle = nil end

    return vehicle ~= nil and vehicle or 0
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)

end

local burgies = 0
RegisterNetEvent('inv:wellfed')
AddEventHandler('inv:wellfed', function()
    TriggerEvent("Evidence:StateSet",25,3600)
    TriggerEvent("varial-hud:updateStress",false,10)
    TriggerEvent('varial-hud:ChangeHunger', 100)
    TriggerEvent('varial-hud:ChangeThirst', 100)
    burgies = 0
end)

RegisterNetEvent('animation:lockpickinvtestoutside')
AddEventHandler('animation:lockpickinvtestoutside', function()
    local lPed = PlayerPedId()
    RequestAnimDict("veh@break_in@0h@p_m_one@")
    while not HasAnimDictLoaded("veh@break_in@0h@p_m_one@") do
        Citizen.Wait(0)
    end
    
    while lockpicking do        
        TaskPlayAnim(lPed, "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 1.0, 1.0, 1.0, 16, 0.0, 0, 0, 0)
        Citizen.Wait(2500)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('animation:lockpickinvtest')
AddEventHandler('animation:lockpickinvtest', function(disable)
    local lPed = PlayerPedId()
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end
    if disable ~= nil then
        if not disable then
            lockpicking = false
            return
        else
            lockpicking = true
        end
    end
    while lockpicking do

        if not IsEntityPlayingAnim(lPed, "mini@repair", "fixing_a_player", 3) then
            ClearPedSecondaryTask(lPed)
            TaskPlayAnim(lPed, "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    ClearPedTasks(lPed)
end)

RegisterNetEvent('inv:lockPick')
AddEventHandler('inv:lockPick', function(isForced,inventoryName,slot)
    TriggerEvent("robbery:scanLock",true)
    if lockpicking then return end

    lockpicking = true
    playerped = PlayerPedId()
    targetVehicle = GetVehiclePedIsUsing(playerped)
    local itemid = 21

    if targetVehicle == 0 then
        coordA = GetEntityCoords(playerped, 1)
        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
        local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
        if targetVehicle == 0 then
            lockpicking = false
            TriggerEvent("robbery:lockpickhouse",isForced)
            return
        end

        if driverPed ~= 0 then
            lockpicking = false
            return
        end
            local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
            local leftfront = GetOffsetFromEntityInWorldCoords(targetVehicle, d1["x"]-0.25,0.25,0.0)

            local count = 5000
            local dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
            while dist > 2.0 and count > 0 do
                dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
                Citizen.Wait(1)
                count = count - 1
                DrawText3Ds(leftfront["x"],leftfront["y"],leftfront["z"],"Move here to lockpick.")
            end

            if dist > 2.0 then
                lockpicking = false
                return
            end


            TaskTurnPedToFaceEntity(PlayerPedId(), targetVehicle, 1.0)
            Citizen.Wait(1000)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
            local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, true)
                StartVehicleAlarm(targetVehicle)
            end

            TriggerEvent("animation:lockpickinvtestoutside")
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)



 
            local finished = exports["varial-ui"]:taskBarSkill(15000,3)

            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(2200,4)

            if finished ~= 100 then
                 lockpicking = false
                return
            end


            if finished == 100 then
                if triggerAlarm then
                    SetVehicleAlarm(targetVehicle, false)
                end
                local chance = math.random(50)
                if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then

                    SetVehicleDoorsLocked(targetVehicle, 1)
                    TriggerEvent("DoLongHudText", "Vehicle Unlocked.",1)
                    TriggerEvent("inventory:DegenLastUsedItem", 5)
                    TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 0.1)

                end
            end
        lockpicking = false
    else
        if targetVehicle ~= 0 and not isForced then

            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
            local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, true)
                StartVehicleAlarm(targetVehicle)
            end

            SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
            TriggerEvent("animation:lockpickinvtest")
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)

           
            local carTimer = GetVehicleHandlingFloat(targetVehicle, 'CHandlingData', 'nMonetaryValue')
            if carTimer == nil then
                carTimer = math.random(25000,180000)
            end
            if carTimer < 25000 then
                carTimer = 25000
            end

            if carTimer > 180000 then
                carTimer = 180000
            end
            
            carTimer = math.ceil(carTimer / 3)


            local myJob = exports["isPed"]:isPed("myJob")
            if myjob == "towtruck" then
                carTimer = 4000
            end

            local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(1500,math.random(5,10))
            if finished ~= 100 then
                TriggerEvent("DoLongHudText", "The lockpick bent out of shape.",2)
                TriggerEvent("inventory:DegenLastUsedItem", 20)
                 lockpicking = false
                return
            end     


            Citizen.Wait(500)
            if finished == 100 then
                if triggerAlarm then
                    SetVehicleAlarm(targetVehicle, false)
                end
                local chance = math.random(50)
                if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then

                    local plate = GetVehicleNumberPlateText(targetVehicle)
                    SetVehicleDoorsLocked(targetVehicle, 1)
                    TriggerEvent("keys:addNew",targetVehicle,plate)
                    TriggerEvent("DoLongHudText", "Ignition Working.",1)
                    SetVehicleEngineOn(targetVehicle,0,1,1)
                    SetEntityAsMissionEntity(targetVehicle,false,true)
                    SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
                    TriggerEvent("chop:plateoff",plate)

                end
                lockpicking = false
            end
        end
    end
    lockpicking = false
end)

RegisterNetEvent('InventoryAdvanced:lockPick')
AddEventHandler('InventoryAdvanced:lockPick', function(isForced,inventoryName,slot)
    TriggerEvent("robbery:scanLock",true)
    if lockpicking then return end

    lockpicking = true
    playerped = PlayerPedId()
    targetVehicle = GetVehiclePedIsUsing(playerped)
    local itemid = 21

    if targetVehicle == 0 then
        coordA = GetEntityCoords(playerped, 1)
        coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
        targetVehicle = getVehicleInDirection(coordA, coordB)
        local driverPed = GetPedInVehicleSeat(targetVehicle, -1)
        if targetVehicle == 0 then
            lockpicking = false
            TriggerEvent("robbery:lockpickhouse",isForced)
            return
        end

        if driverPed ~= 0 then
            lockpicking = false
            return
        end
            local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
            local leftfront = GetOffsetFromEntityInWorldCoords(targetVehicle, d1["x"]-0.25,0.25,0.0)

            local count = 5000
            local dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
            while dist > 2.0 and count > 0 do
                dist = #(vector3(leftfront["x"],leftfront["y"],leftfront["z"]) - GetEntityCoords(PlayerPedId()))
                Citizen.Wait(1)
                count = count - 1
                DrawText3Ds(leftfront["x"],leftfront["y"],leftfront["z"],"Move here to lockpick.")
            end

            if dist > 2.0 then
                lockpicking = false
                return
            end


            TaskTurnPedToFaceEntity(PlayerPedId(), targetVehicle, 1.0)
            Citizen.Wait(1000)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
            local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, true)
                StartVehicleAlarm(targetVehicle)
            end

            TriggerEvent("animation:lockpickinvtestoutside")
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)



 
            local finished = exports["varial-ui"]:taskBarSkill(15000,3)

            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(2200,4)

            if finished ~= 100 then
                 lockpicking = false
                return
            end


            if finished == 100 then
                if triggerAlarm then
                    SetVehicleAlarm(targetVehicle, false)
                end
                local chance = math.random(50)
                if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then

                    SetVehicleDoorsLocked(targetVehicle, 1)
                    TriggerEvent("DoLongHudText", "Vehicle Unlocked.",1)
                    TriggerEvent('InteractSound_CL:PlayOnOne', 'unlock', 0.1)
                    TriggerEvent("inventory:DegenLastUsedItem", 5)

                end
            end
        lockpicking = false
    else
        if targetVehicle ~= 0 and not isForced then

            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)
            local triggerAlarm = GetVehicleDoorLockStatus(targetVehicle) > 1
            if triggerAlarm then
                SetVehicleAlarm(targetVehicle, true)
                StartVehicleAlarm(targetVehicle)
            end

            SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
            TriggerEvent("animation:lockpickinvtest")
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 3.0, 'lockpick', 0.4)

           
            local carTimer = GetVehicleHandlingFloat(targetVehicle, 'CHandlingData', 'nMonetaryValue')
            if carTimer == nil then
                carTimer = math.random(25000,180000)
            end
            if carTimer < 25000 then
                carTimer = 25000
            end

            if carTimer > 180000 then
                carTimer = 180000
            end
            
            carTimer = math.ceil(carTimer / 3)


            local myJob = exports["isPed"]:isPed("myJob")
            if myjob == "towtruck" then
                carTimer = 4000
            end

            local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
            if finished ~= 100 then
                 lockpicking = false
                return
            end

            local finished = exports["varial-ui"]:taskBarSkill(1500,math.random(5,10))
            if finished ~= 100 then
                TriggerEvent("DoLongHudText", "The lockpick bent out of shape.",2)
                TriggerEvent("inventory:DegenLastUsedItem", 20)             
                 lockpicking = false
                return
            end     


            Citizen.Wait(500)
            if finished == 100 then
                if triggerAlarm then
                    SetVehicleAlarm(targetVehicle, false)
                end
                local chance = math.random(50)
                if #(GetEntityCoords(targetVehicle) - GetEntityCoords(PlayerPedId())) < 10.0 and targetVehicle ~= 0 and GetEntitySpeed(targetVehicle) < 5.0 then

                    local plate = GetVehicleNumberPlateText(targetVehicle)
                    SetVehicleDoorsLocked(targetVehicle, 1)
                    TriggerEvent("keys:addNew",targetVehicle,plate)
                    TriggerEvent("DoLongHudText", "Ignition Working.",1)
                    SetEntityAsMissionEntity(targetVehicle,false,true)
                    SetVehicleHasBeenOwnedByPlayer(targetVehicle,true)
                    TriggerEvent("chop:plateoff",plate)

                end
                lockpicking = false
            end
        end
    end
    lockpicking = false
end)

local reapiring = false
RegisterNetEvent('veh:repairing')
AddEventHandler('veh:repairing', function(inventoryName,slot,itemid)
    local playerped = PlayerPedId()
    local coordA = GetEntityCoords(playerped, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 100.0, 0.0)
    local targetVehicle = getVehicleInDirection(coordA, coordB)

    local advanced = false
    if itemid == "advrepairkit" then
        advanced = true
    end

    if targetVehicle ~= 0 then

        local d1,d2 = GetModelDimensions(GetEntityModel(targetVehicle))
        local moveto = GetOffsetFromEntityInWorldCoords(targetVehicle, 0.0,d2["y"]+0.5,0.2)
        local dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
        local count = 1000
        local fueltankhealth = GetVehiclePetrolTankHealth(targetVehicle)

        while dist > 1.5 and count > 0 do
            dist = #(vector3(moveto["x"],moveto["y"],moveto["z"]) - GetEntityCoords(PlayerPedId()))
            Citizen.Wait(1)
            count = count - 1
            DrawText3Ds(moveto["x"],moveto["y"],moveto["z"],"Move here to repair.")
        end

        if reapiring then return end
        reapiring = true
        
        local timeout = 20

        NetworkRequestControlOfEntity(targetVehicle)

        while not NetworkHasControlOfEntity(targetVehicle) and timeout > 0 do 
            NetworkRequestControlOfEntity(targetVehicle)
            Citizen.Wait(100)
            timeout = timeout -1
        end


        if dist < 1.5 then
            TriggerEvent("animation:repair",targetVehicle)
            fixingvehicle = true

            local repairlength = 1000

            if advanced then
                local timeAdded = 0
                for i=0,5 do
                    if IsVehicleTyreBurst(targetVehicle, i, false) then
                        if IsVehicleTyreBurst(targetVehicle, i, true) then
                            timeAdded = timeAdded + 1200
                        else
                           timeAdded = timeAdded + 800
                        end
                    end
                end
                local fuelDamage = 48000 - (math.ceil(fueltankhealth)*12)
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 5) + 2000
                repairlength = repairlength + timeAdded + fuelDamage
            else
                local timeAdded = 0
                for i=0,5 do
                    if IsVehicleTyreBurst(targetVehicle, i, false) then
                        if IsVehicleTyreBurst(targetVehicle, i, true) then
                            timeAdded = timeAdded + 1600
                        else
                           timeAdded = timeAdded + 1200
                        end
                    end
                end
                local fuelDamage = 48000 - (math.ceil(fueltankhealth)*12)
                repairlength = ((3500 - (GetVehicleEngineHealth(targetVehicle) * 3) - (GetVehicleBodyHealth(targetVehicle)) / 2) * 3) + 2000
                repairlength = repairlength + timeAdded + fuelDamage
            end



            local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
            if finished ~= 100 then
                fixingvehicle = false
                reapiring = false
                ClearPedTasks(playerped)
                return
            end

            if finished == 100 then
                
                local myJob = exports["isPed"]:isPed("myJob")
                if myJob == "towtruck" then

                    SetVehicleEngineHealth(targetVehicle, 1000.0)
                    SetVehicleBodyHealth(targetVehicle, 1000.0)
                    SetVehiclePetrolTankHealth(targetVehicle, 4000.0)

                    if math.random(100) > 95 then
                        TriggerEvent("inventory:removeItem","repairtoolkit",1)
                    end

                else

                    TriggerEvent('veh.randomDegredation',30,targetVehicle,3)

                    if advanced then
                        TriggerEvent("inventory:removeItem","advrepairkit", 1)
                        TriggerEvent('veh.randomDegredation',30,targetVehicle,3)
                        if GetVehicleEngineHealth(targetVehicle) < 900.0 then
                            SetVehicleEngineHealth(targetVehicle, 900.0)
                        end
                        if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                            SetVehicleBodyHealth(targetVehicle, 945.0)
                        end

                        if fueltankhealth < 3800.0 then
                            SetVehiclePetrolTankHealth(targetVehicle, 3800.0)
                        end

                    else

                        local timer = math.ceil(GetVehicleEngineHealth(targetVehicle) * 5)
                        if timer < 2000 then
                            timer = 2000
                        end
                        local finished = exports["varial-ui"]:taskBarSkill(math.random(5000,10000),math.random(10,15))
                        if finished ~= 100 then
                            fixingvehicle = false
                            reapiring = false
                            ClearPedTasks(playerped)
                            return
                        end

                        if math.random(100) > 95 then
                            TriggerEvent("inventory:removeItem","repairtoolkit",1)
                        end

                        if GetVehicleEngineHealth(targetVehicle) < 200.0 then
                            SetVehicleEngineHealth(targetVehicle, 200.0)
                        end
                        if GetVehicleBodyHealth(targetVehicle) < 945.0 then
                            SetVehicleBodyHealth(targetVehicle, 945.0)
                        end

                        if fueltankhealth < 2900.0 then
                            SetVehiclePetrolTankHealth(targetVehicle, 2900.0)
                        end                        

                        if GetEntityModel(targetVehicle) == `BLAZER` then
                            SetVehicleEngineHealth(targetVehicle, 600.0)
                            SetVehicleBodyHealth(targetVehicle, 800.0)
                        end
                    end                    
                end

                for i = 0, 5 do
                    SetVehicleTyreFixed(targetVehicle, i) 
                end
            end
            ClearPedTasks(playerped)
        end
        fixingvehicle = false
    end
    reapiring = false
end)

-- Animations
RegisterNetEvent('animation:load')
AddEventHandler('animation:load', function(dict)
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end)

RegisterNetEvent('animation:repair')
AddEventHandler('animation:repair', function(veh)
    SetVehicleDoorOpen(veh, 4, 0, 0)
    RequestAnimDict("mini@repair")
    while not HasAnimDictLoaded("mini@repair") do
        Citizen.Wait(0)
    end

    TaskTurnPedToFaceEntity(PlayerPedId(), veh, 1.0)
    Citizen.Wait(1000)

    while fixingvehicle do
        local anim3 = IsEntityPlayingAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 3)
        if not anim3 then
            TaskPlayAnim(PlayerPedId(), "mini@repair", "fixing_a_player", 8.0, -8, -1, 16, 0, 0, 0, 0)
        end
        Citizen.Wait(1)
    end
    SetVehicleDoorShut(veh, 4, 1, 1)
end)


local Throttles = {}

function Throttled(name, time)
    if not Throttles[name] then
        Throttles[name] = true
        Citizen.SetTimeout(time or 500, function() Throttles[name] = false end)
        return false
    end

    return true
end

local ItemCallbacks = {}

function RegisterItemCallback(itemName, cb)
    ItemCallbacks[itemName] = cb
end

RegisterCommand('+useKeyFob', function()
    if Throttled("varial-doors:doorKeyFob", 1000) then return end
    TriggerEvent("varial-doors:doorKeyFob")
end, false)
RegisterCommand('-useKeyFob', function() end, false)

Citizen.CreateThread(function()
    exports["varial-binds"]:registerKeyMapping("", "Vehicle", "Door Keyfob", "+useKeyFob", "-useKeyFob", "Y")
    TriggerServerEvent("inv:playerSpawned")
    TriggerEvent("closeInventoryGui")
end)

RegisterNetEvent('varial-inventory:shitlord-check')
AddEventHandler('varial-inventory:shitlord-check', function()
    if (not hasEnoughOfItem(GetSelectedPedWeapon(PlayerPedId()),1,false)) then
        SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`, true)
    end
end)