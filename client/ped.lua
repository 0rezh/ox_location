local ped = {}

---@param pPedType string
---@param pPedPos vector4
---@return table
function ped:new(pPedType, pPedPos)
    local instance = {}
    setmetatable(instance, {__index = ped})
    instance.pedtype = pPedType
    instance.pedpos = pPedPos

    return instance
end

return ped