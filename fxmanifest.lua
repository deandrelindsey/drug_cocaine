fx_version 'cerulean'
game 'gta5'

description 'drug_cocaine resource'
version '1.0.0'

shared_script 'config.lua'
shared_script 'locales/en.lua'
client_script 'client/main.lua'
server_script '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
