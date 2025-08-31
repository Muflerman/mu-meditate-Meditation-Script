
--============================================================
-- Resource: mu-meditate
-- Configuración
--============================================================

Config = {}

--============================================================
-- Comando
--============================================================
Config.CommandName = "meditar"   -- El nombre del comando (sin incluir la barra /)

--============================================================
-- Notificaciones
--============================================================
-- Sistema de notificaciones a usar:
--   "qb"  = QBCore Notify
--   "esx" = esx.notify (si adaptas para ESX)
Config.Notify       = "qb"

-- Mensajes de feedback para el jugador
Config.NoStress     = "No sientes la necesidad de meditar."      -- Cuando el jugador no necesita meditar
Config.Success      = "Has meditado con éxito y has reducido "   -- Parte 1 del mensaje de éxito
Config.Success2     = "% de tu estrés."                          -- Parte 2 del mensaje de éxito
Config.Interrupted  = "Fuiste interrumpido mientras meditabas."  -- Cuando se interrumpe la acción
