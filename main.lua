local QBCore = exports['qb-core']:GetCoreObject()

local weedShopLocation = Config.WeedStore.location
local pedModel = Config.WeedStore.pedModel

-- Create NPC at the shop location
CreateThread(function()
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(100)
    end
    local weedShopPed = CreatePed(4, pedModel, weedShopLocation.x, weedShopLocation.y, weedShopLocation.z - 1.0, 0.0, false, true)
    SetEntityInvincible(weedShopPed, true)
    FreezeEntityPosition(weedShopPed, true)
    SetBlockingOfNonTemporaryEvents(weedShopPed, true)
end)

-- Create a blip on the map for the store
CreateThread(function()
    local blip = AddBlipForCoord(weedShopLocation.x, weedShopLocation.y, weedShopLocation.z)
    SetBlipSprite(blip, 140)  -- Adjust icon if needed
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.8)
    SetBlipColour(blip, 2)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Weed Store")
    EndTextCommandSetBlipName(blip)
end)

-- Setup qb-target interaction with the NPC
CreateThread(function()
    exports['qb-target']:AddTargetModel(pedModel, {
        options = {
            {
                type = "client",
                event = "qb-weedstore:openShop",
                icon = "fas fa-cannabis",
                label = "Buy Weed Seeds",
            },
        },
        distance = 2.0
    })
end)

-- Trigger the shop open event (calls the server to process the shop logic)
RegisterNetEvent('qb-weedstore:openShop', function()
    TriggerServerEvent('qb-weedstore:openShop')
end)
