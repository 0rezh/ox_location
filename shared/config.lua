local Shared <const> = {

    debug = false,
    menuSystem = 'traget', -- 'target' or 'marker'
    TimerSystem = true, -- 'true' or 'false'
    Timer = {900000, 1800000, 3600000}, -- 15 min, 30 min, 1h
    TimerMultiplier = {1.5, 2, 2.5}, -- Price multiplier in relation to the time

    NotifyTitle = 'Location', -- Notification Title
    MenuTitle = 'Location', -- Menu Title

    MoneyItemName = 'money', -- Item name for money
    NumberPlate = 'LOCATION', -- Number plate for rented vehicles

    BlipSprite = 77,
    BlipScale = 1.0,
    BlipColour = 63,
    BlipName = 'Location',

    MarkerType = 6, -- https://docs.fivem.net/docs/game-references/markers/

    Category = { -- for image : https://docs.fivem.net/docs/game-references/vehicle-models/
        ['car'] = {
            {name = 'Adder', model = 'adder', price = 1000, image = 'https://docs.fivem.net/vehicles/adder.webp'},
            {name = 'Banshee', model = 'banshee', price = 1000, image = 'https://docs.fivem.net/vehicles/banshee.webp'},
            {name = 'Buffalo', model = 'buffalo', price = 1000, image = 'https://docs.fivem.net/vehicles/buffalo.webp'},
            {name = 'Comet', model = 'comet2', price = 1000, image = 'https://docs.fivem.net/vehicles/comet2.webp'},
        },
        ['boat'] = {
            {name = 'Dinghy', model = 'dinghy', price = 1000, image = 'https://docs.fivem.net/vehicles/dinghy.webp'},
            {name = 'Jetmax', model = 'jetmax', price = 1000, image = 'https://docs.fivem.net/vehicles/jetmax.webp'},
            {name = 'Marquis', model = 'marquis', price = 1000, image = 'https://docs.fivem.net/vehicles/marquis.webp'},
            {name = 'Seashark', model = 'seashark', price = 1000, image = 'https://docs.fivem.net/vehicles/seashark.webp'},
        },
    },

    Location = {
        {pos = vector4(-1034.211, -2732.586, 19.169, 150.642), posSpawn = vector4(-1032.544, -2729.254, 20.148, 237.819), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-346.459, -874.49, 30.095, 258.599), posSpawn = vector4(-339.89, -876.001, 31.071, 165.2), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-801.193, -1513.21, 0.595, 292.583), posSpawn = vector4(-797.475, -1502.175, -0.475, 112.369), type = 'a_m_m_business_01', category = 'boat', icon = 'fa-solid fa-ship'},
    },

}

_ENV.Shared = Shared