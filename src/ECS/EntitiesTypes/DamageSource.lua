local systems = {
    "hitboxInit",
    "hitboxCollisions"
}

local collisionData = {
    onEnterClasses = {"Player", "Crate", "Enemy"},
    onEnterEvent = function(thisEntity, otherEntity)
        local class = otherEntity.components.hitbox.collision_class
        
    end
}

local function DamageSource(TiledObject)
    local damageSource = Entity()

    local components = {
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = TiledObject.width,
            height = TiledObject.height,
            type = "static",
            collisionClass = "DamageSource",
            hasFixedRotation = true
        },
        ['damageData'] = {
            damageToPlayer = TiledObject.properties.DamageToPlayer,
            damageToEnemies = TiledObject.properties.DamageToEnemies,
            damageToCrates = TiledObject.properties.DamageToCrates,
            damageToBreakables = TiledObject.properties.DamageToBreakables
        },
        ['collisionData'] = collisionData
    }

    damageSource:addComponents(components)
    damageSource:addSystems(systems)

    return damageSource
end

return DamageSource