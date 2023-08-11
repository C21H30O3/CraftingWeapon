    exports.qtarget:AddBoxZone("esia", vector3(3812.98, 4446.5, 2.6), 3,1.5, {
        minZ = 20,
        heading = -32,
        maxZ = 18,
        debugPoly = false,
        }, {
    
            options = {
                {
                name = 'wytworzbron',
                event = "c21:wytworzbron",
                icon = 'fa-solid fa-cube',
                label = "Wytwórz broń",
            },
        },
        distance = 1.5
    })



AddEventHandler("c21:wytworzbron", function()
    local player = PlayerPedId()
    ESX.TriggerServerCallback('callback:checkCount', function(cb)
    if not cb then
        lib.notify({
            title = 'Wytwarzanie broni',
            description = 'Nie posiadasz wymaganych przedmiotów!',
            type = 'error'
        })
        return    
    end
    if lib.skillCheck({'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'}) then
        TaskStartScenarioInPlace(player, 'PROP_HUMAN_BUM_BIN', 0, true)
        FreezeEntityPosition(player, true)
        ESX.TriggerServerCallback('server:removeItems', function(cb) end)
        if lib.progressBar({
            duration = 5000,
            label = 'Trwa wytwarzanie broni...',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
            },
        }) then 
            if randomChance(60) then
                lib.notify({
                    title = 'Wytwarzanie broni',
                    description = 'Udało ci się wytworzyć broń!',
                    type = 'success'
                })
                ESX.TriggerServerCallback('server:giveItems', function(cb) end)
                FreezeEntityPosition(player, false)
                ClearPedTasksImmediately(player) 
            else
                lib.notify({
                    title = 'Wytwarzanie broni',
                    description = 'Sprężynka poleciała prosto w twoje oko! Ałć!',
                    type = 'error'
                })
                SetEntityHealth(player, GetEntityHealth(player)-35)
                Citizen.CreateThread(function()
                    while (not HasAnimDictLoaded("anim@heists@ornate_bank@thermal_charge")) do
                        RequestAnimDict( "anim@heists@ornate_bank@thermal_charge" )
                        Citizen.Wait(15) end
                        TaskPlayAnim(player, "anim@heists@ornate_bank@thermal_charge", "cover_eyes_intro", 10.0, 1.0, 600, 2, 1, 0, 0, 0)
                        Wait(4500)
                        FreezeEntityPosition(player, false)
                        ClearPedTasksImmediately(player) 
                    end)
                end   
            else 
                FreezeEntityPosition(player, false)
                ClearPedTasksImmediately(player) 
            end
        else
            lib.notify({
                title = 'Wytwarzanie broni',
                description = 'Popracuj nad skillem!',
                type = 'error'
            })
        end
    end)
end)

function randomChance(percent)
    assert(percent >= 0 and percent <= 100)
    return percent >= math.random(1, 100)
end