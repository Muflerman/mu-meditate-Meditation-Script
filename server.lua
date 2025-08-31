--============================================================
-- Resource: mu-meditate (FiveM / QBCore)
-- Server: Comando para iniciar meditación (/meditar)
--============================================================

local QBCore = exports['qb-core']:GetCoreObject()

--============================================================
-- Comando /meditar
--============================================================
QBCore.Commands.Add(
    'meditar',                               -- nombre del comando
    'Meditar para reducir estrés',           -- descripción
    {},                                      -- argumentos (ninguno)
    false,                                   -- args requerido
    function(source)                         -- callback
        TriggerClientEvent('mu-meditate:client:start', source)
    end,
    'user'                                   -- permiso mínimo
)
