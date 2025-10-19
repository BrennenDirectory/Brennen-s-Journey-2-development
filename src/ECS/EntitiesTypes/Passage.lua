local IDS_TABLE = "Passages"

local function interact(thisEntity, otherEntity)
    local passageData = thisEntity.components.passageData

    if not passageData.canOpen and otherEntity.tags.isControlledByUser then
        return
    elseif not passageData.isLocked then
        passageData.isOpen = not passageData.isOpen
    end

    local scriptData = thisEntity.components.scriptData
    local meetsRequirements
    if scriptData then
        thisEntity.systems.scriptedEvents:execute(otherEntity)
        meetsRequirements = scriptData.returnedData
        if meetsRequirements then
            passageData.isLocked = false
            passageData.isOpen = true
        else
            return
        end
    end

    local saveData = otherEntity.components.saveData
    if saveData then
        local tiledID = thisEntity.components.tiledID
        if saveData.content[IDS_TABLE] then
            if not saveData.content[IDS_TABLE][tiledID] then
                saveData.content[IDS_TABLE][tiledID] = true
            end
        else
            saveData.content[IDS_TABLE] = {}
            saveData.content[IDS_TABLE][tiledID] = true
        end
    end
end

local function onCreation(thisEntity)
    Signal.emit("EntityCreated", IDS_TABLE, thisEntity)
end

local function Passage(TiledObject)
    local passage = Entity()

    local systems = {
        "interactableBehavior",
        "entityCreation"
    }

    local components = {
        ['tiledID'] = TiledObject.id,
        ['passageData'] = {
            isOpen = TiledObject.properties.IsOpen,
            isLocked = TiledObject.properties.IsLocked,
            canOpen = TiledObject.properties.CanOpen
        },
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = TiledObject.width,
            height = TiledObject.height,
            collisionClass = "Passage",
            type = "static",
            hasFixedRotation = true,
            friction = 0
        },
        ['interactableData'] = {
            onInteract = interact
        },
        ['creationData'] = {
            onCreation = onCreation
        }
    }

    if TiledObject.properties.HasScriptedEvent then
        components['scriptData'] = {
            isFromTiled = true,
            path = TiledObject.properties.ScriptPath
        }

        table.insert(systems, "scriptedEvents")
    end

    passage:addComponents(components)
    passage:addSystems(systems)

    return passage
end

return Passage