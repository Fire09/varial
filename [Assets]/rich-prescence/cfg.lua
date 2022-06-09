cfg = {}
--This is where you put your DiscordAppID you can get it from here https://discord.com/developers/applications
cfg.DiscordAppID = 981860633534423090

cfg.discordImageName = 'VarialRPLogo'
cfg.hoverText = 'Varial 1.0'
cfg.richPresenceText = "" ..GetPlayerServerId(PlayerId()).. " | " .. #GetActivePlayers() .. " Players"
cfg.smallDiscordImageName = 'VarialRP96'
cfg.smallHoverText = 'Monke'

cfg.button1 = {
    text = 'Discord',
    url = 'https://discord.gg/tKTtjXQcCT'
}

cfg.button2 = {
    text = 'Connect ',
    url = 'cfx.re/join/8bd8e5'
}
-- Just to clarify something, you can only have 2 buttons
