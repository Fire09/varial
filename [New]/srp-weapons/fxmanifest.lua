games {"gta5"}

fx_version "cerulean"

description "Weapons"

dependencies  {
  "damage-events"
}

client_scripts {





  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",

  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",


  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",


  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",


  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",


  "@varial-errorlog/client/cl_errorlog.lua",
  "@varial-lib/client/cl_rpc.lua",

 -- "client.lua",
  "modes.lua",
  "melee.lua",
  "pickups.lua"
}

shared_script {





  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",

  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",


  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",


  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",


  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",


  "@varial-lib/shared/sh_util.lua"
}
server_scripts {
  "@varial-lib/server/sv_rpc.lua",
  "@varial-lib/server/sv_sql.lua",

  "server.lua"
}

server_export "getWeaponMetaData"
server_export "updateWeaponMetaData"

exports {
  "toName",
  "findModel"
}
