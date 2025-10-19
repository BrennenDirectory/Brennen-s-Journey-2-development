local function onInteract(zone, otherEntity)
    Signal.emit("EnteredZone", zone.components.zoneData, otherEntity)
end

local function Zone(TiledObject)
    local zone = Entity()

    local components = {
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = TiledObject.width,
            height = TiledObject.height,
            type = "static",
            hasFixedRotation = true,
            collisionClass = TiledObject.properties.NeedsInteract and "InteriorZone" or "ExteriorZone"
        },

        ['zoneData'] = {
            mapPath = TiledObject.properties.MapPath,
            teleportPointID = TiledObject.properties.TeleportPointID
        }
    }

    local systems = {}

    if TiledObject.properties.NeedsInteract then
        components['interactableData'] = {
            onInteract = onInteract
        }

        table.insert(systems, "interactableBehavior")
    else
        components['collisionData'] = {
            onEnterClasses = {"Player"},
            onEnterEvent = onInteract
        }

        table.insert(systems, "hitboxCollisions")
    end

    zone:addComponents(components)
    zone:addSystems(systems)

    zone.components.hitbox:setObject(zone)

    return zone
end

return Zone