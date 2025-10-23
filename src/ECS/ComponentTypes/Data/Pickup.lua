-- Pickups can be a health/mana replenishment, armor?, weapon, tacey buck, sack of experience?

local PickupTypes = {
    ['WeaponPickup'] = function(thisEntity, otherEntity)
        thisEntity.components.hitbox:destroy()
        thisEntity.systems.scriptedEvents:execute(otherEntity)
        thisEntity:destroy()
    end
}

local systems = {
    "hitboxCollisions",
    "hitboxInit"
}

local function Pickup(ObjectData)
    local pickup = Entity()

    local components = {
        ['body'] = {
            width = ObjectData.width,
            height = ObjectData.height
        },
        ['hitbox'] = {
            x = ObjectData.x,
            y = ObjectData.y,
            width = ObjectData.width,
            height = ObjectData.height,
            type = ObjectData.properties.Type,
            collisionClass = ObjectData.properties.CollisionClass,
            hasFixedRotation = ObjectData.properties.HasFixedRotation,
            friction = ObjectData.properties.Friction,
            restitution = ObjectData.properties.Restitution
        },
        ['collisionData'] = {
            onEnterClasses = {"Player"},
            onEnterEvent = PickupTypes[ObjectData.type]
        },
        ['pickupData'] = {
            name = ObjectData.properties.Name
        }
    }

    if ObjectData.properties.HasScriptedEvent then
        components['scriptData'] = {
            isFromTiled = ObjectData.properties.IsFromTiled,
            path = ObjectData.properties.ScriptPath
        }

        table.insert(systems, "scriptedEvents")
    end

    pickup:addComponents(components)
    pickup:addSystems(systems)

    return pickup
end

return Pickup