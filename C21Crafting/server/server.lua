ESX.RegisterServerCallback('callback:checkCount', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getInventoryItem('sprezynka').count >= 1 and xPlayer.getInventoryItem('obudowa').count >= 1 and xPlayer.getInventoryItem('magazynek').count >= 1 then
        cb(true)
    else
        cb(false)    
    end    
end)

ESX.RegisterServerCallback('server:giveItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if(randomChance(60)) then
        xPlayer.addInventoryItem("weapon_pistol", 1)
    else
        xPlayer.addInventoryItem("weapon_vintagepistol", 1)
    end    
    xPlayer.addInventoryItem("ammo-pistol", 20)
end)

ESX.RegisterServerCallback('server:removeItems', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem("sprezynka", 1)
    xPlayer.removeInventoryItem("obudowa", 1)
    xPlayer.removeInventoryItem("magazynek", 1)
end)

function randomChance(percent)
    assert(percent >= 0 and percent <= 100)
    return percent >= math.random(1, 100)
end
