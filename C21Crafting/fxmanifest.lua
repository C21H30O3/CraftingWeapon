fx_version 'adamant'

game 'gta5'
lua54 'yes'
description 'Wytwarzanie broni by C21H30O3'

version '1.0'

shared_scripts {
	'@es_extended/imports.lua',
    '@ox_lib/init.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	"server/server.lua",
}

client_scripts {
	'client/client.lua',
}

dependencies {
	'es_extended',
	'ox_lib'
}
