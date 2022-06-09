fx_version 'adamant'
games { 'gta5' }

client_scripts {
    '@varial-lib/client/cl_ui.lua',
    '@varial-lib/client/cl_interface.lua',
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

client_script "@varial-errorlog/client/cl_errorlog.lua"