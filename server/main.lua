local QBCore = exports['qbx_core']:GetCoreObject()
local function isCriminal(job)
    for _, j in pairs(Config.AllowedJobs) do
        if job == j then return true end
    end
    return false
end

local function shouldBeRobbed(isCriminal)
    local chance = isCriminal and Config.RobberyChanceCrim or Config.RobberyChanceCiv
    return math.random(100) <= chance
end

RegisterNetEvent('drug_cocaine:process', function(stage)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local job = Player.PlayerData.job.name
    local isCrim = isCriminal(job)
    local stageFrom = nil
    local stageTo = nil
    local explosionChance = 0

    if stage == 'paste' then
        stageFrom = Config.Stages.leaf
        stageTo = Config.Stages.paste
    elseif stage == 'powder' then
        stageFrom = Config.Stages.paste
        stageTo = Config.Stages.powder
    elseif stage == 'crack' then
        stageFrom = Config.Stages.powder
        stageTo = Config.Stages.crack
        explosionChance = Config.CrackExplosionChance
    elseif stage == 'fishscale' then
        stageFrom = Config.Stages.powder
        stageTo = Config.Stages.fishscale
        explosionChance = Config.FishscaleExplosionChance
    end

    if not stageFrom or not stageTo then return end
    if not Player.Functions.GetItemByName(stageFrom) then
        TriggerClientEvent('ox_lib:notify', src, { title = "Error", description = "Missing ingredients", type = "error" })
        return
    end

    -- Civilian failure restriction
    if stage == 'powder' and Config.CivilianRestriction and not isCrim then
        if math.random(100) <= Config.CivilianFailureChance then
            Player.Functions.RemoveItem(stageFrom, 1)
            TriggerClientEvent('ox_lib:notify', src, { title = "Failed", description = "You messed up the process.", type = "error" })
            return
        end
    end

    -- Explosion risk
    if explosionChance > 0 and math.random(100) <= explosionChance then
        TriggerClientEvent('AddExplosion', src, GetEntityCoords(GetPlayerPed(src)), 12, 2.0, true)
        return
    end

    Player.Functions.RemoveItem(stageFrom, 1)
    Player.Functions.AddItem(stageTo, 1)

    if shouldBeRobbed(isCrim) then
        -- Simulated robbery logic
        TriggerClientEvent('ox_lib:notify', src, { title = "Ambushed!", description = "NPCs tried to rob you!", type = "error" })
    end
end)

RegisterServerEvent('drug_cocaine:use')
AddEventHandler('drug_cocaine:use', function(type)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Config.Stages[type]
    if Player and Player.Functions.GetItemByName(item) then
        Player.Functions.RemoveItem(item, 1)
        TriggerClientEvent('drug_cocaine:useEffect', src, type)
    end
end)
