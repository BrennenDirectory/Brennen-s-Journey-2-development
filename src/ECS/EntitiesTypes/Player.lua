local HITBOX_SIZE = 32
local components = {
    ['body'] = {
        width = HITBOX_SIZE,
        height = HITBOX_SIZE
    },
    ['hitbox'] = {
        width = HITBOX_SIZE,
        height = HITBOX_SIZE,
        cornerCutSize = 5,
        friction = 0.5,
        hasFixedRotation = true,
        type = "dynamic",
        collisionClass = "Player"
    },
    ['interactQueryData'] = {
        width = HITBOX_SIZE,
        height = HITBOX_SIZE,
        classes = {"Crate"},
        offsetX = HITBOX_SIZE / 2,
        offsetY = -HITBOX_SIZE / 2
    },
    ['position'] = {
        directionX = 1,
        x = 128,
        y = -128
    }
}

local systems = {
    "interactWithObjects",
    "heldObjectControls",
    "hitboxSpatialChecks",
    "movementModule"
}

local function Player()
    local player = Entity()

    player:addComponents(components)
    player:addSystems(systems)

    player.components.hitbox:setX(player.components.position.x)
    player.components.hitbox:setY(player.components.position.y)

    return player
end

return Player