local Shared <const> = {

    debug = true,
    menuSystem = 'marker', -- 'target' or 'marker'
    
    NotifyTitle = 'Location', -- Notification Title
    MenuTitle = 'Location', -- Menu Title

    MoneyItemName = 'money', -- Item name for money
    NumberPlate = 'LOCATION', -- Number plate for rented vehicles

    BlipSprite = 77,
    BlipScale = 1.0,
    BlipColour = 63,
    BlipName = 'Location',

    MarkerType = 6, -- https://docs.fivem.net/docs/game-references/markers/

    Category = {
        ['car'] = {
            {name = 'Adder', model = 'adder', price = 1000},
            {name = 'Banshee', model = 'banshee', price = 1000},
            {name = 'Buffalo', model = 'buffalo', price = 1000},
            {name = 'Comet', model = 'comet2', price = 1000},
        },
        ['boat'] = {
            {name = 'Dinghy', model = 'dinghy', price = 1000},
            {name = 'Jetmax', model = 'jetmax', price = 1000},
            {name = 'Marquis', model = 'marquis', price = 1000},
            {name = 'Seashark', model = 'seashark', price = 1000},
        },
    },

    Location = {
        {pos = vector4(-1034.211, -2732.586, 19.169, 150.642), posSpawn = vector4(-1032.544, -2729.254, 20.148, 237.819), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-346.459, -874.49, 30.095, 258.599), posSpawn = vector4(-339.89, -876.001, 31.071, 165.2), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-801.193, -1513.21, 0.595, 292.583), posSpawn = vector4(-797.475, -1502.175, -0.475, 112.369), type = 'a_m_m_business_01', category = 'boat', icon = 'fa-solid fa-ship'},
    },

}

_ENV.Shared = Shared