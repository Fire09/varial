fx_version 'bodacious'
game 'gta5'

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "@varial-errorlog/client/cl_errorlog.lua"
client_script  "config.lua"
client_script '@varial-lib/client/cl_ui.lua'
client_script "client/cl_duty.lua"
client_script "client/cl_hire.lua"
server_script "server/sv_duty.lua"
server_script "server/sv_hire.lua"


exports {
	'LawAmount'
}