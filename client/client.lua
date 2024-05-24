ESX = exports["es_extended"]:getSharedObject()
local ListVehicle = {}
local Location = Shared.Location
local timer = nil
local optionsTimer = {}

ped = require("client/ped")
blips = require("client/blips")

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
                            TriggerEvent('ox_location:openLocation', Shared.Location[i].category, Shared.Location[i].icon, Shared.Location[i].posSpawn)
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

    local blips = blips:new(Shared.Location[i].pos, Shared.BlipSprite, Shared.BlipScale, Shared.BlipColour, Shared.BlipName)
    local blip = AddBlipForCoord(blips.blipPos.x, blips.blipPos.y, blips.blipPos.z)
    SetBlipScale(blip, blips.blipScale)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, blips.blipSprite)
    SetBlipColour(blip, blips.blipsColor)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(blips.blipName)
    EndTextCommandSetBlipName(blip)
end

---@param category string
---@param icon string
---@param posSpawn vector4
RegisterNetEvent('ox_location:openLocation', function(category, icon, posSpawn)
    local ListVehicle = {}
    for k,v in pairs(Shared.Category[category]) do
        if Shared.debug then
            print("[DEBUG] Vehicle Model : " .. v.model)
        end
        table.insert(ListVehicle, {
            icon = icon,
            title = v.name,
            image = v.image,
            arrow = true,
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
                    local price = v.price
                    if Shared.TimerSystem then
                        local optionsTimer = {}

                        if #Shared.Timer ~= #Shared.TimerMultiplier then
                            lib.notify({
                                title = Shared.NotifyTitle,
                                description = 'Erreur dans la configuration ! (TimerMultiplier)',
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
                            return
                        end

                        for i = 1, #Shared.Timer do
                            table.insert(optionsTimer, {
                                type = 'checkbox',
                                label = Shared.Timer[i] // 60000 .. ' minutes | Prix : ' .. math.tointeger(v.price * Shared.TimerMultiplier[i]) .. '$',
                                required = false,
                            })
                        end

                        timer = lib.inputDialog('Temps de Location', optionsTimer)

                        if not timer then return lib.showContext('openLocation') end
                        
                        local times = Shared.Timer
                        local selectedTime = nil
                        local selectedCount = 0

                        for i, isSelected in ipairs(timer) do
                            if isSelected then
                                selectedCount = selectedCount + 1
                                if selectedCount > 1 then
                                    lib.notify({
                                        title = Shared.NotifyTitle,
                                        description = 'Vous ne pouvez pas sélectionner plusieurs temps de location !',
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
                                    return
                                end
                                selectedTime = times[i]
                            end
                        end

                        for key, value in pairs(timer) do
                            if value == true then
                                TimerMultiplier = Shared.TimerMultiplier[key]
                                price = price * TimerMultiplier
                            end
                        end

                        if selectedTime then
                            timer = selectedTime
                        end          

                        if Shared.debug then
                            print("[DEBUG] Timer: " .. timer)
                            print("[DEBUG] Price: " .. v.price)
                        end
                    end

                    ESX.TriggerServerCallback('ox_location:rentVehicle', function(HasMoney)
                        if HasMoney then
                            local ModelHash = v.model
                            local MyPed = PlayerPedId()
                            if not IsModelInCdimage(ModelHash) then return end
                            RequestModel(ModelHash)
                            while not HasModelLoaded(ModelHash) do
                              Wait(0)
                            end
                            local Vehicle = CreateVehicle(ModelHash, posSpawn, true, false)
                            SetVehicleNumberPlateText(Vehicle, Shared.NumberPlate)
                            SetModelAsNoLongerNeeded(ModelHash)
                            SetPedIntoVehicle(MyPed, Vehicle, -1)
                            if Shared.TimerSystem then
                                if Shared.debug then
                                    print("[DEBUG] Timer: " .. timer)
                                end
                                Wait(timer)
                                SetEntityAsMissionEntity(Vehicle, true, true)
                                DeleteVehicle(Vehicle)
                                lib.notify({
                                    title = Shared.NotifyTitle, 
                                    description = 'Votre location est terminée',
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
                            end
                        end
                    end, price, timer)
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