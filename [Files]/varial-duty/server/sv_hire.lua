-- POLICE HIRE/FIRE --

RegisterServerEvent("varial-duty:HireLaw")
AddEventHandler("varial-duty:HireLaw", function(cid, job, rank)
    local src = source
    if job == 'state' or job == 'police' or job == 'sheriff' then
        exports.oxmysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = job, ['@rank'] = rank})
        exports.oxmysql:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
            if result[1] ~= nil then
                TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
            end
        end)
    else
        TriggerClientEvent('DoLongHudText', src, 'Please select one of these jobs! (police, state, sheriff)', 2)
    end
end)

RegisterServerEvent("varial-duty:FireLaw")
AddEventHandler("varial-duty:FireLaw", function(cid)
    local src = source
    exports.oxmysql:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job == 'state' or result2[1].job == 'police' or result2[1].job == 'sheriff' then
                    exports.oxmysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = result2[1].job})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                else
                    TriggerClientEvent('DoLongHudText', src, 'The person you are trying firing does not work for you!', 2)
                end
            end
        end) 
    end)
end)

-- END POLICE HIRE/FIRE --

-- EMS HIRE/FIRE --

RegisterServerEvent("varial-duty:HireEMS")
AddEventHandler("varial-duty:HireEMS", function(cid, rank)
    local src = source
    exports.oxmysql:execute("INSERT INTO jobs_whitelist (cid, job, rank) VALUES (@cid, @job, @rank)", {['@cid'] = cid, ['@job'] = 'ems', ['@rank'] = rank})
    exports.oxmysql:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        if result[1] ~= nil then
            TriggerClientEvent('DoLongHudText', src, 'You hired '.. result[1].first_name ..' '.. result[1].last_name, 1)
        end
    end)
end)

RegisterServerEvent("varial-duty:FireEMS")
AddEventHandler("varial-duty:FireEMS", function(cid)
    local src = source
    exports.oxmysql:execute('SELECT * FROM characters WHERE id = @cid', {['@cid'] = cid}, function(result)
        exports.oxmysql:execute('SELECT * FROM jobs_whitelist WHERE cid = @cid', {['@cid'] = cid}, function(result2)
            if result[1] ~= nil and result2[1] ~= nil then
                if result2[1].job == 'ems' then
                    exports.oxmysql:execute("DELETE FROM jobs_whitelist WHERE `cid` = @cid AND `job` = @job", {['@cid'] = cid, ['@job'] = result2[1].job})
                    TriggerClientEvent('DoLongHudText', src, 'You fired '.. result[1].first_name ..' '.. result[1].last_name, 2)
                else
                    TriggerClientEvent('DoLongHudText', src, 'The person you are trying firing does not work for you!', 2)
                end
            end
        end) 
    end)
end)

-- END EMS HIRE/FIRE --