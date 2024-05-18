local Shared <const> = {

    debug = true,
    menuSystem = 'marker', -- 'target' or 'marker'
    
    NotifyTitle = 'Location', -- Notification Title
    MenuTitle = 'Location', -- Menu Title

    MoneyItemName = 'money', -- Item name for money

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
        {pos = vector4(-74.59, -821.488, 325.175, 12.84), posSpawn = vector4(-71.495, -820.553, 326.175, 243.582), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-77.472, -819.852, 325.175, 290.1), posSpawn = vector4(-71.495, -820.553, 326.175, 243.582), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-75.155, -816.736, 325.175, 176.052), posSpawn = vector4(-71.495, -820.553, 326.175, 243.582), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-76.756, -820.697, 325.175, 266.797), posSpawn = vector4(-71.495, -820.553, 326.175, 243.582), type = 'a_m_m_business_01', category = 'car', icon = 'fa-solid fa-car'},
        {pos = vector4(-73.651, -817.165, 325.175, 136.431), posSpawn = vector4(-71.495, -820.553, 326.175, 243.582), type = 'a_m_m_business_01', category = 'boat', icon = 'fa-solid fa-ship'},
    },

}

_ENV.Shared = Shared