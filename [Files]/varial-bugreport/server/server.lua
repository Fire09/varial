local DISCORD_WEBHOOK = "https://discord.com/api/webhooks/938861618631147540/apPvJxnWHpnhhbL5DIAum-3x4d9wJG27dnPyGlRJZY46q31kS0voRWhF8UKsVTRF1FlV"

RegisterServerEvent('send')
AddEventHandler('send', function(data)
    local pName = GetPlayerName(source)
    local connect = {
        {
            ["color"] = "255",
            ["title"] = "Bug Report - ".. pName,
            ["description"] = "Bug: (A name for the bug) \n\n `"..data.title.."` \n\n━━━━━━━━━━━━━━━━━━\n\n Description: (A description of what happens and what may cause it) \n\n `"..data.description.."` \n\n━━━━━━━━━━━━━━━━━━\n\n VOD, Clip or Screenshot (URL ONLY | Please use F8 for any console errors) \n\n `"..data.url.."` \n\n━━━━━━━━━━━━━━━━━━\n\n",
	        ["footer"] = {
                ["text"] = "Sent by varial In-Game bug report",
            },
        }
    }
    PerformHttpRequest(DISCORD_WEBHOOK, function(err, text, headers) end, 'POST', json.encode({username = "varial Bug Reports",  avatar_url = "https://cdn.discordapp.com/attachments/935466402201104454/943599149868277820/logo.png",embeds = connect}), { ['Content-Type'] = 'application/json' })
end)

