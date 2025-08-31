--============================================================
-- Resource: mu-meditate (FiveM / QBCore)
-- Client: Meditación para reducir estrés (sin cambios de lógica)
--============================================================

--========================
-- QBCore Bootstrap
--========================
local QBCore = exports["qb-core"]:GetCoreObject()

--========================
-- Constantes / Config local
--========================
local ANIM_DICT   = "rcmcollect_paperleadinout@"  -- (original)
local ANIM_NAME   = "meditiate_idle"              -- (original)
local PROP_MODEL  = "prop_towel_01"               -- puedes probar también: "prop_beach_towel" (original)
local DURATION_MS = 15000                         -- Duración en ms (original)

--========================
-- Utilidades de carga
--========================
local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

local function loadModel(modelName)
    local hash = GetHashKey(modelName)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(10)
    end
    return hash
end

--========================
-- Spawner / Cleanup de prop
--========================
local function spawnTowel(hash)
    local playerPed    = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    local towel = CreateObject(
        hash,
        playerCoords.x,
        playerCoords.y,
        playerCoords.z - 1.0,
        true, true, true
    )
    SetEntityCollision(towel, false, true)
    PlaceObjectOnGroundProperly(towel)
    FreezeEntityPosition(towel, true)

    return towel, playerPed
end

local function cleanup(playerPed, towel)
    -- Limpiar animación y prop (original)
    ClearPedTasks(playerPed)
    if DoesEntityExist(towel) then
        DeleteObject(towel)
    end
end

--========================
-- Lógica principal (idéntica en comportamiento)
--========================
local function Main()
    -- Obtener nivel de estrés (original)
    local PData  = QBCore.Functions.GetPlayerData()
    local Stress = PData.metadata["stress"]

    if Stress <= 0 then
        QBCore.Functions.Notify(Config.NoStress, "error", 5000)
        return
    end

    -- Configurar animación (original)
    loadAnimDict(ANIM_DICT)

    -- Crear prop de toalla/trapo (original)
    local propHash = loadModel(PROP_MODEL)

    -- Crear toalla y tomar referencias
    local towel, playerPed = spawnTowel(propHash)

    -- Progressbar (original)
    QBCore.Functions.Progressbar(
        "meditation",
        "Meditando...",
        DURATION_MS,
        false,
        true,
        {
            disableMovement    = true,
            disableCarMovement = true,
            disableMouse       = false,
            disableCombat      = true,
        },
        {
            animDict = ANIM_DICT,
            anim     = ANIM_NAME,
            flags    = 1,
        },
        {},
        {},
        function() -- success (original)
            local PData2  = QBCore.Functions.GetPlayerData()
            local Stress2 = PData2.metadata["stress"]

            local removeAmt = math.random(12, 24)
            if Stress2 - removeAmt <= 0 then
                removeAmt = Stress2
            end

            TriggerServerEvent('hud:server:RelieveStress', removeAmt)
            QBCore.Functions.Notify(Config.Success .. removeAmt .. Config.Success2, "success", 2000)

            cleanup(playerPed, towel)
        end,
        function() -- cancel (original)
            TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
            QBCore.Functions.Notify(Config.Interrupted, "error", 2000)

            cleanup(playerPed, towel)
        end
    )
end

--========================
-- Evento público (renombrado a mu-meditate)
--========================
RegisterNetEvent('mu-meditate:client:start', function()
    Main()
end)
