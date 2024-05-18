local Shared <const> = {

    debug = true,
    menuSystem = 'marker', -- 'target' or 'marker'
    
    NotifyTitle = 'Location', -- Notification Title
    MenuTitle = 'Location', -- Menu Title

    MarkerType = 6, -- https://docs.fivem.net/docs/game-references/markers/

    Category = {
        ['car'] = {
            {name = 'Adder', model = 'adder'},
            {name = 'Banshee', model = 'banshee'},
            {name = 'Buffalo', model = 'buffalo'},
            {name = 'Comet', model = 'comet2'},
        },
        ['boat'] = {
            {name = 'Dinghy', model = 'dinghy'},
            {name = 'Jetmax', model = 'jetmax'},
            {name = 'Marquis', model = 'marquis'},
            {name = 'Seashark', model = 'seashark'},
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