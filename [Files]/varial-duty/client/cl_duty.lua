-- Police Duty --

local PDService = false
local SASPService = false
local BCSOService = false
local DOCService = false

RegisterCommand('duty', function()
	TriggerEvent('varial-duty:PoliceMenu')
end)

RegisterNetEvent('varial-duty:PoliceMenu')
AddEventHandler('varial-duty:PoliceMenu', function()

	local menuData = {
		{
            title = "State Police",
            description = "Sign On/Off Duty",
            key = "EVENTS.SASP",
			children = {
				{ title = "Sign On Duty", action = "varial-duty:OnDutyHP", key = "EVENTS.SASP" },
				{ title = "Sign Off Duty", action = "varial-duty:OffDutyHP", key = "EVENTS.SASP" },
            },
        },
        {
            title = "Police",
            description = "Sign On/Off Duty",
            key = "EVENTS.POLICE",
			children = {
				{ title = "Sign On Duty", action = "varial-duty:OnDutyPD", key = "EVENTS.POLICE" },
				{ title = "Sign Off Duty", action = "varial-duty:OffDutyPD", key = "EVENTS.POLICE" },
            },
        },
        {
            title = "Sheriff",
            description = "Sign On/Off Duty",
            key = "EVENTS.SHERIFF",
			children = {
				{ title = "Sign On Duty", action = "varial-duty:OnDutySH", key = "EVENTS.SHERIFF" },
				{ title = "Sign Off Duty", action = "varial-duty:OffDutySH", key = "EVENTS.SHERIFF" },
            },
        },
		{
            title = "DOC",
            description = "Sign On/Off Duty",
            key = "EVENTS.DOC",
			children = {
				{ title = "Sign On Duty", action = "varial-duty:OnDutyDOC", key = "EVENTS.DOC" },
				{ title = "Sign Off Duty", action = "varial-duty:OffDutyDOC", key = "EVENTS.DOC" },
            },
        },
    }
    exports["varial-context"]:showContext(menuData)
end)

AddEventHandler("varial-duty:OnDutyPD", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if PDService == false then
		TriggerServerEvent('varial-duty:AttemptDuty', 'police')
		TriggerEvent('varial-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

AddEventHandler("varial-duty:OffDutyPD", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if PDService == true then
		PDService = false
		TriggerEvent('varial-clothing:inService', false)
		exports['varial-voice']:removePlayerFromRadio()
		exports["varial-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyComplete', 'police')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

-- Sheriff

AddEventHandler("varial-duty:OnDutySH", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if BCSOService == false then
		TriggerServerEvent('varial-duty:AttemptDuty', 'sheriff')
		TriggerEvent('varial-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

AddEventHandler("varial-duty:OffDutySH", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if BCSOService == true then
		BCSOService = false
		TriggerEvent('varial-clothing:inService', false)
		exports['varial-voice']:removePlayerFromRadio()
		exports["varial-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyComplete', 'sheriff')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

-- State

AddEventHandler("varial-duty:OnDutyHP", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if SASPService == false then
		TriggerServerEvent('varial-duty:AttemptDuty', 'state')
		TriggerEvent('varial-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

AddEventHandler("varial-duty:OffDutyHP", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if SASPService == true then
		SASPService = false
		TriggerEvent('varial-clothing:inService', false)
		exports['varial-voice']:removePlayerFromRadio()
		exports["varial-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyComplete', 'state')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

-- DOC

AddEventHandler("varial-duty:OnDutyDOC", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if DOCService == false then
		TriggerServerEvent('varial-duty:AttemptDuty', 'doc')
		TriggerEvent('varial-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

AddEventHandler("varial-duty:OffDutyDOC", function(data, cb)
	-- cb({ data = {}, meta = { ok = true, message = 'done' } })
	exports["varial-ui"]:hideContextMenu()
	if DOCService == true then
		DOCService = false
		TriggerEvent('varial-clothing:inService', false)
		exports['varial-voice']:removePlayerFromRadio()
		exports["varial-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("police:noLongerCop")
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyComplete', 'doc')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You wasnt on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:PDSuccess')
AddEventHandler('varial-duty:PDSuccess', function()
	if PDService == false then
		exports["varial-voice"]:setVoiceProperty("radioEnabled", true)
		exports['varial-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		PDService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:BCSOSuccess')
AddEventHandler('varial-duty:BCSOSuccess', function()
	if BCSOService == false then
		exports["varial-voice"]:setVoiceProperty("radioEnabled", true)
		exports['varial-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		BCSOService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:SASPSuccess')
AddEventHandler('varial-duty:SASPSuccess', function()
	if SASPService == false then
		exports["varial-voice"]:setVoiceProperty("radioEnabled", true)
		exports['varial-voice']:addPlayerToRadio(1)
		TriggerEvent('radio:SetRadioStatus', true)
		SASPService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:DOCSuccess')
AddEventHandler('varial-duty:DOCSuccess', function()
	if DOCService == false then
		exports["varial-voice"]:setVoiceProperty("radioEnabled", true)
		exports['varial-voice']:addPlayerToRadio(3)
		TriggerEvent('radio:SetRadioStatus', true)
		DOCService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- EMS Duty --

local EMSService = false


AddEventHandler("varial-duty:EMSMenu", function()
	exports["varial-context"]:showContext(MenuData["ems_duty"])
end)

RegisterNetEvent('varial-duty:OnDutyEMS')
AddEventHandler('varial-duty:OnDutyEMS', function()
	if EMSService == false then
		TriggerServerEvent('varial-duty:AttemptDutyEMS')
		TriggerEvent('varial-clothing:inService', true)
		TriggerServerEvent('dispatch:setcallsign')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyEMS')
AddEventHandler('varial-duty:OffDutyEMS', function()
	if EMSService == true then
		EMSService = false
		TriggerEvent('varial-clothing:inService', false)
		exports['varial-voice']:removePlayerFromRadio()
		exports["varial-voice"]:setVoiceProperty("radioEnabled", false)
		TriggerEvent('radio:SetRadioStatus', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyCompleteEMS')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:EMSSuccess')
AddEventHandler('varial-duty:EMSSuccess', function()
	if EMSService == false then
		exports["varial-voice"]:setVoiceProperty("radioEnabled", true)
		exports['varial-voice']:addPlayerToRadio(2)
		TriggerEvent('radio:SetRadioStatus', true)
		EMSService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Suits Duty ----------------------------------------------------------------

local SuitsService = false

RegisterNetEvent('varial-duty:SuitsMenu')
AddEventHandler('varial-duty:SuitsMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutySuits"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutySuits"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutySuits')
AddEventHandler('varial-duty:OnDutySuits', function()
	if SuitsService == false then
		TriggerServerEvent('varial-duty:AttemptDutySuits')
		TriggerEvent('varial-clothing:inService', true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutySuits')
AddEventHandler('varial-duty:OffDutySuits', function()
	if SuitsService == true then
		SuitsService = false
		TriggerEvent('varial-clothing:inService', false)
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerServerEvent('myskin_customization:wearSkin')
		TriggerServerEvent('tattoos:retrieve')
		TriggerServerEvent('Blemishes:retrieve')
		TriggerEvent("logoffmedic")		
		TriggerEvent("loggedoff")					
		TriggerEvent('nowCopSpawnOff')
		TriggerEvent('nowMedicOff')
		SetPedRelationshipGroupHash(PlayerPedId(),`PLAYER`)
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`PLAYER`)
		SetPoliceIgnorePlayer(PlayerPedId(),false)
		TriggerServerEvent('varial-duty:OffDutyCompleteSuits')
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:SuitsSuccess')
AddEventHandler('varial-duty:SuitsSuccess', function()
	if SuitsService == false then
		SuitsService = true
		TriggerEvent('nowCop')
		TriggerEvent('nowService')
		TriggerEvent('nowCopHud')
		TriggerEvent('nowCopDeath')
		TriggerEvent('nowCopSpawn')
		TriggerEvent('nowMedic')
		SetPedRelationshipGroupDefaultHash(PlayerPedId(),`MISSION2`)
		SetPedRelationshipGroupHash(PlayerPedId(),`MISSION2`)
		SetPoliceIgnorePlayer(PlayerPedId(),true)
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Judge Duty ------------------------------------------------------------

local JudgeService = false

RegisterNetEvent('varial-duty:JudgeMenu')
AddEventHandler('varial-duty:JudgeMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyJudge"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyJudge"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyJudge')
AddEventHandler('varial-duty:OnDutyJudge', function()
	if JudgeService == false then
		TriggerServerEvent('varial-duty:AttemptDutyJudge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyJudge')
AddEventHandler('varial-duty:OffDutyJudge', function()
	if JudgeService == true then
		JudgeService = false
		TriggerServerEvent('varial-duty:OffDutyCompleteEMS')
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:JudgeSuccess')
AddEventHandler('varial-duty:JudgeSuccess', function()
	if JudgeService == false then
		JudgeService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- DA Duty --

local DAService = false

RegisterNetEvent('varial-duty:DAMenu')
AddEventHandler('varial-duty:DAMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyDA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyDA"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyDA')
AddEventHandler('varial-duty:OnDutyDA', function()
	if DAService == false then
		TriggerServerEvent('varial-duty:AttemptDutyDA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyDA')
AddEventHandler('varial-duty:OffDutyDA', function()
	if DAService == true then
		DAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:DASuccess')
AddEventHandler('varial-duty:DASuccess', function()
	if DAService == false then
		DAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Public Duty --

local PublicService = false

RegisterNetEvent('varial-duty:PublicMenu')
AddEventHandler('varial-duty:PublicMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyPublic"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyPublic"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyPublic')
AddEventHandler('varial-duty:OnDutyPublic', function()
	if PublicService == false then
		TriggerServerEvent('varial-duty:AttemptDutyPublic')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyPublic')
AddEventHandler('varial-duty:OffDutyPublic', function()
	if PublicService == true then
		PublicService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:PublicSuccess')
AddEventHandler('varial-duty:PublicSuccess', function()
	if PublicService == false then
		PublicService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- ADA Duty --

local ADAService = false

RegisterNetEvent('varial-duty:ADAMenu')
AddEventHandler('varial-duty:ADAMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyADA"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyADA"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyADA')
AddEventHandler('varial-duty:OnDutyADA', function()
	if PublicService == false then
		TriggerServerEvent('varial-duty:AttemptDutyADA')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyADA')
AddEventHandler('varial-duty:OffDutyADA', function()
	if ADAService == true then
		ADAService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:ADASuccess')
AddEventHandler('varial-duty:ADASuccess', function()
	if ADAService == false then
		ADAService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- PDM Duty --

local PDMService = false

RegisterNetEvent('varial-duty:PDMMenu')
AddEventHandler('varial-duty:PDMMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyPDM"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyPDM"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyPDM')
AddEventHandler('varial-duty:OnDutyPDM', function()
	if PDMService == false then
		TriggerServerEvent('varial-duty:AttemptDutyPDM')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyPDM')
AddEventHandler('varial-duty:OffDutyPDM', function()
	if PDMService == true then
		PDMService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:PDMSuccess')
AddEventHandler('varial-duty:PDMSuccess', function()
	if PDMService == false then
		PDMService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local SandersService = false

RegisterNetEvent('varial-duty:SandersMenu')
AddEventHandler('varial-duty:SandersMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutySanders"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutySanders"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutySanders')
AddEventHandler('varial-duty:OnDutySanders', function()
	if SandersService == false then
		TriggerServerEvent('varial-duty:AttemptDutySanders')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutySanders')
AddEventHandler('varial-duty:OffDutySanders', function()
	if SandersService == true then
		SandersService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:SandersSuccess')
AddEventHandler('varial-duty:SandersSuccess', function()
	if SandersService == false then
		SandersService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

-- Sanders Duty --

local TowService = false

RegisterNetEvent('varial-duty:TowMenu')
AddEventHandler('varial-duty:TowMenu', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:OnDutyTow"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:OffDutyTow"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:OnDutyTow')
AddEventHandler('varial-duty:OnDutyTow', function()
	if TowService == false then
		TriggerServerEvent('varial-duty:AttemptDutyTow')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffDutyTow')
AddEventHandler('varial-duty:OffDutyTow', function()
	if TowService == true then
		TowService = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:TowSuccess')
AddEventHandler('varial-duty:TowSuccess', function()
	if TowService == false then
		TowService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterCommand('pdduty', function()
	TriggerEvent('varial-duty:OnDuty')
end)
RegisterCommand('pddutyoff', function()
	TriggerEvent('varial-duty:OffDuty')
end)

-- In N Out Duty --

local ClockedOnAsInNOut = false

RegisterNetEvent('varial-duty:in-n-out:clockin')
AddEventHandler('varial-duty:in-n-out:clockin', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "Sign In / Off ",
            txt = ""
        },
        {
            id = 2,
            header = "Signing On Duty",
			txt = "Use this to sign in",
			params = {
                event = "varial-duty:on-in-n-out"
            }
        },
		{
            id = 3,
            header = "Signing Off Duty",
			txt = "Use this to sign off",
			params = {
                event = "varial-duty:off-duty-in-n-out"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:on-in-n-out')
AddEventHandler('varial-duty:on-in-n-out', function()
	if ClockedOnAsInNOut == false then
		TriggerServerEvent('varial-duty:attempt-in-n-out:duty')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:off-duty-in-n-out')
AddEventHandler('varial-duty:off-duty-in-n-out', function()
	if ClockedOnAsInNOut == true then
		ClockedOnAsInNOut = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:in-n-out:successful')
AddEventHandler('varial-duty:in-n-out:successful', function()
	if ClockedOnAsInNOut == false then
		ClockedOnAsInNOut = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

curPolice = 0

RegisterNetEvent('job:policecount')
AddEventHandler('job:policecount', function(pAmount)
	curPolice = pAmount
end)

function LawAmount()
	return curPolice
end

-- DOJ Duty --

local ClockedInAsJudge = false

local ClockedInAsPublicDefender = false

local ClockedInAsDistrictAttorney = false

RegisterNetEvent('varial-duty:doj_board')
AddEventHandler('varial-duty:doj_board', function()
	TriggerEvent('varial-context:sendMenu', {
        {
            id = 1,
            header = "DOJ Duty Board",
            txt = ""
        },
        {
            id = 2,
            header = "Judge Duty",
			txt = "Use this to sign in as a judge !",
			params = {
                event = "varial-duty:clock_in:judge_context"
            }
        },
		{
            id = 3,
            header = "Public Defender Duty",
			txt = "Use this to sign in as a Public Defender",
			params = {
				event = "varial-duty:clock_in:public_defender_context"
            }
        },
		{
            id = 4,
            header = "District Attorney Duty",
			txt = "Use this to sign in as a District Attorney",
			params = {
				event = "varial-duty:clock_in:district_attorney_context"
            }
        },
    })
end)

-- Judge --

RegisterNetEvent('varial-duty:clock_in:judge_context')
AddEventHandler('varial-duty:clock_in:judge_context', function()
	TriggerEvent('varial-context:sendMenu', {
		{
            id = 1,
            header = "< Go Back",
			txt = "",
			params = {
                event = "varial-duty:doj_board"
            }
        },
        {
            id = 2,
            header = "Sign In",
			txt = "",
			params = {
                event = "varial-duty:clock_in:judge"
            }
        },
		{
            id = 3,
            header = "Sign Out",
			txt = "",
			params = {
				event = "varial-duty:clock_out:judge"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:clock_in:judge')
AddEventHandler('varial-duty:clock_in:judge', function()
	if ClockedInAsJudge == false then
		TriggerServerEvent('varial-duty:attempt_duty:judge')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:clock_out:judge')
AddEventHandler('varial-duty:clock_out:judge', function()
	if ClockedInAsJudge == true then
		ClockedInAsJudge = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a Judge', 2)
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a Judge', 2)
	end
end)

RegisterNetEvent('varial-duty:clocked_in:judge_successful')
AddEventHandler('varial-duty:clocked_in:judge_successful', function()
	if ClockedInAsJudge == false then
		ClockedInAsJudge = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a Judge', 2)
	end
end)

-- Public Defender --

RegisterNetEvent('varial-duty:clock_in:public_defender_context')
AddEventHandler('varial-duty:clock_in:public_defender_context', function()
	TriggerEvent('varial-context:sendMenu', {
		{
            id = 1,
            header = "< Go Back",
			txt = "",
			params = {
                event = "varial-duty:doj_board"
            }
        },
        {
            id = 2,
            header = "Sign In",
			txt = "",
			params = {
                event = "varial-duty:clock_in:public_defender"
            }
        },
		{
            id = 3,
            header = "Sign Out",
			txt = "",
			params = {
				event = "varial-duty:clock_out:public_defender"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:clock_in:public_defender')
AddEventHandler('varial-duty:clock_in:public_defender', function()
	if ClockedInAsPublicDefender == false then
		TriggerServerEvent('varial-duty:attempt_duty:public_defender')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:clock_out:public_defender')
AddEventHandler('varial-duty:clock_out:public_defender', function()
	if ClockedInAsPublicDefender == true then
		ClockedInAsPublicDefender = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a Public Defender', 2)
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a Public Defender', 2)
	end
end)

RegisterNetEvent('varial-duty:clocked_in:public_defender_successful')
AddEventHandler('varial-duty:clocked_in:public_defender_successful', function()
	if ClockedInAsPublicDefender == false then
		ClockedInAsPublicDefender = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a Public Defender', 2)
	end
end)

-- District Attorney --

RegisterNetEvent('varial-duty:clock_in:district_attorney_context')
AddEventHandler('varial-duty:clock_in:district_attorney_context', function()
	TriggerEvent('varial-context:sendMenu', {
		{
            id = 1,
            header = "< Go Back",
			txt = "",
			params = {
                event = "varial-duty:doj_board"
            }
        },
        {
            id = 2,
            header = "Sign In",
			txt = "",
			params = {
                event = "varial-duty:clock_in:district_attorney"
            }
        },
		{
            id = 3,
            header = "Sign Out",
			txt = "",
			params = {
				event = "varial-duty:clock_out:district_attorney"
            }
        },
    })
end)

RegisterNetEvent('varial-duty:clock_in:district_attorney')
AddEventHandler('varial-duty:clock_in:district_attorney', function()
	if ClockedInAsDistrictAttorney == false then
		TriggerServerEvent('varial-duty:attempt_duty:district_attorney')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:clock_out:district_attorney')
AddEventHandler('varial-duty:clock_out:district_attorney', function()
	if ClockedInAsDistrictAttorney == true then
		ClockedInAsDistrictAttorney = false
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed out. You are no longer a District Attorney', 2)
	else
		TriggerEvent("DoLongHudText",'You was never clocked in as a District Attorney', 2)
	end
end)

RegisterNetEvent('varial-duty:clocked_in:district_attorney_successful')
AddEventHandler('varial-duty:clocked_in:district_attorney_successful', function()
	if ClockedInAsDistrictAttorney == false then
		ClockedInAsDistrictAttorney = true
	else
		TriggerEvent("DoLongHudText",'You are already clocked in as a District Attorney', 2)
	end
end)



-- Auto Exotic ------------------------------------------------------------


RegisterNetEvent('varial-duty:AutoExoticsMenu')
AddEventHandler('varial-duty:AutoExoticsMenu', function()

	local menuData = {
		{
            title = "Auto Exotic",
            description = "Sign On/Off Duty",
            key = "EVENTS.SASP",
			children = {
				{ title = "Sign On Duty", action = "varial-duty:OnDutyAutoExotics", },
				{ title = "Sign Off Duty", action = "varial-duty:OffAutoExotics", },
            },
        },
    }
    exports["varial-context"]:showContext(menuData)
end)
local AutoExoticsService = false


RegisterNetEvent('varial-duty:OnDutyAutoExotics')
AddEventHandler('varial-duty:OnDutyAutoExotics', function()
	if AutoExoticsService == false then
		TriggerServerEvent('varial-duty:AttemptDutyAutoExotics')
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)

RegisterNetEvent('varial-duty:OffAutoExotics')
AddEventHandler('varial-duty:OffAutoExotics', function()
	if AutoExoticsService == true then
		AutoExoticsService = false
		
		TriggerServerEvent("jobssystem:jobs", "unemployed")
		TriggerEvent("DoLongHudText",'Signed off Duty!',1)
	else
		TriggerEvent("DoLongHudText",'You are not on duty!', 2)
	end
end)

RegisterNetEvent('varial-duty:AutoExoticsSuccess')
AddEventHandler('varial-duty:AutoExoticsSuccess', function()
	if AutoExoticsService == false then
		AutoExoticsService = true
	else
		TriggerEvent("DoLongHudText",'You are on duty already!', 2)
	end
end)