local systems = {
    "hitboxInit",
    "hitboxCollisions"
}

local function RespawnPoint(TiledObject)
    local respawnPoint = Entity()

    local components = {
        ['tiledID'] = TiledObject.id,
        ['position'] = {
            x = TiledObject.x,
            y = TiledObject.y
        },
        ['body'] = {
            width = TiledObject.width,
            height = TiledObject.height
        },
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = TiledObject.width,
            height = TiledObject.height,
            collisionClass = "RespawnPoint",
            type = "static",
            hasFixedRotation = true
        },
        ['collisionData'] = {
            onEnterClasses = {"Player"},
            onEnterEvent = function(thisEntity, otherEntity)
                local rsData = otherEntity.components.respawnData
                local thisComp = thisEntity.components

                rsData.x = thisComp.position.x
                rsData.y = thisComp.position.y
                rsData.width = thisComp.body.width
                rsData.height = thisComp.body.height
                rsData.id = thisComp.tiledID
            end
        }
    }

    respawnPoint:addComponents(components)
    respawnPoint:addSystems(systems)

    return respawnPoint
end

return RespawnPoint