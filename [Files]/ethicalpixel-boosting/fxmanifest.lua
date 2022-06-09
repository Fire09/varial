fx_version 'cerulean'
games { 'gta5' }

client_scripts {
  'config.lua',
  '@varial-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
}

server_scripts {
  '@varial-lib/server/sv_rpc.lua',
  --'@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server/sv_*.lua',
}

ui_page 'ui/auth.html'

files {
  'ui/*'
}

lua54 'yes'
