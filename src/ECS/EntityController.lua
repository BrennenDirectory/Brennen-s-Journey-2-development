local EntityController = {
    CameraControlledEntity = {}
}

local Entities = require"src.ECS.Entities"

local entitiesInWorld = {}

function EntityController.load() -- use later to load entities slowly into memory
    local crate = Entities['Crate']({
        x = 269,
        y = -129,
        properties = {
            CanHold = true,
            CanThrow = false
        }
    })

    local player = Entities['Player']()

    entitiesInWorld[player.id] = player
    entitiesInWorld[crate.id] = crate
end

function EntityController.update(dt)
    for id, entity in pairs(entitiesInWorld) do
        if not entity.flagForRemoval then
            for name, system in pairs(entity.systems) do
                if system.update then
                    system:update(dt)
                end
            end
        end
    end
end

function EntityController.draw()
    for id, entity in pairs(entitiesInWorld) do
        if not entity.flagForRemoval then
            for name, system in pairs(entity.systems) do
                if system.draw then
                    system:draw()
                end
            end
        end
    end
end

function EntityController.newEntity(ObjectData)
    local newEntity = Entities[ObjectData.name]
    if newEntity then
        newEntity = newEntity(ObjectData)
        entitiesInWorld[newEntity.id] = newEntity
    end
end

function EntityController.remove(entity)
    for id, ent in pairs(entitiesInWorld) do
        if id == entity.id then
            entity:destroy()
            entitiesInWorld[id] = nil
            break
        end
    end
end

function EntityController.removeAll(destroyUserControlledEntities)
    for id, entity in pairs(entitiesInWorld) do
        if entity.isControlledByUser and destroyUserControlledEntities then
            entity:destroy()
            entitiesInWorld[id] = nil
        elseif not entity.tags.isControlledByUser then
            entity:destroy()
            entitiesInWorld[id] = nil
        end
    end
end

Signal.register("DestroyEntity", function(entity)
    EntityController.remove(entity)
end)

Signal.register("NewCameraControlledEntity", function(entity)
    EntityController.CameraControlledEntity = entity
end)

return EntityController