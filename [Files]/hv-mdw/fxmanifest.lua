fx_version 'cerulean'
game 'gta5'




lua54 'yes'

server_script '@varial-lib/server/sv_sqlother.lua'
server_script 'sv_main.lua'
client_script 'cl_main.lua'

ui_page 'ui/dashboard.html'

files {
    'ui/img/sasp_badge.png',
    'ui/img/ems_badge.png',
    'ui/img/court.png',
    'ui/img/MDW-logo.png',
    'ui/img/warrant_pfp.png',
    'ui/img/profile_pic.png',
    'ui/img/not-found.jpg',
    'ui/img/male.png',
    'ui/img/female.png',
    'ui/dashboard.html',
    'ui/dmv.html',
    'ui/bolos.html',
    'ui/incidents.html',
    'ui/penalcode.html',
    'ui/reports.html',
    'ui/warrants.html',
    'ui/app.js',
    'ui/style.css',
}