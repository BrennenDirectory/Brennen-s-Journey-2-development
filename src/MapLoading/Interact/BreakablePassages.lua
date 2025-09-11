--[[
a shared function that can be called when the Sand/Gravity Bomb, the Player's sword, or any damage spell hits
a breakable object (most of the time a wall)
]]

--[[
    DAMAGE SOURCES
    
    Any
    Weapon
    Spell
    GravelBomb
    SandBomb

]]

local Breakables = {}
local AvailableBreakables = {}

function Breakables.new(object)
    -- a custom health value will be associated with the physics object
    local breakable = world:newRectangleCollider(object.x, object.y, object.width, object.height)
    breakable:setCollisionClass("Breakable")
    breakable:setFriction(0)
    breakable:setType("static")
    breakable.health = object.properties.Health or 1
    breakable.damageSource = object.properties.DamageSource or "Any"
    table.insert(AvailableBreakables, breakable)
    breakable = nil
end

function Breakables.Destroy()
    for i, v in ipairs(AvailableBreakables) do
        v:destroy()
        AvailableBreakables[i] = nil
    end
end

function Breakables.damageObject(physicsObject, amount)
    physicsObject.health = physicsObject.health - amount
    if physicsObject.health <= 0 then
        physicsObject:destroy()
        for i, v in ipairs(AvailableBreakables) do
            if v == physicsObject then
                AvailableBreakables[i] = nil
                break
            end
        end
    end
end

return Breakables