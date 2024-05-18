local blips = {}

---@param pBlipPos vector3
---@param pBlipSprite integer
---@param pBlipScale float
---@param pBlipsColor integer
---@param pBlipName string
function blips:new(pBlipPos, pBlipSprite, pBlipScale, pBlipsColor, pBlipName)
    local instance = {}
    setmetatable(instance, {__index = blips})
    instance.blipPos = pBlipPos
    instance.blipSprite = pBlipSprite
    instance.blipScale = pBlipScale
    instance.blipsColor = pBlipsColor
    instance.blipName = pBlipName

    return instance
end

return blips