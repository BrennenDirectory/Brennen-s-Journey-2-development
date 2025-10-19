-- This module renders meshes to polygons such as stairs or complex geometry that doesnt support square tiles.
local RenderPolygons = {}
local CurrentPolygons = {}

local Textures = require"src.MapLoading.Terrain.Textures"

for id, texture in pairs(Textures) do
    texture:setFilter("nearest", "nearest")
end

function RenderPolygons.create(object)
    local PolygonData = {
        X = object.x,
        Y = object.y,
        Mesh = nil
    }

    local vertices = {}
    for i, point in ipairs(object.polygon) do
        table.insert(vertices, {
            point.x, point.y, math.random(), math.random(), 1, 1, 1
        })
    end

    local mesh = love.graphics.newMesh(vertices, "fan")
    mesh:setTexture(Textures[object.properties.TextureID])
    

    PolygonData.Mesh = mesh
    table.insert(CurrentPolygons, PolygonData)
    
    PolygonData, vertices, mesh = nil, nil, nil
end

function RenderPolygons.draw()
    for i, polygon in ipairs(CurrentPolygons) do
        love.graphics.draw(polygon.Mesh, polygon.X, polygon.Y)
    end
end

function RenderPolygons.remove()
    for i = 1, #CurrentPolygons do
        CurrentPolygons[i] = nil
    end
end

return RenderPolygons