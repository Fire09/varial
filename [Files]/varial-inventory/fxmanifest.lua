resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'
fx_version "cerulean"

games {"gta5"}


dependencies {
    "PolyZone"
}

client_script "@varial-errorlog/client/cl_errorlog.lua"
client_script "@PolyZone/client.lua"

ui_page 'nui/ui.html'

files {
	"nui/ui.html",
	"nui/pricedown.ttf",
	"nui/default.png",
	"nui/background.png",
	"nui/weight-hanging-solid.png",
	"nui/hand-holding-solid.png",
	"nui/search-solid.png",
	"nui/invbg.png",
	"nui/styles.css",
	"nui/scripts.js",
	"nui/debounce.min.js",
	"nui/loading.gif",
	"nui/loading.svg",
	"nui/icons/*"
  }
client_script '@varial-lib/client/cl_main.lua'
server_script '@varial-lib/server/sv_main.lua'
shared_script 'shared/sh_*.js'
shared_script 'shared/sh_*.lua'
client_script 'client/cl_*.js'
client_script 'client/cl_*.lua'
client_script 'events/cl.lua'
server_script 'server/sv_*.js'
server_script 'server/sv_*.lua'


exports{
	'hasEnoughOfItem',
	'getQuantity',
	'GetCurrentWeapons',
	'GetItemInfo'
}
