local ID_TABLE = "TriggerIDs"
local systems = {
    "hitboxCollisions",
    "scriptedEvents",
    "hitboxInit"
}

local function Trigger(Object) -- Can be a TiledObject or a hard coded table
    local trigger = Entity()
    
    local components = {
        ['tiledID'] = Object.id,
        ['hitbox'] = {
            x = Object.x,
            y = Object.y,
            width = Object.width,
            height = Object.height,
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

                if not saveData.content[ID_TABLE] then
                    saveData.content[ID_TABLE] = {}
                elseif saveData.content[ID_TABLE][tiledID] then
                    return
                end

                saveData.content[ID_TABLE][tiledID] = true

                entity.systems.scriptedEvents:execute(otherEntity)
            end
        }
    }


    trigger:addComponents(components)
    trigger:addSystems(systems)


    return trigger
end

return Trigger