local MapLoading = {}

local EntityController = require"src.ECS.EntityController"
local Terrain = require"src.MapLoading.Terrain.Terrain"

local currentMap = require"src.TiledProject.Tilemaps.1.1-1"
local drawableMap = sti("src/TiledProject/Tilemaps/1/1-1.lua")

-- Tiled Objects must be detached from Templates for their properties to be read properly.

function MapLoading.load()
    EntityController.load()
end

function MapLoading.create()
    for i, layer in ipairs(currentMap.layers) do
        if layer.name == "Objects" then
            for j, object in ipairs(layer.objects) do
                if object.name ~= "TeleportPoint" then
                    EntityController.newEntity(object)
                elseif object.name == "TeleportPoint" then
                    
                end
            end
        elseif layer.name == "Terrain" then
            for j, object in ipairs(layer.objects) do
                Terrain.create(object)
            end
        end
    end
end


function MapLoading.update(dt)
    EntityController.update(dt)
end

function MapLoading.destroy()
    EntityController.removeAll(false)
    Terrain.destroy()

end

function MapLoading.draw()
    EntityController.CameraControlledEntity.systems.cameraBehavior:attach()
        drawableMap:drawTileLayer("Foreground")
        EntityController.draw()
        Terrain.draw()
        world:draw()
    EntityController.CameraControlledEntity.systems.cameraBehavior:detach()
end

Signal.register("EnteredZone", function(zone, otherEntity)
    otherEntity.components.hitbox:setPosition(zone.teleportPoint.x, zone.teleportPoint.y)

    currentMap = zone.map
    drawableMap = zone.drawableMap

    MapLoading.destroy()
    MapLoading.create()
end)

return MapLoading