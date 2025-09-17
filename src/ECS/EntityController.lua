local EntityController = {}

local Entities = require"src.ECS.Entities"

local entitiesInWorld = {}

function EntityController.load() -- use later to load entities slowly into memory
    local crate = Entities['Crate']({
        x = 269,
        y = -129,
        properties = {
            CanHold = true
        }
    })

    local player = Entities['Player']()

    table.insert(entitiesInWorld, crate)
        table.insert(entitiesInWorld, player)

end

function EntityController.update(dt)
    for i, entity in ipairs(entitiesInWorld) do
        if entity.flagForRemoval then
            return
        end

        for system, systemModule in pairs(entity.systems) do
            if systemModule.update then
                systemModule:update(dt)
            end
        end
    end
end

function EntityController.draw()
    for i, entity in ipairs(entitiesInWorld) do
        if entity.flagForRemoval then
            return
        end

        for system, systemModule in pairs(entity.systems) do
            if systemModule.draw then
                systemModule:draw()
            end
        end
    end
end

function EntityController.newEntity(TiledObject)
    table.insert(entitiesInWorld, Entities[TiledObject.type](TiledObject))
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

Signal.register("DestroyEntity", function(...)
    print(...)
    ---EntityController.remove(entity)
end)

return EntityController