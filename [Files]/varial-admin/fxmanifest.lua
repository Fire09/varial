fx_version 'cerulean'
game 'gta5'

author ''
description 'Admin Menu'

ui_page "nui/index.html"

client_scripts {
    'client/cl_*.lua',
    '@varial-lib/client/cl_rpcother.lua',
    'shared/sh_config.lua',
}

server_scripts {
    '@varial-lib/server/sv_rpcother.lua',
    '@oxmysql/lib/MySQL.lua',
    'server/sv_*.lua',
}

files {
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2",
}

dependencies {
    'oxmysql',
}

lua54 'yes'