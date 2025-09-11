local Terrain = {}

local PolygonRendering = require"src.MapLoading.Terrain.PolygonRendering"
local Enemies = require"src.EnemyClasses.Enemies"
local player = require"src.Player.player"

local TerrainObjects = {}
local CurrentKillZone
local KillZoneDamageMultiplier = 0.10


local TerrainTypes = {
    ['Wall'] = function(obj)
        -- walls will always be vertical
        local wall = world:newLineCollider(obj.x, obj.y, obj.x, obj.y + obj.height)
        wall:setType("static")
        wall:setFriction(0)
        wall:setCollisionClass("Wall")
        return wall
    end,

    ['Ground'] = function(obj)
        local ground
        if obj.shape == "rectangle" then
            -- ground will always be horizontal unless it is a polygon
            ground = world:newLineCollider(obj.x, obj.y, obj.x + obj.width, obj.y)

            -- i have to add this stupid line to every piece of straight Ground so the player doesnt fucking stick to the sides...
            local frictionless = world:newLineCollider(obj.x - 0.5, obj.y + 1, obj.x + obj.width + 0.5, obj.y + 1)
            frictionless:setType("static")
            frictionless:setFriction(0)
            frictionless:setCollisionClass("Wall")

            table.insert(TerrainObjects, frictionless)
            frictionless = nil
        elseif obj.shape == "polygon" then
            local vertices = {}
            for i, point in ipairs(obj.polygon) do
                table.insert(vertices, point.x)
                table.insert(vertices, point.y)
            end
            
            ground = world:newPolygonCollider(vertices)
            ground:setX(obj.x)
            ground:setY(obj.y)

            -- Some complex shapes may be invisible
            if obj.type ~= "" then
                PolygonRendering.Create(obj)
            end
        end

        ground:setType("static")
        ground:setCollisionClass("Ground")
        ground:setFriction(0.5)

        return ground
    end,

    ['KillZone'] = function(obj)
        local killzone = world:newLineCollider(obj.x, obj.y, obj.x + obj.width, obj.y)
        killzone:setType("static")
        killzone:setCollisionClass("KillZone")
        CurrentKillZone = killzone
        return killzone
    end
}

function Terrain.Create(ObjectLayer) -- table of object layers, eventually turn into a group layer instead of individual object layers
    for i, object in ipairs(ObjectLayer) do
        -- object.type == Class in Tiled
        local _type
        if object.type ~= "KillZone" then
            if object.width == 0 and object.shape ~= "polygon" then
                _type = "Wall"
            else
                _type = "Ground"
            end
        else
            _type = object.type
        end

        local terrainObj = TerrainTypes[_type](object)

        table.insert(TerrainObjects, terrainObj)
        terrainObj = nil
    end
end

function Terrain.update(dt)
    if CurrentKillZone then
        if CurrentKillZone:enter("Player") then
            if player.takeDamage(player.health * KillZoneDamageMultiplier, true) then
                player.respawn(true)
            end
        elseif CurrentKillZone:enter("Enemy") then
            local collisionData = CurrentKillZone:getEnterCollisionData("Enemy")
            Enemies.forceKill(collisionData.collider:getObject())
            collisionData = nil
        elseif CurrentKillZone:enter("Crate") then
            local collisionData = CurrentKillZone:getEnterCollisionData("Crate")
            local crate = collisionData.collider:getObject()
            crate:reset()
            collisionData = nil
            crate = nil
        end
    end
end

function Terrain.Draw()
    PolygonRendering.Draw()
end

function Terrain.Destroy()
    for i, v in ipairs(TerrainObjects) do
        v:destroy()
        TerrainObjects[i] = nil
    end

    PolygonRendering.Remove()
end

return Terrain



