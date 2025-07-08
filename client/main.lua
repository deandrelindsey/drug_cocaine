RegisterNetEvent('drug_cocaine:useEffect', function(stage)
    local ped = PlayerPedId()
    local effect = "DrugsTrevorClownsFight"

    if stage == 'crack' or stage == 'fishscale' then
        effect = "DrugsMichaelAliensFight"
    end

    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_SMOKING", 0, true)
    Wait(3000)
    ClearPedTasks(ped)

    StartScreenEffect(effect, 0, true)
    ShakeGameplayCam("DRUNK_SHAKE", 1.0)
    Wait(25000)
    StopScreenEffect(effect)
    ShakeGameplayCam("DRUNK_SHAKE", 0.0)
end)
