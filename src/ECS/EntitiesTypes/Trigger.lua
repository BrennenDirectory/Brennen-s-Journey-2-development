local IDS_TABLE = "TriggerIDs"
local systems = {
    "hitboxCollisions",
    "scriptedEvents"
}

local function Trigger(Object) -- Can be a TiledObject or a hard coded table
    local trigger = Entity()
    
    local components = {
        ['tiledID'] = Object.id,
        ['hitbox'] = {
            x = Object.x,
            y = Object.y,
            width = Object.width > 0 and Object.width or 1,
            height = Object.height > 0 and Object.height or 1,
            type = "static",
            hasFixedRotation = true,
            collisionClass = "Trigger"
        },

        ['scriptData'] = {
            isFromTiled = Object.properties.IsFromTiled,
            path = Object.properties.ScriptPath
        },

        ['collisionData'] = {
            onEnterClasses = Object.properties.CollisionClasses or {"Player"},
            onEnterEvent = function(entity, otherEntity)
                local tiledID = entity.components.tiledID
                local saveData = otherEntity.components.saveData

                if not saveData.content[IDS_TABLE] then
                    saveData.content[IDS_TABLE] = {}
                elseif saveData.content[IDS_TABLE][tiledID] then
                    return
                end

                saveData.content[IDS_TABLE][tiledID] = true

                entity.systems.scriptedEvents:execute(otherEntity)
            end
        }
    }


    trigger:addComponents(components)
    trigger:addSystems(systems)

    trigger.components.hitbox:setObject(trigger)

    return trigger
end

return Trigger