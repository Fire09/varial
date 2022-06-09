
local EvanCocainePlaneCanBeStarted = true

RegisterServerEvent('varial-cocaine:plane:start')
AddEventHandler('varial-cocaine:plane:start', function(money)
    local src = source
    local user = exports["varial-base"]:getModule("Player"):GetUser(src)

	if user:getCash() >= money then
        
        if EvanCocainePlaneCanBeStarted then
            user:removeMoney(money)
            EvanCocainePlaneCanBeStarted = false
            TriggerClientEvent('varial-cocaine:shitfuckoff', src)
        else
            TriggerClientEvent('DoLongHudText', src, 'Someone is already out on a job cuz', 2)
        end
    else
        TriggerClientEvent('DoLongHudText', src, 'You do not have enough cash for this !', 2)
    end
end)

RegisterServerEvent('varial-cocaine:plane:shit')
AddEventHandler('varial-cocaine:plane:shit', function()
    EvanCocainePlaneCanBeStarted = true
end)