local usersRadios = {}

RegisterCommand("mdt", function(source)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)
	local char = user:getCurrentCharacter()
    local userjob = user:getVar("job")
	local rankfinel = "Police Officer"
	if userjob == "police" or userjob == "ems" then
        TriggerClientEvent('hv-mdw:open', src, rankfinel, char.last_name, char.first_name)
	end
end)

local CallSigns = {}
function GetCallsign(cid)
	 local query = "SELECT `callsign` FROM `jobs_whitelist` WHERE cid = ?"
    local result = Await(SQL.execute(query, cid))
    if result[1] ~= nil and result[1].callsign ~= nil then
         return result[1].callsign
    elseif CallSigns[cid] then
	    return CallSigns[cid]
    else
        return 0
    end
end

RegisterServerEvent('hv-mdw:setRadio')
AddEventHandler("hv-mdw:setRadio", function(radio)
	local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if not user then return end
	usersRadios[tonumber(char.id)] = radio
end)

RegisterServerEvent('police:setCallSign')
AddEventHandler("police:setCallSign", function(callsign)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)
    local char = user:getCurrentCharacter()
	if not user then return end
    CallSigns[tonumber(char.id)] = callsign
end)	




RegisterServerEvent("hv-mdw:opendashboard")
AddEventHandler("hv-mdw:opendashboard", function()
    local src = source
	UpdateWarrants(src)
	Updatebulletin(src)
	UpdateDispatch(src)
	UpdateUnits(src)	
	getVehicles(src)
	getProfiles(src)
	UpdateReports(src)
end) 

function UpdateWarrants(src)	
	local firsttime = true
	local result = Await(SQL.execute("SELECT * FROM ___mdw_incidents"))
	local warrnts = {}
	
	for k, v in pairs(result) do
		for k2, v2 in ipairs(json.decode(v.associated)) do
			if v2.warrant == true then
				TriggerClientEvent("hv-mdw:dashboardWarrants", src, {firsttime = firsttime, time = v.time, linkedincident = v.id, reporttitle = v.title, name = v2.name, cid = v2.cid})  
				firsttime = false
			end
		end
	end
end

function UpdateReports(src)	
	local query = "SELECT * FROM ____mdw_reports"
    local result = Await(SQL.execute(query))
	TriggerClientEvent("hv-mdw:dashboardReports", src, result)
end	

function Updatebulletin(src)	
    local result = Await(SQL.execute("SELECT * FROM ___mdw_bulletin"))
	TriggerClientEvent("hv-mdw:dashboardbulletin", src, result)
end

function UpdateUnits(src)	
	local lspd, bcso, sahp, sasp, doc, sapr, pa, ems = {},{},{},{},{},{},{},{}
	
	for k, v in pairs(GetPlayers()) do
	local user = exports["varial-base"]:getModule("Player"):GetUser(tonumber(v))
        if user then
		    local userjob = user:getVar("job")
		    if userjob == "police" or userjob == "ems" then
		         local char = user:getCurrentCharacter()
			    local rank = user:getVar("jobRank") and user:getVar("jobRank") or 0
			    --local rankfinel = jobs.ValidJobs[userjob]["ranks"][rank]f
                local name = char.first_name .. " " .. char.last_name
			    local callSign = GetCallsign(char.id)
				if userjob == "police" then
					lspds = #lspd + 1
					lspd[lspds] = {}
					lspd[lspds].duty = 1
					lspd[lspds].cid = char.id
					lspd[lspds].radio = usersRadios[char.id] or nil
					lspd[lspds].callsign = callSign
					lspd[lspds].name = name
				elseif userjob == "ems" then
					emss = #ems + 1
					ems[emss] = {}
					ems[emss].duty = 1
					ems[emss].cid = char.id
					ems[emss].radio = usersRadios[char.id] or nil
					ems[emss].callsign = callSign
					ems[emss].name = name
				end
	        end
	    end
    end	
    TriggerClientEvent("hv-mdw:getActiveUnits", src, lspd, bcso, sahp, sasp, doc, sapr, pa, ems)
end	


function getVehicles(src)	
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    ORDER BY id ASC
    ]]
    local result =  Await(SQL.execute(query))
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
	end
	TriggerClientEvent("hv-mdw:searchVehicles", src, result, true)
end


RegisterServerEvent("hv-mdw:getProfileData")
AddEventHandler("hv-mdw:getProfileData", function(id)
	local src = source
	if type(id) == "string" then id = tonumber(id) end		
    local data = getProfile(id)
	TriggerClientEvent("hv-mdw:getProfileData", src, data, false)
end) 

RegisterServerEvent("hv-mdw:getVehicleData")
AddEventHandler("hv-mdw:getVehicleData", function(plate)
	local src = source
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    WHERE license_plate = ? LIMIT 1
    ]]
    local result =  Await(SQL.execute(query, plate))
	
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.notes and v.notes ~= nil then 
		    result[k].information = v.notes
        else
            result[k].information = ""		
		end		
		
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
    end
    TriggerClientEvent("hv-mdw:updateVehicleDbId", src, result[1].id)
	TriggerClientEvent("hv-mdw:getVehicleData", src, result)
end) 



RegisterServerEvent("hv-mdw:knownInformation")
AddEventHandler("hv-mdw:knownInformation", function(dbid, type, status, plate)
	local saveData = {type = type, status = status}
	exports.oxmysql:execute('SELECT * FROM `vehicle_mdt` WHERE `plate` = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			if type == "stolen" then
				exports.oxmysql:execute('UPDATE `vehicle_mdt` SET `stolen` = @stolen WHERE `plate` = @plate AND `dbid` = @dbid', {
				    ['@stolen'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
			elseif type == "code5" then
			    exports.oxmysql:execute('UPDATE `vehicle_mdt` SET `code` = @code WHERE `plate` = @plate AND `dbid` = @dbid', {
				    ['@code'] = status,
					['@dbid'] = dbid,
					['@plate'] = plate,
				})
			end
		else
			if type == "stolen" then
			    exports.oxmysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `stolen`, `dbid`) VALUES (@plate, @stolen, @dbid)', {
			        ['@dbid'] = dbid,
			    	['@plate'] = plate,
			        ['@stolen'] = status
			    })
			elseif type == "code5" then
			    exports.oxmysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `code`, `dbid`) VALUES (@plate, @code, @dbid)', {
			        ['@dbid'] = dbid,
				    ['@plate'] = plate,
			        ['@code'] = status
			    })
			end
		end
	end)
end)




RegisterServerEvent("hv-mdw:searchVehicles")
AddEventHandler("hv-mdw:searchVehicles", function(plate)
    local src = source
	local query = [[
        SELECT *
        FROM characters_cars aa
        LEFT JOIN vehicle_mdt a ON a.plate = aa.license_plate     
	    LEFT JOIN ____mdw_bolos at ON at.plate = aa.license_plate
	    WHERE LOWER(`license_plate`) LIKE ? ORDER BY id ASC
    ]]
    local result =  Await(SQL.execute(query, string.lower('%'..plate..'%')))
	for k, v in pairs(result) do
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].image = v.image  
		else
		    result[k].image = "https://cdn.discordapp.com/attachments/832371566859124821/881624386317201498/Screenshot_1607.png"
		end
		if v.stolen and v.stolen ~= nil then 
		    result[k].stolen = v.stolen 
		else
			result[k].stolen = false
		end
		if v.code and v.code ~= nil then 
		    result[k].code = v.code
        else
            result[k].code = false		
		end
		if v.author and v.author ~= nil and v.title ~= nil then 
			result[k].bolo = true	
		else
			result[k].bolo = false	
		end
	end
	TriggerClientEvent("hv-mdw:searchVehicles", src, result)
end)



RegisterServerEvent("hv-mdw:saveVehicleInfo")
AddEventHandler("hv-mdw:saveVehicleInfo", function(dbid, plate,imageurl, notes)
	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end
	
	local usource = source
	exports.oxmysql:execute('SELECT * FROM `vehicle_mdt` WHERE `plate` = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] then
			exports.oxmysql:execute('UPDATE `vehicle_mdt` SET `image` = @image, `notes` = @notes WHERE `plate` = @plate AND `dbid` = @dbid', {
			    ['@image'] = imageurl,
				['@dbid'] = dbid,
				['@plate'] = plate,
				['@notes'] = notes
			})
		else
			exports.oxmysql:execute('INSERT INTO `vehicle_mdt` (`plate`, `stolen`, `notes`, `image`, `dbid`) VALUES (@plate, @stolen, @notes, @image, @dbid)', {
			    ['@dbid'] = dbid,
				['@plate'] = plate,
				['@stolen'] = 0,
				['@image'] = imageurl,				
				['@notes'] = notes
			})
		end
	end)
end)

RegisterServerEvent("hv-mdw:saveProfile")
AddEventHandler("hv-mdw:saveProfile", function(profilepic, information, cid, fName, sName)
	if imageurl == "" or not imageurl then imageurl = "" end
	if notes == "" or not notes then notes = "" end
	if dbid == 0 then return end
	if plate == "" then return end
	
	local usource = source
	exports.oxmysql:execute('SELECT * FROM `___mdw_profiles` WHERE `cid` = @cid', {
		['@cid'] = cid
	}, function(result)
		if result[1] then
			exports.oxmysql:execute('UPDATE `___mdw_profiles` SET `image` = @image, `description` = @description, `name` = @name WHERE `cid` = @cid', {
			    ['@image'] = profilepic,
				['@description'] = information,
				['@name'] = fName .. " " .. sName,
				['@cid'] = cid
			})
		else
			exports.oxmysql:execute('INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)', {
			    ['@cid'] = cid,
				['@image'] = profilepic,
				['@description'] = information,
				['@name'] = fName .. " " .. sName
			})
		end
	end)
end)

RegisterServerEvent("hv-mdw:addGalleryImg")
AddEventHandler("hv-mdw:addGalleryImg", function(cid, url)
    local query = "SELECT * FROM `___mdw_profiles` WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid)))
	if result and result[1] then
		result[1].gallery = json.decode(result[1].gallery)
		table.insert(result[1].gallery, url)
		exports.oxmysql:execute('UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@gallery'] = json.encode(result[1].gallery),
		})	
	end
end)		

RegisterServerEvent("hv-mdw:removeGalleryImg")
AddEventHandler("hv-mdw:removeGalleryImg", function(cid, url)
    local query = "SELECT * FROM `___mdw_profiles` WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid)))

	if result and result[1] then
		result[1].gallery = json.decode(result[1].gallery)
		for k,v in ipairs(result[1].gallery) do
			if v == url then
				table.remove(result[1].gallery, k)
			end
		end
		exports.oxmysql:execute('UPDATE `___mdw_profiles` SET `gallery` = @gallery WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@gallery'] = json.encode(result[1].gallery),
		})	
	end
end)
	
RegisterServerEvent("hv-mdw:searchProfile")
AddEventHandler("hv-mdw:searchProfile", function(query)
    local src = source
    local queryData = string.lower('%'..query..'%')
    local query = "SELECT * FROM `characters` WHERE LOWER(`first_name`) LIKE ? OR LOWER(`id`) LIKE ? OR LOWER(`last_name`) LIKE ? OR CONCAT(LOWER(`first_name`), ' ', LOWER(`last_name`), ' ', LOWER(`id`)) LIKE ?"
    local result = Await(SQL.execute(query, queryData, queryData, queryData, queryData)) 
	local licenses = Await(SQL.execute("SELECT * FROM user_licenses")) 	
	local mdw_profiles = Await(SQL.execute("SELECT * FROM ___mdw_profiles")) 	

	for k, v in pairs(result) do	
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name
		
		local string = "SELECT status FROM user_licenses WHERE cid = ? AND type = ?"
		local weapon2 = Await(SQL.execute(string, v.id, 'Weapon')) 		
		if weapon2[1].status == 1 then 
			result[k].Weapon = true
		end

		local drivers2 = Await(SQL.execute(string, v.id, 'Drivers')) 
		if drivers2[1].status == 1 then 
			result[k].Drivers = true
		end

		local hunting2 = Await(SQL.execute(string, v.id, 'Hunting')) 
		if hunting2[1].status == 1 then 
			result[k].Hunting = true
		end

		local fishing2 = Await(SQL.execute(string, v.id, 'Fishing')) 
		if fishing2[1].status == 1 then 
			result[k].Fishing = true
		end

		local pilot2 = Await(SQL.execute(string, v.id, 'Pilot')) 
		if pilot2[1].status == 1 then 
			result[k].Pilot = true
		end
		
		local bar2 = Await(SQL.execute(string, v.id, 'Bar')) 
		if bar2[1].status == 1 then 
			result[k].Bar = true
		end

		local business2 = Await(SQL.execute(string, v.id, 'Business')) 
		if business2[1].status == 1 then 
			result[k].Business = true
		end
		
		result[k].policemdtinfo = ""
		result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		for i=1, #mdw_profiles do
			if mdw_profiles[i].cid == v.id then
				if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
					result[k].pp = mdw_profiles[i].image		
				end
				if mdw_profiles[i].description and mdw_profiles[i].description ~= nil then
					result[k].policemdtinfo = mdw_profiles[i].description
				end
				result[k].policemdtinfo = mdw_profiles[i].description
			end
		end	
        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.id
	end
	
	TriggerClientEvent("hv-mdw:searchProfile", src, result, true)
end)	

function getProfile(id)
	    local query = "SELECT * FROM characters WHERE id = ? LIMIT 1"
        local result = Await(SQL.execute(query, id)) 
        local resultI = Await(SQL.execute("SELECT * FROM ___mdw_incidents")) 
	    for k, v in pairs(resultI) do
		    for k2, v2 in ipairs(json.decode(v.associated)) do
		    	if v2.cid == result[1].id then
                    result[1].convictions = v2.charges
			    end
	    	end	
	    end	
        local vehresult = Await(SQL.execute("SELECT * FROM characters_cars WHERE cid = ?", id)) 
	    result[1].vehicles = vehresult
        result[1].firstname = result[1].first_name
        result[1].lastname  = result[1].last_name
		
		local string = "SELECT status FROM user_licenses WHERE cid = ? AND type = ?"
		local weapon2 = Await(SQL.execute(string, id, 'Weapon')) 		
		if weapon2[1].status == 1 then 
			result[1].Weapon = true
		end

		local drivers2 = Await(SQL.execute(string, id, 'Drivers')) 
		if drivers2[1].status == 1 then 
			result[1].Drivers = true
		end

		local hunting2 = Await(SQL.execute(string, id, 'Hunting')) 
		if hunting2[1].status == 1 then 
			result[1].Hunting = true
		end

		local fishing2 = Await(SQL.execute(string, id, 'Fishing')) 
		if fishing2[1].status == 1 then 
			result[1].Fishing = true
		end

		local pilot2 = Await(SQL.execute(string, id, 'Pilot')) 
		if pilot2[1].status == 1 then 
			result[1].Pilot = true
		end
		
		local bar2 = Await(SQL.execute(string, id, 'Bar')) 
		if bar2[1].status == 1 then 
			result[1].Bar = true
		end

		local business2 = Await(SQL.execute(string, id, 'Business')) 
		if business2[1].status == 1 then 
			result[1].Business = true
		end
		
        result[1].warrant = false
        result[1].cid = result[1].id
		result[1].job = result[1].lastjob

        local proresult = Await(SQL.execute("SELECT * FROM ___mdw_profiles WHERE cid = ? LIMIT 1", id)) 		
        if proresult and proresult[1] ~= nil then
            result[1].profilepic = proresult[1].image		
		    result[1].tags = json.decode(proresult[1].tags)		
		    result[1].gallery = json.decode(proresult[1].gallery)		
		    result[1].policemdtinfo = proresult[1].description
	    else
		    result[1].tags = {}			
		    result[1].gallery = {}			
		    result[1].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		end
	return result[1]
end


function getProfiles(src)
	local query = [[
        SELECT *
        FROM characters aa
	    LEFT JOIN ___mdw_profiles at ON at.cid = aa.id 
		ORDER BY id ASC  		
    ]]

    local result =  Await(SQL.execute(query))
	for k, v in pairs(result) do
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name


		local string = "SELECT status FROM user_licenses WHERE cid = ? AND type = ?"


		local weapon = Await(SQL.execute(string, v.id, 'Weapon')) 		
		if weapon[1].status == 1 then 
			result[k].Weapon = true
		end
		
		local drivers2 = Await(SQL.execute(string, v.id, 'Drivers')) 
		if drivers2[1].status == 1 then 
			result[k].Drivers = true
		end

		local hunting2 = Await(SQL.execute(string, v.id, 'Hunting')) 
		if hunting2[1].status == 1 then 
			result[k].Hunting = true
		end

		local fishing2 = Await(SQL.execute(string, v.id, 'Fishing')) 
		if fishing2[1].status == 1 then 
			result[k].Fishing = true
		end

		local bar2 = Await(SQL.execute(string, v.id, 'Bar')) 
		if bar2[1].status == 1 then 
			result[k].Bar = true
		end

		local business2 = Await(SQL.execute(string, v.id, 'Business')) 
		if business2[1].status == 1 then 
			result[k].Business = true
		end

		local pilot2 = Await(SQL.execute(string, v.id, 'Pilot')) 
		if pilot2[1].status == 1 then 
			result[k].Pilot = true
		end

        result[k].warrant = false
        result[k].convictions = 0
        result[k].cid = v.id
		
		if v.image and v.image ~= nil and v.image ~= "" then 
		    result[k].pp = v.image  
		else
		    result[k].pp = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		end
	   	exports.oxmysql:execute('SELECT * FROM `___mdw_profiles` WHERE `cid` = @cid', {
		    ['@cid'] = v.id
		}, function(proresult)
            if proresult and proresult[1] ~= nil then
	
        	result[k].pp = proresult[1].image		
       	    result[k].policemdtinfo = proresult[1].description
			end
		end)
    end
	TriggerClientEvent("hv-mdw:searchProfile", src, result, true)
end



RegisterServerEvent("hv-mdw:updateLicense")
AddEventHandler("hv-mdw:updateLicense", function(cid, type, status)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local name = char.first_name .. " " .. char.last_name
	local time = exports["varial-lib"]:getDate()
	if status == "revoke" then action = "Revoked" else action = "Given" end
	
	TriggerEvent("hv-mdw:newLog", name .. " " .. action .." licenses type: " .. firstToUpper(type) .. " Edited Citizen Id: " .. cid, time)

	if status == "revoke" then
		exports.oxmysql:execute("UPDATE user_licenses SET `status` = @status WHERE cid = @cid AND type = @type", {['status'] = '0', ['cid'] = cid, ['type'] = type})
	else
		exports.oxmysql:execute("UPDATE user_licenses SET `status` = @status WHERE cid = @cid AND type = @type", {['status'] = '1', ['cid'] = cid, ['type'] = type})
	end
end)


RegisterServerEvent("hv-mdw:newBulletin")
AddEventHandler("hv-mdw:newBulletin", function(title, info, time, id)
    local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local Bulletin = {
	    title = title,
		id = id,
		info = info,
		time = time,
		src = src,
		author = name
	}
	local query = "INSERT INTO ___mdw_bulletin (title, info, time, src, author, id) VALUES(?, ?, ?, ?, ?, ?)"
	SQL.execute(query, title, info, time, tostring(src), name, id)
    TriggerEvent("hv-mdw:newLog", name .. " Opened a new Bulletin: Title " .. title .. ", Info " .. info, time)
    TriggerClientEvent("hv-mdw:newBulletin", -1, src, Bulletin, "police")
end)

RegisterServerEvent("hv-mdw:deleteBulletin")
AddEventHandler("hv-mdw:deleteBulletin", function(id)
    local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	local query = "DELETE FROM ___mdw_bulletin WHERE id = ?"
	Await(SQL.execute(query,id)) 	

    TriggerClientEvent("hv-mdw:deleteBulletin", -1, src, id, "police")
end)

RegisterServerEvent("hv-mdw:newLog")
AddEventHandler("hv-mdw:newLog", function(text, time)

    local query = "INSERT INTO ___mdw_logs (text, time) VALUES(?, ?)"
	Await(SQL.execute(query, text, time)) 	
end)

RegisterServerEvent("hv-mdw:getAllLogs")
AddEventHandler("hv-mdw:getAllLogs", function()
	local src = source
	local query = "SELECT * FROM ___mdw_logs LIMIT 120"
    local result = Await(SQL.execute(query))
    
	TriggerClientEvent("hv-mdw:getAllLogs", src, result)
end) 

RegisterServerEvent("hv-mdw:getAllIncidents")
AddEventHandler("hv-mdw:getAllIncidents", function()
	local src = source
	local query = "SELECT * FROM ___mdw_incidents"
    local result = Await(SQL.execute(query))		
		
	TriggerClientEvent("hv-mdw:getAllIncidents", src, result)
end) 

RegisterServerEvent("hv-mdw:getIncidentData")
AddEventHandler("hv-mdw:getIncidentData", function(id)
	local src = source
	local query = "SELECT * FROM ___mdw_incidents WHERE id = ?"
    local result = Await(SQL.execute(query, id))	
	
	
    	
	result[1].tags = json.decode(result[1].tags)
	result[1].officersinvolved = json.decode(result[1].officers)
	result[1].civsinvolved = json.decode(result[1].civilians)
	result[1].evidence = json.decode(result[1].evidence)
	result[1].convictions = json.decode(result[1].associated)
	result[1].charges = json.decode(result[1].associated.charges)
	TriggerClientEvent("hv-mdw:updateIncidentDbId", src, result[1].id)
	TriggerClientEvent("hv-mdw:getIncidentData", src, result[1], json.decode(result[1].associated))
end) 

RegisterServerEvent("hv-mdw:incidentSearchPerson")
AddEventHandler("hv-mdw:incidentSearchPerson", function(query1)
	local src = source
	local queryData = string.lower('%'..query1..'%')
	local query = "SELECT first_name, last_name, id FROM `characters`  WHERE LOWER(`first_name`) LIKE ? OR LOWER(`id`) LIKE ? OR LOWER(`last_name`) LIKE ? OR CONCAT(LOWER(`first_name`), ' ', LOWER(`last_name`), ' ', LOWER(`id`)) LIKE ?"	
	local result = Await(SQL.execute(query, queryData, queryData, queryData, queryData)) 
	local mdw_profiles = Await(SQL.execute("SELECT * FROM ___mdw_profiles")) 	
	for k, v in pairs(result) do	
        result[k].firstname = v.first_name
        result[k].lastname  = v.last_name
		result[k].profilepic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
		for i=1, #mdw_profiles do
			if mdw_profiles[i].cid == v.id then
				if mdw_profiles[i].image and mdw_profiles[i].image ~= nil then
					result[k].profilepic = mdw_profiles[i].image		
				end
			end
		end			
	end		
	TriggerClientEvent('hv-mdw:incidentSearchPerson', src, result)
end)	

RegisterServerEvent("hv-mdw:removeIncidentCriminal")
AddEventHandler("hv-mdw:removeIncidentCriminal", function(cid, icId)

	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local name = char.first_name .. " " .. char.last_name
	local time = exports["varial-lib"]:getDate()
    local action = "Removed a criminal from an incident, incident ID: " .. icId	
    local Cname = ""
	local result = Await(SQL.execute("SELECT * FROM ___mdw_incidents WHERE id = ?", icId))
	for k, v in pairs(result) do
		for k2, v2 in ipairs(json.decode(v.associated)) do
			if tonumber(v2.cid) == tonumber(cid) then
				table.remove(v2, k)
				Cname = v2.name
			end	
        end
    end
	TriggerEvent("hv-mdw:newLog", name .. ", " .. action ..", Criminal Citizen Id: " .. cid .. ", Name: " .. Cname .. "", time)
	local query = "UPDATE ___mdw_incidents SET tags = ? WHERE id = ?"
	SQL.execute(query, json.encode(result[1].associated), icId)
end)


RegisterServerEvent("hv-mdw:searchIncidents")
AddEventHandler("hv-mdw:searchIncidents", function(query)
    local src = source
	exports.oxmysql:execute("SELECT * FROM `___mdw_incidents` WHERE id = @query", {
		['@query'] = tonumber(query)
	}, function(result)

		TriggerClientEvent('hv-mdw:getIncidents', src, result)
	end)
end)	
		



RegisterServerEvent("hv-mdw:saveIncident")
AddEventHandler("hv-mdw:saveIncident", function(data)
    local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	

	
	for i=1, #data.associated do
		local query2 = "SELECT * FROM characters WHERE id = ?"
        local result2 = Await(SQL.execute(query2, data.associated[i].cid))	
	    data.associated[i].name = result2[1].first_name .. " " ..result2[1].last_name
	end
    if data.ID ~= 0 then
		exports.oxmysql:execute('UPDATE `___mdw_incidents` SET `title` = @title, `author` = @author, `time` = @time, `details` = @details, `tags` = @tags, `officers` = @officers, `civilians` = @civilians, `evidence` = @evidence, `associated` = @associated WHERE `id` = @id', {
			['@id'] = data.ID,
			['@title'] = data.title,
			['@author'] = name,
			['@time'] = data.time,
			['@details'] = data.information,
			['@tags'] = json.encode(data.tags),
			['@officers'] = json.encode(data.officers),
			['@civilians'] = json.encode(data.civilians),
			['@evidence'] = json.encode(data.evidence),
			['@associated'] = json.encode(data.associated)		
		})
	else
		exports.oxmysql:execute('INSERT INTO `___mdw_incidents` (`title`, `author`, `time`, `details`, `tags`, `officers`, `civilians`, `evidence`, `associated`) VALUES (@title, @author, @time, @details, @tags, @officers, @civilians, @evidence, @associated)', {
			['@title'] = data.title,
			['@author'] = name,
			['@time'] = data.time,
			['@details'] = data.information,
			['@tags'] = json.encode(data.tags),
			['@officers'] = json.encode(data.officers),
			['@civilians'] = json.encode(data.civilians),
			['@evidence'] = json.encode(data.evidence),
			['@associated'] = json.encode(data.associated)		
		})
	end
end)



RegisterServerEvent("hv-mdw:newTag")
AddEventHandler("hv-mdw:newTag", function(cid, tag)
    local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local result = Await(SQL.execute(query, cid))	
    local newTags = {}
    if result and result[1] then
	
		result[1].tags = json.decode(result[1].tags)
		table.insert(result[1].tags, tag)
		exports.oxmysql:execute('UPDATE `___mdw_profiles` SET `tags` = @tags WHERE `cid` = @cid', {
			['@cid'] = cid,
			['@tags'] = json.encode(result[1].tags),	
		})
	else
		newTags[1] = tag
		exports.oxmysql:execute('INSERT INTO `___mdw_profiles` (`cid`, `image`, `description`, `name`) VALUES (@cid, @image, @description, @name)', {
			['@cid'] = cid,
			['@image'] = "",
			['@description'] = "",
			['@tags'] = json.encode(newTags),
			['@name'] = ""
		})
	end
end)

RegisterServerEvent("hv-mdw:removeProfileTag")
AddEventHandler("hv-mdw:removeProfileTag", function(cid, tag)
    local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local result = Await(SQL.execute(query, tonumber(cid))) 
	if result and result[1] then
		result[1].tags = json.decode(result[1].tags)
		for k,v in ipairs(result[1].tags) do
			if v == tag then
			    table.remove(result[1].tags, k)
		    end
		end
		local query = "UPDATE ___mdw_profiles SET tags = ? WHERE cid = ?"
		SQL.execute(query, json.encode(result[1].tags), tonumber(cid))
	end	
end)


RegisterServerEvent("hv-mdw:getPenalCode")
AddEventHandler("hv-mdw:getPenalCode", function()
    local src = source
    local titles = {}
	local penalcode = {}
    local query = "SELECT * FROM fine_types ORDER BY category ASC"
    local result = Await(SQL.execute(query)) 
	for i=1, #result do
	    local id = result[i].id
		local res = result[i]
	    titles[id] = result[i].label
	    penalcode[id] = {}
		local color = "green"
		class = "Infraction"
		if res.category == 1 then
		color = "orange"
		class = "Misdemeanor"
		elseif res.category == 2 or res.category == 3 then 
		color =  "red"
		class = "Felony"
		end
		penalcode[id].color = color
		
		penalcode[id].title = res.label		
		penalcode[id].id = res.id
		penalcode[id].class = class
		penalcode[id].months = res.jailtime		
		penalcode[id].fine = res.jailtime		
	end
	TriggerClientEvent('hv-mdw:getPenalCode',src, titles, penalcode)
end)	


RegisterServerEvent("hv-mdw:getAllBolos")
AddEventHandler("hv-mdw:getAllBolos", function()
    local src = source
	local query = "SELECT * FROM ____mdw_bolos"
    local result = Await(SQL.execute(query))
	
	TriggerClientEvent("hv-mdw:getBolos", src, result)
end)


RegisterServerEvent("hv-mdw:getBoloData")
AddEventHandler("hv-mdw:getBoloData", function(id)
    local src = source
	local query = "SELECT * FROM ____mdw_bolos WHERE dbid = ?"
    local result = Await(SQL.execute(query, id))
	result[1].tags = json.decode(result[1].tags)
	result[1].gallery = json.decode(result[1].gallery)
	result[1].officersinvolved = json.decode(result[1].officers)	
	result[1].officers = json.decode(result[1].officers)
	
	
    TriggerClientEvent("hv-mdw:getBoloData", src, result[1])
end)


RegisterServerEvent("hv-mdw:searchBolos")
AddEventHandler("hv-mdw:searchBolos", function(query)
    local src = source
	exports.oxmysql:execute("SELECT * FROM `____mdw_bolos` WHERE LOWER(`plate`) LIKE @query OR LOWER(`title`) LIKE @query OR CONCAT(LOWER(`plate`), ' ', LOWER(`title`)) LIKE @query", {
		['@query'] = string.lower('%'..query..'%') -- % wildcard, needed to search for all alike results
	}, function(result)

       	TriggerClientEvent("hv-mdw:getBolos", src, result)
	end)
end)	

RegisterServerEvent("hv-mdw:newBolo")
AddEventHandler("hv-mdw:newBolo", function(data)
    if data.title == "" then return end
	if data.plate == "" then return end
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	exports.oxmysql:execute('SELECT * FROM `____mdw_bolos` WHERE `dbid` = @id', {
		['@id'] = data.id
	}, function(result)
		if data.id ~= nil and data.id ~= 0 then
			exports.oxmysql:execute('UPDATE `____mdw_bolos` SET `title` = @title, `plate` = @plate, `owner` = @owner, `individual` = @individual, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `time` = @time, `author` = @author WHERE `dbid` = @id', {
			    ['@title'] = data.title,
				['@plate'] = data.plate,
				['@owner'] = data.owner,
				['@individual'] = data.individual,				
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@time'] = data.time,
				['@author'] = name,
				['@id'] = data.id
			})
		else
			exports.oxmysql:execute('INSERT INTO `____mdw_bolos` (`title`, `plate`, `owner`, `individual`, `detail`, `tags`, `gallery`, `officers`, `time`, `author`) VALUES (@title, @plate, @owner, @individual, @detail, @tags, @gallery, @officers, @time, @author)', {
			    ['@title'] = data.title,
				['@plate'] = data.plate,
				['@owner'] = data.owner,
				['@individual'] = data.individual,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@time'] = data.time,
				['@author'] = name
				
			})
		    local query = "SELECT * FROM ____mdw_bolos ORDER BY dbid DESC LIMIT 1"
  			local result2 = Await(SQL.execute(query, id))
		    TriggerClientEvent("hv-mdw:boloComplete", src, result2[1].dbid)
		end
	end)
end)



RegisterServerEvent("hv-mdw:deleteBolo")
AddEventHandler("hv-mdw:deleteBolo", function(id)
    local src = source
	local query = "DELETE FROM ____mdw_bolos WHERE dbid = ?"
	Await(SQL.execute(query, id)) 
end)	

local attachedUnits = {}
RegisterServerEvent("hv-mdw:attachedUnits")
AddEventHandler("hv-mdw:attachedUnits", function(callid)
    local src = source
	if not attachedUnits[callid] then
		local id = #attachedUnits + 1
		attachedUnits[callid] = {}		
	end
    TriggerClientEvent("hv-mdw:attachedUnits", src, attachedUnits[callid], callid)
end)

RegisterServerEvent("hv-mdw:callDragAttach")
AddEventHandler("hv-mdw:callDragAttach", function(callid, cid)
    local src = source

	local user = getUserFromCid(cid)
	if user == false then return end
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local userjob = user:getVar("job")

	local id = callid

	attachedUnits[id] = {}
	attachedUnits[id][cid] = {}

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end

	attachedUnits[id][cid].job = userjob
	attachedUnits[id][cid].callsign = GetCallsign(char.id)
	attachedUnits[id][cid].fullname = name
	attachedUnits[id][cid].cid = char.id
	attachedUnits[id][cid].callid = callid
	attachedUnits[id][cid].radio = units
    TriggerClientEvent("hv-mdw:callAttach", -1, callid, units)
end)


RegisterServerEvent("hv-mdw:callAttach")
AddEventHandler("hv-mdw:callAttach", function(callid)
    local src = source

	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
    local userjob = user:getVar("job")
	local id = callid
	local cid = char.id
	attachedUnits[id] = {}
	attachedUnits[id][cid] = {}

	local units = 0
	for k, v in pairs(attachedUnits[id]) do
		units = units + 1
	end
	attachedUnits[id][cid].job = userjob
	attachedUnits[id][cid].callsign = GetCallsign(char.id)
	attachedUnits[id][cid].fullname = name
	attachedUnits[id][cid].cid = char.id
	attachedUnits[id][cid].callid = callid
	attachedUnits[id][cid].radio = units

    TriggerClientEvent("hv-mdw:callAttach", -1, callid, units)
end)

RegisterServerEvent("hv-mdw:callDetach")
AddEventHandler("hv-mdw:callDetach", function(callid)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local id = callid
    attachedUnits[id][char.id] = nil

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end
    TriggerClientEvent("hv-mdw:callDetach", -1, callid, units)
end)

RegisterServerEvent("hv-mdw:callDispatchDetach")
AddEventHandler("hv-mdw:callDispatchDetach", function(callid, cid)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
	local id = tonumber(callid)

    attachedUnits[id][cid] = nil

	local units = 0
	for k, v in ipairs(attachedUnits[id]) do
		units = units + 1
	end
    TriggerClientEvent("hv-mdw:callDetach", -1, callid, units)
end)


RegisterServerEvent("hv-mdw:setWaypoint:unit")
AddEventHandler("hv-mdw:setWaypoint:unit", function(cid)
    local src = source

	local user = getUserFromCid(cid)
    if user == false then return end
	local uSrc = user:getVar("source")
	local coords = GetEntityCoords(GetPlayerPed(uSrc))
    TriggerClientEvent("hv-mdw:setWaypoint:unit", src, coords)
end)

RegisterServerEvent("hv-mdw:setDispatchWaypoint")
AddEventHandler("hv-mdw:setDispatchWaypoint", function(callid, cid)
    local src = source
	local user = getUserFromCid(cid)
    if user == false then return end
	local uSrc = user:getVar("source")
	local coords = GetEntityCoords(GetPlayerPed(uSrc))
    TriggerClientEvent("hv-mdw:setWaypoint:unit", src, coords)
end)

local CallResponses = {}

RegisterServerEvent("hv-mdw:getCallResponses")
AddEventHandler("hv-mdw:getCallResponses", function(callid)
    local src = source
	if not CallResponses[callid] then
		CallResponses[callid] = {}
	end	
    TriggerClientEvent("hv-mdw:getCallResponses", src, CallResponses[callid], callid)
end)

RegisterServerEvent("hv-mdw:sendCallResponse")
AddEventHandler("hv-mdw:sendCallResponse", function(message, time, callid, name)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()	
	local name = char.first_name .. " " .. char.last_name
	if not CallResponses[callid] then
		CallResponses[callid] = {}
	end	
    local id = #CallResponses[callid] + 1
	CallResponses[callid][id] = {}

	CallResponses[callid][id].name = name
	CallResponses[callid][id].message = message
	CallResponses[callid][id].time = time
    
    TriggerClientEvent("hv-mdw:sendCallResponse", src, message, time, callid, name)
end)               





RegisterServerEvent("hv-mdw:getAllReports")
AddEventHandler("hv-mdw:getAllReports", function()
    local src = source
	local query = "SELECT * FROM ____mdw_reports"
    local result = Await(SQL.execute(query))
	
	TriggerClientEvent("hv-mdw:getAllReports", src, result)
end)

RegisterServerEvent("hv-mdw:getReportData")
AddEventHandler("hv-mdw:getReportData", function(id)
    local src = source
	local query = "SELECT * FROM ____mdw_reports WHERE dbid = ?"
    local result = Await(SQL.execute(query, id))
	result[1].tags = json.decode(result[1].tags)
	result[1].gallery = json.decode(result[1].gallery)
	result[1].officersinvolved = json.decode(result[1].officers)	
	result[1].officers = json.decode(result[1].officers)
	result[1].civsinvolved = json.decode(result[1].civsinvolved)	
    TriggerClientEvent("hv-mdw:getReportData", src, result[1])
end)

RegisterServerEvent("hv-mdw:searchReports")
AddEventHandler("hv-mdw:searchReports", function(querydata)
    local src = source
		local query = [[
			SELECT *
			FROM ____mdw_reports aa
			WHERE LOWER(`type`) LIKE ? OR LOWER(`title`) LIKE ? OR LOWER(`dbid`) LIKE ? OR CONCAT(LOWER(`type`), ' ', LOWER(`title`), ' ', LOWER(`dbid`)) LIKE ?
		]]
		local string = string.lower('%'..querydata..'%')
		local result = Await(SQL.execute(query, string, string, string, string))

       	TriggerClientEvent("hv-mdw:getAllReports", src, result)
end)	


RegisterServerEvent("hv-mdw:newReport")
AddEventHandler("hv-mdw:newReport", function(data)
    if data.title == "" then return end
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name
	local time = exports["varial-lib"]:getDate()

	exports.oxmysql:execute('SELECT * FROM `____mdw_reports` WHERE `dbid` = @id', {
		['@id'] = data.id
	}, function(result)
		if data.id ~= nil and data.id ~= 0 then

			local action = "Edit A Report, Rrofile ID: " .. data.id	
			TriggerEvent("hv-mdw:newLog", name .. ", " .. action ..", Changes: " .. json.encode(data), time)

			exports.oxmysql:execute('UPDATE `____mdw_reports` SET `title` = @title, `type` = @type, `detail` = @detail, `tags` = @tags, `gallery` = @gallery, `officers` = @officers, `civsinvolved` = @civsinvolved, `time` = @time, `author` = @author WHERE `dbid` = @id', {
			    ['@title'] = data.title,
			    ['@type'] = data.type,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@civsinvolved'] = json.encode(data.civilians),
				['@time'] = data.time,
				['@author'] = name,
				['@id'] = data.id
			})
		else
			exports.oxmysql:execute('INSERT INTO `____mdw_reports` (`title`, `type`, `detail`, `tags`, `gallery`, `officers`, `civsinvolved`, `time`, `author`) VALUES (@title, @type, @detail, @tags, @gallery, @officers, @civsinvolved, @time, @author)', {
			    ['@title'] = data.title,
			    ['@type'] = data.type,
				['@detail'] = data.detail,
				['@tags'] = json.encode(data.tags),
				['@gallery'] = json.encode(data.gallery),
				['@officers'] = json.encode(data.officers),
				['@civsinvolved'] = json.encode(data.civilians),
				['@time'] = data.time,
				['@author'] = name			
			})
			Wait(500)
		    local query = "SELECT * FROM ____mdw_reports ORDER BY dbid DESC LIMIT 1"
  			local result2 = Await(SQL.execute(query, id))
		    TriggerClientEvent("hv-mdw:reportComplete", src, result2[1].dbid)
		end
	end)
end)

function UpdateDispatch(src)
	local query = "SELECT * FROM ___mdw_messages LIMIT 200"
    local result = Await(SQL.execute(query))
    TriggerClientEvent("hv-mdw:dashboardMessages", src, result)
end

RegisterServerEvent("hv-mdw:sendMessage")
AddEventHandler("hv-mdw:sendMessage", function(message, time)
	local src = source
	local user = exports["varial-base"]:getModule("Player"):GetUser(src)	
	local char = user:getCurrentCharacter()
    local name = char.first_name .. " " .. char.last_name


	local query = "SELECT * FROM ___mdw_profiles WHERE cid = ?"
    local pic = "https://media.discordapp.net/attachments/832371566859124821/872590513646239804/Screenshot_1522.png"
	
    local result = Await(SQL.execute(query, char.id))
    if result and result[1] ~= nil then
		if result[1].image and result[1].image ~= nil and result[1].image ~= "" then 
		    pic = result[1].image  
		end
	end	
	local query = "INSERT INTO ___mdw_messages (name, message, time, profilepic, job) VALUES(?, ?, ?, ?, ?)"
	Await(SQL.execute(query, name, message, time, pic, "police")) 	
	local lastMsg = {
        name = name,
		message = message,
		time = time,
		profilepic = pic,
		job = "police"
	}
	TriggerClientEvent("hv-mdw:dashboardMessage", -1, lastMsg)
end)

RegisterServerEvent("hv-mdw:refreshDispatchMsgs")
AddEventHandler("hv-mdw:refreshDispatchMsgs", function()
    local src = source
	local query = "SELECT * FROM ___mdw_messages LIMIT 200"
    local result = Await(SQL.execute(query))
    TriggerClientEvent("hv-mdw:dashboardMessages", src, result)
end)


-- RegisterNetEvent('hv-mdw:dashboardMessage')
-- AddEventHandler('hv-mdw:dashboardMessage', function(sentData)
--     local job = exports["isPed"]:isChar("myjob")
--     if job == "police" or job.name == 'ambulance' then
--         SendNUIMessage({ type = "dispatchmessage", data = sentData })
--     end
-- end)

RegisterServerEvent("hv-mdw:setCallsign")
AddEventHandler("hv-mdw:setCallsign", function(cid, callsign)
	exports.oxmysql:execute("UPDATE jobs_whitelist SET `callsign` = @callsign WHERE cid = @cid", {['callsign'] = callsign, ['cid'] = cid})
end)

function tprint (t, s)
    for k, v in pairs(t) do
        local kfmt = '["' .. tostring(k) ..'"]'
        if type(k) ~= 'string' then
            kfmt = '[' .. k .. ']'
        end
        local vfmt = '"'.. tostring(v) ..'"'
        if type(v) == 'table' then
            tprint(v, (s or '')..kfmt)
        else
            if type(v) ~= 'string' then
                vfmt = tostring(v)
            end
            print(type(t)..(s or '')..kfmt..' = '..vfmt)
        end
    end
end

function getUserFromCid(cid)
	local users = exports["varial-base"]:getModule("Player"):GetUsers()
	for k,v in pairs(users) do
		local user = exports["varial-base"]:getModule("Player"):GetUser(v)
		if user then
		    local char = user:getCurrentCharacter()
            if char.id == cid then
				return user
			end
		end
	end
    return false
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end