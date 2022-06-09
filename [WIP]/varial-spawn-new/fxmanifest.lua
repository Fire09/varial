fx_version 'cerulean'
games {'gta5'}

-- dependency "varial-base"
-- dependency "raid_clothes"

ui_page "html/index.html"
files({
	"html/*",
	"html/images/*",
	"html/css/*",
	"html/webfonts/*",
	"html/js/*"
})

client_script "@varial-errorlog/client/cl_errorlog.lua"
client_script "client/*"
client_script "@varial-lib/client/cl_rpc.lua"

shared_script "shared/sh_spawn.lua" 
server_script "server/*"
server_script "@oxmysql/lib/MySQL.lua"