game 'common'
fx_version 'bodacious'

client_scripts {
    '@varial-lib/client/cl_rpcother.lua',
    'client/*.lua',
    'shared/sh*.lua',
    'config.lua',
}


server_scripts {
    '@varial-lib/server/sv_rpcother.lua',
    '@varial-lib/server/sv_sql.lua',
    'server/*.lua',
    'shared/sh*.lua',
}
