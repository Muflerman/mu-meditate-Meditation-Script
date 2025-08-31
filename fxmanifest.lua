fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Mufler'
description 'Meditación para reducir estrés en QBCore'
version '2.0.0'

-- Dependencias necesarias
dependency 'qb-core'

-- Scripts compartidos
shared_scripts {
    'config.lua'
}

-- Scripts del cliente
client_scripts {
    'client.lua'
}

-- Scripts del servidor
server_scripts {
    'server.lua'
}

-- Archivos que se ignoran en escrow
escrow_ignore {
    'client.lua',
    'config.lua',
    'server.lua'
}
