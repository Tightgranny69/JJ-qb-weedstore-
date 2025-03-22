local QBCore = exports['qb-core']:GetCoreObject()

-- Define shop items
local shopItems = {
    label = "Weed Store",
    slots = 5,
    items = {
        [1] = {name = "weed_seeds", price = 50, amount = 100, type = "item", slot = 1},
        [2] = {name = "fertilizer", price = 25, amount = 100, type = "item", slot = 2},
    }
}

-- When the shop is opened, send the shop inventory to the client
RegisterNetEvent('qb-weedstore:openShop', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        TriggerClientEvent('inventory:client:OpenShop', src, shopItems)
    end
end)

-- Optional: Handle selling seeds (if you want players to sell back weed seeds)
RegisterNetEvent('qb-weedstore:sellSeeds', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveItem("weed_seeds", 1) then
        Player.Functions.AddMoney("cash", 25)  -- Adjust sell price as needed
        TriggerClientEvent('QBCore:Notify', src, "You sold a weed seed for $25!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any seeds!", "error")
    end
end)
