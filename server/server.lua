ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('ox_location:rentVehicle', function(source, cb, price, timer)
    local _source = source
    local money = exports.ox_inventory:GetItemCount(_source, Shared.MoneyItemName)

    if money >= price then
        exports.ox_inventory:RemoveItem(source, Shared.MoneyItemName, price)
        TriggerClientEvent('ox_lib:notify', _source, {
            title = Shared.NotifyTitle, 
            description = 'Vous avec loué le véhicule avec succès',
            position = 'top',
            style = {
                backgroundColor = '#141517',
                color = '#C1C2C5',
                ['.description'] = {
                  color = '#909296'
                }
            },
            iconColor = '#198754',
            icon = 'check',
        })
        cb(true)
    else
        TriggerClientEvent('ox_lib:notify', _source, {
            title = Shared.NotifyTitle, 
            description = 'Vous n\'avez pas assez d\'argent',
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
        cb(false)
    end
end)