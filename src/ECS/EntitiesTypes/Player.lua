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
    },
    ['inputData'] = "",
    ['movementData'] = {
        currentSpeed = 10000,
        walkSpeed = 10000,
        sprintSpeed = 18000,
        heldObjectWalkSpeed = 8000
    },
    ['jumpData'] = {
        jumpPower = 800,
        jumpPowerMultiplier = 1.5,
        jumps = 2,
        maxJumps = 2,
        isControlledByUser = true,
        groundClasses = {"Ground", "Crate"}
    },
    ['knockbackData'] = {
        minForce = 1,
        maxForce = 2,
        forceMultiplierX = 1,
        forceMultiplierY = 1,
        delayAmount = 0.1
    },
    ['healthData'] = {
        maxHealth = 6,
        canRespawn = true
    },
    ['inventory'] = {},
    ['camera'] = {
        target = {
            x = 0,
            y = 0
        },

        updateTarget = function(dt, entity)
            entity.components.camera.target.x = entity.components.hitbox:getX()
            entity.components.camera.target.y = entity.components.hitbox:getY()
        end,
        
        zoomLevel = 2
    }
}

local systems = {
    "interactWithObjects",
    "heldObjectControls",
    "hitboxSpatialChecks",
    "jumpMovementModule",
    "inputModule",
    "movementModule",
    "sprintModule",
    "knockbackBehavior",
    "healthBehavior",
    "weaponControls",
    "entitySerialization",
    "cameraBehavior"
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