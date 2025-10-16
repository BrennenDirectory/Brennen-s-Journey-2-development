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

    table.insert(entitiesInWorld, crate)
    table.insert(entitiesInWorld, player)

end

function EntityController.update(dt)
    for i, entity in ipairs(entitiesInWorld) do
        if not entity.flagForRemoval then
            for system, systemModule in pairs(entity.systems) do
                if systemModule.update then
                    systemModule:update(dt)
                end
            end
        end
    end
end

function EntityController.draw()
    for i, entity in ipairs(entitiesInWorld) do
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
    table.insert(entitiesInWorld, Entities[ObjectData.type](ObjectData))
end

function EntityController.remove(entity)
    for i = 1, #entitiesInWorld do
        if entitiesInWorld[i] == entity then
            entity:destroy()
            entitiesInWorld[i] = nil
            break
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