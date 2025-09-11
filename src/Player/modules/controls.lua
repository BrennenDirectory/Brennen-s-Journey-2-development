local player

local ix = 0
local vx, vy
local minDownwardVy = 5
local minVelocityForCrateThrow = 50

local maxJumps = 2
local jumps = maxJumps
local realJumpPower = 0
local jumpPowerMultiplier = 1.5

local heldCrate
local crateDropSpaceCheckNegX = 16

local size = 32 -- size of the player's hitbox

local function movement(dt) -- needs work...
    vx, vy = player.hitbox:getLinearVelocity()

    if (not Input:down("left") and not Input:down("right")) or player.isBeingKnocked then
        player.hitbox:setLinearVelocity(vx, vy)
        return
    end

    player.hitbox:setLinearVelocity(player.speed * ix * dt, vy)
end

local function jumpControls()
    if player.isBeingKnocked then
        return
    end

    if jumps < maxJumps then
        local x, y = player.hitbox:getX(), player.hitbox:getY()
        local query = world:queryRectangleArea(x - size/2, y + size/2, size, 2, {"Ground", "Crate"})
        if #query > 0 then
            jumps = maxJumps
            query = nil
            x, y = nil, nil
        else
            query = nil
        end
    end

    if Input:pressed("jump") and jumps > 0 then
        -- To prevent the jump from being effected by gravity and downward velocity
        realJumpPower = vy > minDownwardVy and player.jumpPower * jumpPowerMultiplier or player.jumpPower
        player.hitbox:applyLinearImpulse(0, -realJumpPower) -- applies impulse at center of hitbox (by default)
        jumps = jumps - 1
    end
end

local function isOnMovingPlatform()
    local x, y = player.hitbox:getX(), player.hitbox:getY()

    local check = world:queryRectangleArea(x - size/2, y + size/2, size, 2, {"MovingPlatform"})
    if #check > 0 then
        x, y, check = nil, nil, nil
        return true
    end

    x, y, check = nil, nil, nil
    return false
end

local function crateSpaceCheck()
    local x, y = player.hitbox:getX(), player.hitbox:getY()
    local offset = player.lastIx == -1 and -size - crateDropSpaceCheckNegX or size/2
    if #world:queryRectangleArea(x + offset, y - size/2, size, size, {"Wall"}) < 1 then
        return true
    else
        return false
    end
end

local function heldCrateControls()
    if isOnMovingPlatform() and ix == 0 then
        heldCrate:drop(player)
    elseif math.abs(vx) > minVelocityForCrateThrow or math.abs(vy) > minVelocityForCrateThrow then
        heldCrate:throw(player)
    else
        if crateSpaceCheck() then
            heldCrate:drop(player)
        else
            heldCrate:throw(player)
        end
    end

    heldCrate = nil
    player.isHoldingCrate = false
    player.speed = player.walkSpeed
end

local function interactControls()
    if Input:pressed("interact") then
        
        if player.isHoldingCrate then
            heldCrateControls()
            return
        end

        local x, y = player.hitbox:getX(), player.hitbox:getY()
        local offset = player.lastIx == -1 and -size - size/2 or size/2
        local query = world:queryRectangleArea(x + offset, y - size/2, size, size, {"Crate", "Gate", "InteriorZone", "Chest"})
        if #query < 1 then
            query, x, y = nil, nil, nil
            return
        end

        for i, v in ipairs(query) do
            -- v is a physics object
            if v.collision_class == "Crate" then
                if v:getObject().canHold then
                    player.isHoldingCrate = true
                    player.speed = player.heldCrateSpeed
                    heldCrate = v:getObject()
                    heldCrate:pickup(player)
                end
            elseif v.collision_class == "Gate" then
                local gate = v:getObject()
                if gate.canOpen then
                    gate:interact()
                end
            elseif v.collision_class == "Chest" then
                local chest = v:getObject()
                if not chest.isOpen then
                    chest:interact()
                end
            elseif v.collision_class == "InteriorZone" then
                Signal.emit("EnteredLoadingZone", v)
            end
            break
        end
    end
end

local function sprintControls()
    if not player.isHoldingCrate then
        if Input:down("sprint") then
            player.speed = player.sprintSpeed
        else
            player.speed = player.walkSpeed
        end
    end
end

local function controls()
    if Input:down("left") then
        ix = -1
        player.lastIx = -1
    elseif Input:down("right") then
        ix = 1
        player.lastIx = 1
    else
        ix = 0
    end

    jumpControls()
    interactControls()
    sprintControls()
end

local function reset(fromRespawn)
    if heldCrate and fromRespawn then
        heldCrate:reset()
    end
    heldCrate = nil
    player.isHoldingCrate = false
    jumps = maxJumps
end

Signal.register("EnteredLoadingZone", function() reset(false) end)
Signal.register("PlayerRespawned", function() reset(true) end)

return function(playerTab, method)
    if method == 0 then
        player = playerTab
        player.isOnMovingPlatform = isOnMovingPlatform
        return controls
    else
        return movement
    end
end