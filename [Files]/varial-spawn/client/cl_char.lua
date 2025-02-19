



--[[
    Functions below: Ped spawning / clothing attachment 
    Description: function spawns and skins the peds acourding to the players chars , this is also where the start of the train spawn takes place 
    along with fetching players char data from DB , clothing data is done before this function.
    This also determains the model for the spawning peds be it the one based on char clothing or a empty ped slot
]]

function Login.CreatePlayerCharacterPeds(characterModelData,isReset)
    if Login.actionsBlocked and not isReset then return end
    Login.actionsBlocked = true
    if not isReset then
        Wait(1000)
        Login.LoadFinished = false
        Login.ClearSpawnedPeds()
        CleanUpArea()
        Wait(1000)
        CleanUpArea()

        while Login.isTrainMoving do
            Wait(10)
        end

        while Login.HasTransistionFinished do
            Wait(10)
        end


    end


    Login.CurrentClothing = characterModelData

    local events = exports["varial-base"]:getModule("Events")
    events:Trigger("varial-base:fetchPlayerCharacters", nil, function(data)
        if data.err then
            return
        end

        local pedCoords = GetEntityCoords(PlayerPedId())
       
        if isReset then
            Login.ClearSpawnedPeds()
        end
        Login.CreatedPeds = {}
        local PlusOneEmpty = false
		
        local noCharacters = true
		
        for _=1,#Login.spawnLoc do
            local isCustom = false
            local character = nil
            local cid = 0


            local cModelHash = GetHashKey("mp_f_freemode_01")
            if data[_] ~= nil then 
                character = data[_]

                local gender = `mp_male`

                if character.gender == 1 then
                    cModelHash = GetHashKey("mp_f_freemode_01")
                    gender = `mp_female`
                else
                    cModelHash = GetHashKey("mp_m_freemode_01")
                    
                end
                
                cid = character.id
               
                if characterModelData[cid] ~= nil then cModelHash = tonumber(characterModelData[cid].model) end
				noCharacters = false
            else
                if math.random(2) == 1 then
                    cModelHash = GetHashKey("mp_f_freemode_01")
                end
            end

            if character == nil and not PlusOneEmpty then
                PlusOneEmpty = _
            end

            Login.RequestModel(cModelHash, function(loaded, model, modelHash)
				SetPedFleeAttributes(created_ped12, 0, 0)

                if loaded then

                    local newPed = nil 
                    
                    if character ~= nil then
                        newPed = CreatePed(3, modelHash,Login.spawnLoc[_].x, Login.spawnLoc[_].y, Login.spawnLoc[_].z, 0.72, false, false)
                        DecorSetBool(newPed, 'ScriptedPed', true)
                    else
                        if PlusOneEmpty == _ then 
                            newPed = CreatePed(3, modelHash,Login.spawnLoc[_].x, Login.spawnLoc[_].y, Login.spawnLoc[_].z, 0.72, false, false)
                            DecorSetBool(newPed, 'ScriptedPed', true)
                        end
                    end

                    
                    if newPed == nil then
                        goto skip_to_next
                    end

                    SetEntityHeading(newPed, Login.spawnLoc[_].w)
                    if character ~= nil and characterModelData[cid] ~= nil and characterModelData[cid] ~= {} and not isCustom then
                        Login.LoadPed(newPed, characterModelData[cid], modelHash)
                    end

                    if not isCustom then
                        if modelHash == GetHashKey("mp_f_freemode_01") or modelHash == GetHashKey("mp_m_freemode_01") then
                            if character ~= nil then
                                -- SetEntityAlpha(newPed,200,false)
                            else
                                SetEntityAlpha(newPed,0.9,false)
                            end
                     end
                    end

                    TaskLookAtCoord(newPed, vector3(-197.75,-1002.46,28.15 ),-1, 0, 2)
                    FreezeEntityPosition(newPed, true)
                    SetEntityInvincible(newPed, true)
                    SetBlockingOfNonTemporaryEvents(newPed, true)

                    Login.currentProtected[newPed] = true

                    if character ~= nil then
                        Login.CreatedPeds[_] = {
                            pedObject = newPed,
                            charId = cid,
                            posId = _
                        }
                    else
                        Login.CreatedPeds[_] = {
                            pedObject = newPed,
                            charId = 0,
                            posId = _
                        }
                    end

                    ::skip_to_next::
                end
            end)
        end


        Wait(600)
        SetNuiFocus(true, true)
        SendNUIMessage({
            open = true,
           chars = data
        })
		
		--If no characters, open Creation menu
        if noCharacters then
            SendNUIMessage({ firstOpen = true })
        end
    end)

    Login.actionsBlocked = false
end

RegisterNetEvent("login:CreatePlayerCharacterPeds")
AddEventHandler("login:CreatePlayerCharacterPeds", Login.CreatePlayerCharacterPeds)


--[[
    Functions below: base attachment
    Description: dealing with varial-base functionality in order to set/get the correct information for chars
]]



function Login.getCharacters(isReset)
    local events = exports["varial-base"]:getModule("Events")
    
    if not isReset then
        TransitionFromBlurred(500)
        events:Trigger("varial-base:loginPlayer", nil, function(data)
            if type(data) == "table" and data.err then
                return
            end
        end)
    end

    events:Trigger("varial-base:fetchPlayerCharacters", nil, function(data)
        if data.err then
            -- print"Found error in getting player Char")
            return
        end

        local charIds = {}

        for k,v in ipairs(data) do
            charIds[#charIds + 1] = v.id
        end

        TriggerServerEvent("login:getCharModels", charIds, isReset)
    end)
end

function Login.SelectedChar(data)

	Login.ClearSpawnedPeds()
	TriggerEvent("character:PlayerSelectedCharacter")
	local events = exports["varial-base"]:getModule("Events")
	events:Trigger("varial-base:selectCharacter", data.actionData, function(returnData)
       
        if not returnData.loggedin or not returnData.chardata then sendMessage({err = {err = true, msg = "There was a problem logging in as that character, if the problem persists, contact an administrator <br/> Cid: " .. tostring(data.selectcharacter)}}) return end

        local LocalPlayer = exports["varial-base"]:getModule("LocalPlayer")
        LocalPlayer:setCurrentCharacter(returnData.chardata)
       	
        if Login.CurrentClothing[data.actionData] == nil then
        	Login.setClothingForChar()
        else
	        SetPlayerInvincible(PlayerPedId(), true)
	        TriggerEvent("varial-base:firstSpawn")
	    end
    end)
end

function Login.setClothingForChar()
    Login.actionsBlocked = true

    SendNUIMessage({
      close = true
    })

    
    SetEntityVisible(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), -1081.5032958984,-248.45274353027,43.006591796875)
    SetEntityHeading(PlayerPedId(),249.44882202148)
    SetGameplayCamRelativeHeading(249.44882202148)
    SetGameplayCamRelativePitch(8.0, 3.0)

    for i=1,25 do
      local posoffset = GetCamCoord(LoginSafe.Cam)
      local setpos = VecLerp(posoffset.x,posoffset.y,posoffset.z, -1078.50,-248.50, 45.055854797363, i/200, true)
      SetCamCoord(LoginSafe.Cam, setpos)
      Wait(15)
    end


    Citizen.Wait(5000)

    Login.Open = false
    local LocalPlayer = exports["varial-base"]:getModule("LocalPlayer")
    local gender = LocalPlayer:getCurrentCharacter().gender

    if gender ~= 0 then
        SetSkin(GetHashKey("mp_f_freemode_01"), true)
    else
        SetSkin(GetHashKey("mp_m_freemode_01"), true)
    end

    TriggerEvent("raid_clothes:openClothing")
    TriggerEvent("raid_clothes:inSpawn", true)

    ChoosingClothes = true

    -- SetEntityHeading(PlayerPedId(),249.44882202148)
    
    -- SetGameplayCamRelativeHeading(180.0)

    -- SetGameplayCamRelativePitch(8.0, 3.0)
end

function backToMenu()
    Login.actionsBlocked = false
	SetCamActive(LoginSafe.Cam, true)
	RenderScriptCams(true, false, 0, true, true)
	Login.nativeStart(true)
end

function spawnChar()
    Login.actionsBlocked = false
    
    SetPlayerInvincible(PlayerPedId(), true)
    TriggerEvent("varial-base:firstSpawn")

    SendNUIMessage({
        default = true
    })

    Login.Selected = false
    Login.CurrentPedInfo = nil
    Login.CurrentPed = nil
    Login.CreatedPeds = {}
end


RegisterNetEvent("character:finishedLoadingChar")
AddEventHandler("character:finishedLoadingChar", function()
    Login.characterLoaded()
end)

RegisterNetEvent("spawn:destroycams")
AddEventHandler("spawn:destroycams", function()
    DestroyAllCams(true)
    SetCamActive(LoginSafe.Cam, false)
end)


RegisterNetEvent("varial-spawn:finishedClothing")
AddEventHandler("varial-spawn:finishedClothing", function(endType)
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local pos = vector3(-1079.5252685547,-249.13845825195,44.006591796875)
    local distance = #(playerCoords - pos)

    TriggerEvent("raid_clothes:inSpawn", false)
    if distance <= 10 then
        SetEntityVisible(PlayerPedId(), false)
        if ChoosingClothes then
            ChoosingClothes = false
            if endType == "Finished" then
                SetEntityVisible(PlayerPedId(), true)
                FreezeEntityPosition(PlayerPedId(), false)
                SetNuiFocus(false, false)
                EnableAllControlActions(0)
                Login.DeleteCamera()
                SetPlayerInvincible(PlayerId(), false)
                spawnChar()
            else
                backToMenu()
            end
        end
    end	
end)
