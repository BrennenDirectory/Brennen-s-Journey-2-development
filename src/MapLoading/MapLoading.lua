local MapLoading = {}

local player = require("src.Player.player")
local Enemies = require"src.EnemyClasses.Enemies"
local Terrain = require"src.MapLoading.Terrain.Terrain"
local PhysicsObjects = require"src.MapLoading.PhysicsObjects.PhysicsObjects"
local Interact = require"src.MapLoading.Interact.Interact"
local MiscObjects = require"src.MapLoading.MiscObjects.MiscObjects"

MapLoading.CurrentMap = require"src.TiledProject.Tilemaps.1.1-1"
MapLoading.DrawableMap = sti("src/TiledProject/Tilemaps/1/1-1.lua")

local PathToMaps = "src.TiledProject.Tilemaps."
local PathToDrawMaps = "src/TiledProject/Tilemaps/"
local ObjectLayers = {}

local function AssignLayers()
    ObjectLayers = {}
    for _, layer in ipairs(MapLoading.CurrentMap.layers) do
        if layer.type == "objectgroup" then
            ObjectLayers[layer.name] = layer.objects
        elseif layer.type == "group" then -- most likely a group that contains objectgroups
            ObjectLayers[layer.name] = {}
            for i, sublayer in ipairs(layer.layers) do
                ObjectLayers[layer.name][sublayer.name] = sublayer.objects
            end
        end
    end
end

-- Tiled Objects must be detached from Templates for their properties to be read properly.
function MapLoading.CreateMap()
    AssignLayers()
    Terrain.Create(ObjectLayers.Terrain)
    PhysicsObjects.Create(ObjectLayers)
    Enemies.Create(ObjectLayers)
    Interact.Create(ObjectLayers)
    ObjectLayers = {}
end

function MapLoading.update(dt)
    PhysicsObjects.update(dt)
    Terrain.update(dt)
    Interact.update(dt)
    MiscObjects.update(dt)
end

function MapLoading.DestroyMap()
    Terrain.Destroy()
    PhysicsObjects.Destroy()
    Enemies.Remove()
    Interact.Remove()
    MiscObjects.remove()
end

function MapLoading.DrawMap()
    MapLoading.DrawableMap:drawTileLayer("Foreground")
    PhysicsObjects.draw()
    Interact.draw()
    Terrain.Draw()
    MiscObjects.draw()
end

Signal.register("EnteredLoadingZone", function(zone)
    player.setPosition(zone.TeleportPoint.x, zone.TeleportPoint.y)

    MapLoading.CurrentMap = require(PathToMaps .. zone.NextMapAreaNumber .. '.' .. zone.NextMapArea)
    MapLoading.DrawableMap = sti(PathToDrawMaps .. zone.NextMapAreaNumber .. '/' .. zone.NextMapArea .. '.lua')

    MapLoading.DestroyMap()
    MapLoading.CreateMap()
end)

table.insert(_G.UpdateTable, MapLoading.update)
table.insert(_G.DrawTable, MapLoading.DrawMap)

return MapLoading