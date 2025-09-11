local PhysicsObjects = {}
local objects = {} -- contains physical object classes like Moving Platforms

local ObjectTypes = {
    ['Crate'] = function(...) return Crate(...) end,
    ['MovingPlatform'] = function(...) return MovingPlatform(...) end,
    ['SwingingPlatform'] = function(...) return SwingingPlatform(...) end
}

function PhysicsObjects.addObject(objectClass)
    table.insert(objects, objectClass)
end

function PhysicsObjects.update(dt)
    for i, v in ipairs(objects) do
        if v.update and v.hitbox then
            v:update(dt)
        end
    end
end

function PhysicsObjects.draw()
    for i, v in ipairs(objects) do
        if v.render and v.hitbox then
            v:render()
        end
    end
end

function PhysicsObjects.Create(ObjectLayers)
    if ObjectLayers.PhysicsObjects then
        for i, object in ipairs(ObjectLayers.PhysicsObjects) do
            local physicsObject = ObjectTypes[object.name](object)
            table.insert(objects, physicsObject)
            physicsObject = nil
        end
    end
end

function PhysicsObjects.Destroy()
    for i, v in ipairs(objects) do
        if v then
            v:destroy()
            objects[i] = nil
        end
    end
end

return PhysicsObjects