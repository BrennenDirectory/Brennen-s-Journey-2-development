local QUERY_WIDTH = 128
local QUERY_HEIGHT = 64
local HITBOX_SIZE = 24
local QUERY_Y_OFFSET = QUERY_HEIGHT / 2

local knockbackData = {
    minForce = 100,
    maxForce = 200,
    forceMultiplierX = 1,
    forceMultiplierY = 1,
    timer = Timer.new(),
    delayAmount = 0.25
}

local jumpData = {
    jumpPower = 300,
    jumpPowerMultiplier = 1,
    jumps = 1,
    maxJumps = 1,
    groundClasses = {"Ground", "Crate", "Breakable"},
    queryWidth = HITBOX_SIZE,
    queryHeight = 2,
    minDownwardVy = 5
}

local choiceData = {
    canMakeChoices = true,
    timer = true,
    delay = 2,
    choice = "WANDER",
    choices = {
        "WANDER",
        "CHANGE_DIRECTION",
        "IDLE",
        "JUMP"
    },
    onChoiceMade = function(thisEntity, choice)
        local comps = thisEntity.components
        if comps.stateData.state == "MOVE_TO_TARGET" then
            return
        end

        local sys = thisEntity.systems

        if choice == "WANDER" then
            sys.stateMachine:set(choice)
        elseif choice == "CHANGE_DIRECTION" then
            comps.position.directionX = comps.position.directionX * -1
        elseif choice == "IDLE" then
            sys.stateMachine:set(choice)
            sys.idling:idle()
        else
            sys.jumpBehavior:jump()
        end
    end
}

local movementData = {
    currentSpeed = 2500,
    walkSpeed = 2500
}

local collisionData = {
    onEnterClasses = {'Player'},
    onEnterEvent = function(thisEntity, otherEntity)
        otherEntity.systems.hitResponses:takeHit(thisEntity)
    end,
    wallCollisionClasses = {"Wall", "Crate"}
}

local hitResponseData = {
    onHit = function(thisEntity, otherEntity)
        thisEntity.systems.knockbackBehavior:takeKnockback(otherEntity)
    end
}

local targetData = {
    target = nil,
    canQueryForTarget = true,
    onTargetFound = function(thisEntity, otherEntity)
        thisEntity.components.targetData.canQueryForTarget = false
        thisEntity.systems.stateMachine:set("MOVE_TO_TARGET")
    end,

    queryUpdate = function(thisEntity, components)
        components.position.x = components.hitbox:getX() - QUERY_WIDTH / 2
        components.position.y = components.hitbox:getY() - QUERY_Y_OFFSET
        
        components.targetData.queryPosition = {
            x = components.position.x,
            y = components.position.y
        }
    end,

    queryWidth = QUERY_WIDTH,
    queryHeight = QUERY_HEIGHT,
    queryPosition = {x = 0, y = 0},
    collisionClass = {"Player"}
}

local stateData = {
    state = "WANDER",
    states = {
        ['WANDER'] = true,
        ['IDLE'] = true,
        ['MOVE_TO_TARGET'] = true
    }
}

local systems = {
    "hitboxInit",
    "hitboxCollisions",
    "knockbackBehavior",
    "hitResponses",
    "basicMovement",
    "targetQuerying",
    "stateMachine",
    "wandering",
    "idling",
    "choiceMaking",
    "jumpBehavior",
    "surfaceCollisions"
}

local function Glorp(TiledObject)
    local glorp = Entity()

    local components = {
        ['position'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            directionX = math.random(1, 10) % 2 == 0 and 1 or -1
        },
        ['body'] = {
            width = HITBOX_SIZE,
            height = HITBOX_SIZE
        },
        ['hitbox'] = {
            x = TiledObject.x,
            y = TiledObject.y,
            width = HITBOX_SIZE,
            height = HITBOX_SIZE,
            collisionClass = "Enemy",
            type = "dynamic",
            hasFixedRotation = true,
            cornerCutSize = 3,
            friction = 0,
            restituion = 0
        },
        ['knockbackData'] = knockbackData,
        ['jumpData'] = jumpData,
        ['movementData'] = movementData,
        ['collisionData'] = collisionData,
        ['hitResponseData'] = hitResponseData,
        ['targetData'] = targetData,
        ['stateData'] = stateData,
        ['choiceData'] = choiceData
    }

    glorp:addComponents(components)
    glorp:addSystems(systems)

    return glorp
end

return Glorp