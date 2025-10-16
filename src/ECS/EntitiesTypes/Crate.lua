local CRATE_SIZE = 32
local STARTING_MASS = 25

local components = {
    ['hitbox'] = {
        cornerCutSize = 2,
        width = CRATE_SIZE,
        height = CRATE_SIZE,
        mass = STARTING_MASS,
        friction = 0.7,
        restitution = 0,
        type = "dynamic",
        collisionClass = "Crate",
        hasFixedRotation = true
    },

    ['liftable'] = {
        homeX = 0,
        homeY = 0,
        canHold = true,
        canThrow = true,
        minVxForThrow = 50,
        minVyForThrow = 5,
        throwForce = 1000,
        throwForceMultiplierX = 2,
        throwForceMultiplierY = -5
    },

    ['body'] = {
        width = CRATE_SIZE,
        height = CRATE_SIZE
    }
}

local systems = {
    "heldObjectBehavior",
    "heldObjectWeld",
}

local function Crate(TiledObject)
    local crate = Entity()

    crate:addComponents(components)

    crate.components.liftable.homeX = TiledObject.x
    crate.components.liftable.homeY = TiledObject.y
    crate.components.liftable.canHold = TiledObject.properties.CanHold
    crate.components.liftable.canThrow = TiledObject.properties.CanThrow
    crate.components.hitbox:setObject(crate)

    if TiledObject.properties.CanHold then
        crate.tags.canInteractWith = true
        crate:addSystems(systems)
    else
        crate.tags.canInteractWith = false
    end

    return crate
end

return Crate