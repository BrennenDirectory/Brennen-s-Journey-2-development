local REMAINING_CHARS = 2
local PATH_TO_MAPS = "src.TiledProject.Tilemaps."
local PATH_TO_DRAW_MAPS = "src/TiledProject/Tilemaps/"
local FILE_EXT = ".lua"
-- We bend the rules a little bit and use some functions instead of just pure data
local function getTeleportPointFromMap(tpID, map)
    local otherMap = require(map)
    for i, layer in ipairs(otherMap.layers) do
        if layer.name == "Objects" then
            for _, obj in ipairs(layer.objects) do
                if obj.id == tpID and obj.name == "TeleportPoint" then
                    return {
                        x = obj.x,
                        y = obj.y
                    }
                end
            end
        end
    end
end

return function(data)
    local areaNumIndex = data.mapPath:find('-') - 1
    local subArea = data.mapPath:sub(areaNumIndex, areaNumIndex + REMAINING_CHARS)
    local areaNumber = subArea:sub(1, 1)

    local map = PATH_TO_MAPS .. areaNumber .. '.' .. subArea

    return {
        map = require(map),
        drawableMap = sti(PATH_TO_DRAW_MAPS .. areaNumber .. '/' .. subArea .. FILE_EXT),
        teleportPoint = getTeleportPointFromMap(data.teleportPointID, map)
    }
end