ESX = exports["es_extended"]:getSharedObject()
local ListVehicle = {}
local Location = Shared.Location

ped = require("client/ped")

Citizen.CreateThread(function()
    if Shared.menuSystem ~= 'marker' then
        for i = 1, #Location do
            local coords = Shared.Location[i].pos
            if Shared.debug then
                print("[DEBUG] Location: " .. Shared.Location[i].category, Shared.Location[i].pos)
            end
            exports.ox_target:addBoxZone({
                coords = Shared.Location[i].pos,
                size = vec3(3, 3, 3),
                rotation = 45,
                drawSprite = true,
                options = {
                    {
                        icon = Shared.Location[i].icon, 
                        label = 'Ouvrir la location',
                        distance = 3,
                        onSelect = function()
                            if Shared.debug then
                                print("[DEBUG] Location: " .. Shared.Location[i].category)
                            end
                            TriggerEvent('ox_location:openLocation', Shared.Location[i].category)
                        end
                    }
                }
            })
        end
    elseif Shared.menuSystem == 'marker' then
        for i = 1, #Location do
            Citizen.CreateThread(function()
                local coords = vec3(Shared.Location[i].pos.x, Shared.Location[i].pos.y, Shared.Location[i].pos.z)
                if Shared.debug then
                    print("[DEBUG] Location: " .. Shared.Location[i].category, Shared.Location[i].pos)
                end
                while true do
                    sleep = 2000
                    local playerPed = PlayerPedId()
                    local PlyCoords = GetEntityCoords(playerPed)
                    local dst = Vdist(PlyCoords, coords)
                    if dst <= 50 then
                        sleep = 0
                        DrawMarker(Shared.MarkerType, coords, nil, nil, nil, -90, nil, nil, 1.0, 1.0, 1.0, 0, 0, 0 , 155)
                    end
                    if dst <= 2.0 then
                        sleep = 0
                        ESX.ShowHelpNotification("Appyuez sur ~INPUT_CONTEXT~ pour ouvrir la location")
                        if IsControlJustPressed(0, 51) then
                            if Shared.debug then
                                print("[DEBUG] Location: " .. Shared.Location[i].category)
                            end
                            TriggerEvent('ox_location:openLocation', Shared.Location[i].category, Shared.Location[i].icon, Shared.Location[i].posSpawn)
                        end
                    end
                    Wait(sleep)
                end
            end)
        end
    end
end)

for i = 1, #Location do
    local ped = ped:new(Shared.Location[i].type, Shared.Location[i].pos)
    Citizen.CreateThread(function()
        local hash = GetHashKey(ped.pedtype)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Wait(1000)
        end
        local ped1 = CreatePed("PED_TYPE_CIVMALE", ped.pedtype, ped.pedpos, false, true)
        SetBlockingOfNonTemporaryEvents(ped1, true)
        SetEntityInvincible(ped1, true)
        FreezeEntityPosition(ped1, true)
    end)
end


---@param category string
---@param icon string
---@param posSpawn vector4
RegisterNetEvent('ox_location:openLocation', function(category, icon, posSpawn)
    local ListVehicle = {}
    for k,v in pairs(Shared.Category[category]) do
        print("[DEBUG] Vehicle Name : " .. v.name)
        table.insert(ListVehicle, {
            icon = icon,
            title = v.name,
            onSelect = function()
                if Shared.debug then
                    print("[DEBUG] Location: " .. v.model)
                end
                if not ESX.Game.IsSpawnPointClear(posSpawn, 5) then
                    lib.notify({
                        title = Shared.NotifyTitle, 
                        description = 'L\'emplacement est bloqué par un véhicule !',
                        position = 'top',
                        style = {
                            backgroundColor = '#141517',
                            color = '#C1C2C5',
                            ['.description'] = {
                              color = '#909296'
                            }
                        },
                        iconColor = '#C53030',
                        icon = 'ban',
                    })
                else
                    local ModelHash = v.model
                    local MyPed = PlayerPedId()
                    if not IsModelInCdimage(ModelHash) then return end
                    RequestModel(ModelHash)
                    while not HasModelLoaded(ModelHash) do
                      Wait(0)
                    end
                    local Vehicle = CreateVehicle(ModelHash, posSpawn, true, false)
                    SetModelAsNoLongerNeeded(ModelHash)
                    SetPedIntoVehicle(MyPed, Vehicle, -1)
                end
            end
        })
    end
    lib.registerContext({
        id = "openLocation",
        title = Shared.MenuTitle,
        options = ListVehicle,
    })
    lib.showContext("openLocation")
end)