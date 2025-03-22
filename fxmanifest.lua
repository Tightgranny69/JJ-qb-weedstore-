fx_version 'cerulean'
game 'gta5'

author 'Jason Hall'
description 'QB-Core Weed Store'
version '1.0.0'

shared_script 'config.lua'

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',  -- Include this if you use a database (optional)
    'server/main.lua'
}

dependencies {
    'qb-core',
    'qb-inventory',
    'qb-target'
}
