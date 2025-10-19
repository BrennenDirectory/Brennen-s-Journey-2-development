if true then
    return -- MODULE HAS BEEN REWRITTEN!
end

local LoadingZones = {}
local Zones = {}

local PATH_TO_MAPS = "src.TiledProject.Tilemaps."
local file, otherMap
local EXTENSION_CHARS = 2 -- Includes the '-' dash and sub area number

-- gets the X, and Y position of a Point from its ID in a different map that the Player will teleport to when the loading zone is triggered.
local function getTeleportPointFromMap(TeleportPointID, MapForTeleportPoints)
    otherMap = require(MapForTeleportPoints)
    for i, layer in ipairs(otherMap.layers) do
        if layer.name == "TeleportPoints" then
            for _, point in ipairs(layer.objects) do
                if point.id == TeleportPointID then
                    return {x = point.x, y = point.y}
                end
            end
        end
    end
end

function LoadingZones.new(object)
    local zone = world:newRectangleCollider(object.x, object.y, object.width, object.height)

    -- NeedsInteract determines if the LoadingZone should be interacted via physical contact or interacting with 'e' key.
    if object.properties.NeedsInteract then
        zone:setCollisionClass("InteriorZone")
    else
        zone:setCollisionClass("LoadingZone")
    end

    zone:setType("static")

    local badPathToMap = object.properties.MapToLoad
    local mainAreaNumberIndex = string.find(badPathToMap, "-") - 1
    file = string.sub(badPathToMap, mainAreaNumberIndex, mainAreaNumberIndex + EXTENSION_CHARS)
    local areaNumber = string.sub(file, 1, 1)

    zone.MapForTeleportPoints = PATH_TO_MAPS .. areaNumber .. "." .. file
    zone.NextMapAreaNumber = areaNumber
    zone.NextMapArea = file
    zone.TeleportPoint = getTeleportPointFromMap(object.properties.TeleportPointID, zone.MapForTeleportPoints)
    table.insert(Zones, zone)
    zone = nil
end

function LoadingZones.Destroy()
    for i, v in ipairs(Zones) do
        v:setActive(false)
        v:destroy()
        Zones[i] = nil
    end
end

return LoadingZones