local currentCops = 0
local currentEMS = 0

RegisterServerEvent('varial-duty:AttemptDuty')
AddEventHandler('varial-duty:AttemptDuty', function(pJobType)
	local src = source
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	local job = pJobType
	exports.oxmysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		jobs:SetJob(user, job, false, function()
			if result[1].callsign ~= nil then
				pCallSign = result[1].callsign
			else
				pCallSign = "000"
			end
			if pJobType == 'police' then
				TriggerClientEvent('varial-duty:PDSuccess', src)
				TriggerClientEvent("DoLongHudText", src,"10-41 and Restocked.",17)
				TriggerClientEvent("startSpeedo",src)
				currentCops = currentCops + 1
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('varial-eblips:server:registerPlayerBlipGroup', src, job)
				TriggerEvent('varial-eblips:server:registerSourceName', src, pCallSign .." | ".. character.first_name .." ".. character.last_name)
			elseif pJobType == 'sheriff' then
				TriggerClientEvent('varial-duty:BCSOSuccess', src)
				TriggerClientEvent("DoLongHudText", src,"10-41 and Restocked.",17)
				TriggerClientEvent("startSpeedo",src)
				currentCops = currentCops + 1
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('varial-eblips:server:registerPlayerBlipGroup', src, job)
				TriggerEvent('varial-eblips:server:registerSourceName', src, pCallSign .." | ".. character.first_name .." ".. character.last_name)
			elseif pJobType == 'state' then
				TriggerClientEvent('varial-duty:SASPSuccess', src)
				TriggerClientEvent("DoLongHudText", src,"10-41 and Restocked.",17)
				TriggerClientEvent("startSpeedo",src)
				currentCops = currentCops + 1
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('varial-eblips:server:registerPlayerBlipGroup', src, job)
				TriggerEvent('varial-eblips:server:registerSourceName', src, pCallSign .." | ".. character.first_name .." ".. character.last_name)
			elseif pJobType == 'doc' then
				TriggerClientEvent('varial-duty:DOCSuccess', src)
				TriggerClientEvent("DoLongHudText", src,"10-41 and Restocked.",17)
				TriggerClientEvent("startSpeedo",src)
				currentCops = currentCops + 1
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('varial-eblips:server:registerPlayerBlipGroup', src, job)
				TriggerEvent('varial-eblips:server:registerSourceName', src, pCallSign .." | ".. character.first_name .." ".. character.last_name)
			end
		end)
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyEMS')
AddEventHandler('varial-duty:AttemptDutyEMS', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	local job = pJobType and pJobType or 'ems'
	exports.oxmysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		jobs:SetJob(user, job, false, function()
			TriggerClientEvent('varial-duty:EMSSuccess', src)
			TriggerClientEvent("DoLongHudText", src,"On-Duty.",17)
			currentEMS = currentEMS + 1
			TriggerClientEvent("job:emscount", -1, currentEMS)
			TriggerEvent('varial-eblips:server:registerPlayerBlipGroup', src, 'ems')
			TriggerEvent('varial-eblips:server:registerSourceName', src, result[1].callsign .." | ".. character.first_name .." ".. character.last_name)
		end)
	end)
end)

RegisterServerEvent('varial-duty:OffDutyComplete')
AddEventHandler('varial-duty:OffDutyComplete', function(pJobType)
	print(pJobType)
	if currentCops ~= 0 then
		currentCops = currentCops - 1
	else
		currentCops = 0
	end
	TriggerClientEvent("job:policecount", -1, currentCops)
	TriggerEvent('varial-eblips:server:removePlayerBlipGroup', source, pJobType)
end)

RegisterServerEvent('varial-duty:OffDutyCompleteEMS')
AddEventHandler('varial-duty:OffDutyCompleteEMS', function()
	if currentEMS ~= 0 then
		currentEMS = currentEMS - 1
	else
		currentEMS = 0
	end
	TriggerClientEvent("job:emscount", -1, currentEMS)
	TriggerEvent('varial-eblips:server:removePlayerBlipGroup', source, 'ems')
end)

RegisterServerEvent('varial-duty:AttemptDutyJudge')
AddEventHandler('varial-duty:AttemptDutyJudge', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'judge'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'judge', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:JudgeSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyDA')
AddEventHandler('varial-duty:AttemptDutyDA', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'da'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'da', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:DASuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyPublic')
AddEventHandler('varial-duty:AttemptDutyPublic', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'defender'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'defender', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:PublicSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyADA')
AddEventHandler('varial-duty:AttemptDutyADA', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'ada'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'ada', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:ADASuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyPDM')
AddEventHandler('varial-duty:AttemptDutyPDM', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'pdm'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'pdm', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:PDMSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutySanders')
AddEventHandler('varial-duty:AttemptDutySanders', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'sanders'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'sanders', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:SandersSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

RegisterServerEvent('varial-duty:AttemptDutyTow')
AddEventHandler('varial-duty:AttemptDutyTow', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'towunion'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'towunion', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:TowSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)

AddEventHandler('playerDropped', function()
	local src = source
	if src ~= nil then
		local steamIdentifier = GetPlayerIdentifiers(src)[1]
		exports.oxmysql:execute('SELECT * FROM characters WHERE owner = ?', {steamIdentifier}, function(result)
			if result[1].job == 'police' or result[1].job == 'sheriff' or result[1].job == 'state' then
				if currentCops ~= 0 then
					currentCops = currentCops - 1
				else
					currentCops = 0
				end
                print('Active PD:', currentCops)
                exports.oxmysql:execute("UPDATE characters SET `job` = @job WHERE `owner` = @owner", {['@owner'] = steamIdentifier, ['@job'] = 'unemployed'})
				TriggerClientEvent("job:policecount", -1, currentCops)
				TriggerEvent('varial-eblips:server:removePlayerBlipGroup', src, 'police')
				TriggerClientEvent('varial-duty:OffDuty' ,src)
            elseif result[1].job == 'ems' then
                if currentEMS ~= 0 then
					currentEMS = currentEMS - 1
				else
					currentEMS = 0
				end
                print('Active EMS:', currentEMS)
				TriggerClientEvent('varial-duty:OffDutyEMS' ,src)
                exports.oxmysql:execute("UPDATE characters SET `job` = @job WHERE `owner` = @owner", {['@owner'] = steamIdentifier, ['@job'] = 'unemployed'})
				TriggerClientEvent("job:emscount", -1, currentEMS)
				TriggerEvent('varial-eblips:server:removePlayerBlipGroup', src, 'ems')
			end
		end)
	end
end)


function SignOnRadio(src)

	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()

	local q = [[SELECT id, cid, job, callsign, rank FROM jobs_whitelist WHERE cid = @cid AND (job = 'police' or job = 'doc')]]
	local v = {["cid"] = char.id}

	exports.oxmysql:execute(q, v, function(results)
		if not results then return end
		local callsign = ""
		if results[1].callsign ~= nil and results[1].callsign == "" then callsign = results[1].callsign else callsign = "TBD" end
		if (src ~= nil and char.first_name ~= nil and char.last_name ~= nil) then
			TriggerClientEvent("DoLongHudText", "Sessioned!?", 2)
		else
			TriggerClientEvent("SignOnRadio", src)
		end
	end)
end

RegisterServerEvent('varial-duty:AttemptDutySuits')
AddEventHandler('varial-duty:AttemptDutySuits', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	local job = pJobType and pJobType or 'suits'
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result)
		if result[1].job == "suits" then
			exports.oxmysql:execute('SELECT callsign FROM jobs_whitelist WHERE cid = ?', {character.id}, function(result2)
				jobs:SetJob(user, job, false, function()
					TriggerClientEvent('varial-duty:SuitsSuccess', src)
					TriggerClientEvent("DoLongHudText", src,"On-Duty.",17)
					TriggerClientEvent("job:suitscount", -1, currentSuits)
				end)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,'You are not qualified for this', 2)
		end
	end)
end)

--// In N Out

RegisterServerEvent('varial-duty:attempt-in-n-out:duty')
AddEventHandler('varial-duty:attempt-in-n-out:duty', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'in-n-out'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'in-n-out', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clocked In As In N Out", 1)
				TriggerClientEvent('varial-duty:in-n-out:successful', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src, "You are not whitelisted for this job!", 2)
		end
	end)
end)

--// DOJ

-- Judge

RegisterServerEvent('varial-duty:attempt_duty:judge')
AddEventHandler('varial-duty:attempt_duty:judge', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'judge'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'judge', false, function()
				TriggerClientEvent("DoLongHudText", src,"Successfully Clocked In As Judge", 1)
				TriggerClientEvent('varial-duty:clocked_in:judge_successful', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src, "You are not whitelisted for this job!", 2)
		end
	end)
end)

-- Public Defender

RegisterServerEvent('varial-duty:attempt_duty:public_defender')
AddEventHandler('varial-duty:attempt_duty:public_defender', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'public_defender'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'public_defender', false, function()
				TriggerClientEvent("DoLongHudText", src,"Successfully Clocked In As Public Defender", 1)
				TriggerClientEvent('varial-duty:clocked_in:public_defender_successful', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src, "You are not whitelisted for this job!", 2)
		end
	end)
end)

-- District Attorney

RegisterServerEvent('varial-duty:attempt_duty:district_attorney')
AddEventHandler('varial-duty:attempt_duty:district_attorney', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'district_attorney'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'district_attorney', false, function()
				TriggerClientEvent("DoLongHudText", src,"Successfully Clocked In As District Attorney", 1)
				TriggerClientEvent('varial-duty:clocked_in:district_attorney_successful', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src, "You are not whitelisted for this job!", 2)
		end
	end)
end)

----------------------------------------------------------------------------------------------------------------------------------

-- PD

RegisterCommand('hirepd', function(source, args)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	if GetPlayerIdentifier(source) == 'steam:110000135ce0334' or 'steam:110000142b5b05b' or 'steam:11000010a65b9f0' then
		exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
			if result[1].job == 'police' or result[1].job == 'state' or result[1].job == 'sheriff' and result[1].rank >= 3 then
				TriggerClientEvent('varial-duty:HireLaw:Menu', src)
			end
		end)
	else
		TriggerClientEvent('DoLongHudText', src, 'You cant use this', 2)
	end
end)

RegisterCommand('firepd', function(source, args)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	if GetPlayerIdentifier(source) == 'steam:110000135ce0334' or 'steam:110000142b5b05b' or 'steam:11000010a65b9f0' then
		exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
			if result[1].job == 'police' or result[1].job == 'state' or result[1].job == 'sheriff' and result[1].rank >= 3 then
				TriggerClientEvent('varial-duty:FireLaw:Menu', src)
			end
		end)
	else
		TriggerClientEvent('DoLongHudText', src, 'You cant use this', 2)
	end
end)

-- EMS

RegisterCommand('hireems', function(source, args)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	if GetPlayerIdentifier(source) == 'steam:110000119376390' then
		exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
			if result[1].job == 'ems' and result[1].rank >= 3 then
				TriggerClientEvent('varial-duty:HireEMS:Menu', src)
			end
		end)
	else
		TriggerClientEvent('varial-duty:HireEMS:Menu', src)
	end
end)

RegisterCommand('fireems', function(source, args)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local cid = user:getCurrentCharacter().id
	if GetPlayerIdentifier(source) == 'steam:110000119376390' then
		exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = ?', {cid}, function(result)
			if result[1].job == 'ems' and result[1].rank >= 3 then
				TriggerClientEvent('varial-duty:FireEMS:Menu', src)
			end
		end)
	else
		TriggerClientEvent('varial-duty:FireEMS:Menu', src)
	end
end)


RegisterServerEvent('varial-duty:AttemptDutyAutoExotics')
AddEventHandler('varial-duty:AttemptDutyAutoExotics', function(src, pJobType)
	if src == nil or src == 0 then src = source end
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local character = user:getCurrentCharacter()
	local jobs = exports["varial-base"]:getModule("JobManager")
	exports.oxmysql:execute('SELECT job FROM jobs_whitelist WHERE cid = ? AND job = ?', {character.id, 'auto_exotics'}, function(result)
		if result[1] ~= nil then
			jobs:SetJob(user, 'auto_exotics', false, function()
				TriggerClientEvent("DoLongHudText", src,"Clock On!", 1)
				TriggerClientEvent('varial-duty:AutoExoticsSuccess', src)
			end)
		else
			TriggerClientEvent("DoLongHudText", src,"You are not whitelisted for this job!", 2)
		end
	end)
end)