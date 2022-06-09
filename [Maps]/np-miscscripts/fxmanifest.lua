fx_version "cerulean"

game "gta5"

files {
    'dlc_nikez_misc/*.awc',
    'misc.dat54.rel'
}

client_script "@varial-sync/client/lib.lua"
client_script "@varial-lib/client/cl_ui.lua"
client_script "@varial/client/lib.js"
server_script "@varial/server/lib.js"
shared_script "@varial/shared/lib.lua"
client_script "@varial-errorlog/client/cl_errorlog.lua"
server_script "@varial-lib/server/sv_asyncExports.lua"


client_script {
    "client/cl_*.lua",
    "client/cl_*.js"
}

server_script {
    "server/sv_*.lua",
    "server/sv_*.js"
}

data_file 'AUDIO_WAVEPACK' 'dlc_nikez_misc'
data_file 'AUDIO_SOUNDDATA' 'misc.dat'
