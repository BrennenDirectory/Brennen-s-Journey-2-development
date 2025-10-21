local ID_TABLE = "BreakableIDs"

local systems = {
    "entityCreation"
}

local function Breakable(TiledObject)
    local breakable = Entity()

    local components = {
        ['breakable'] = {
            damageSources = TiledObject.properties.DamageSources
        },
        ['tiledID'] = TiledObject.id,
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = TiledObject.width,
            height = TiledObject.height,
            collisionClass = "Breakable",
            type = "static",
            hasFixedRotation = true,
            friction = 0
        },
        ['creationData'] = {
            onCreation = function(thisEntity)
                Signal.emit("EntityCreated", ID_TABLE, thisEntity)
            end
        }
    }

    breakable:addComponents(components)
    breakable:addSystems(systems)

    return breakable
end

return Breakable