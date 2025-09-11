local gravelBomb = {
    id = "GRAVEL_BOMB"
}

local player = require"src.Player.player"
local Enemies = require"src.EnemyClasses.Enemies"
local Breakables = require"src.MapLoading.Interact.BreakablePassages"

local damageToBreakables = 1
local damageToEnemies = 5
local dmageToPlayer = 1

local cooldownTime = 5
local cooldownTimer = Timer.new()

local detonationTime = 4
local detonationTimer = Timer.new()

local px, py
local playerHitboxSize = 32

local size = 24
local mass = 100

local blastRadius = 64
local throwForce = 200
local throwForceMultiplierX = 2 -- TODO: tweak
local throwForceMultiplierY = 2 -- TODO: tweak
local minVxForBombThrow = 5

local dropBombOffsetMultiplierX = 1.25
local dropBombSpaceCheckOffsetX = 8
local bombHoldOffsetMultiplierY = 1.75
local bombHoldVerticalOffset = 16

local weld
local hitbox

local isHoldingBomb = false
local canUse = true
local forcefullyDestroyed = false

local groundQuerySize = 2

local function isTouchingGround()
    px, py = player.hitbox:getX(), player.hitbox:getY()
    if #world:queryRectangleArea(px - playerHitboxSize/2, py + playerHitboxSize/2, playerHitboxSize, groundQuerySize, {"Ground", "Crate", "MovingPlatform"}) > 0 then
        return true
    end

    return false
end

local function bombDropSpaceCheck()
    local offset = player.lastIx == -1 and -size - playerHitboxSize / 2 or size - dropBombSpaceCheckOffsetX
    px, py = player.hitbox:getX(), player.hitbox:getY()

    if #world:queryRectangleArea(px + offset, py - size / 2, size, size, {"Wall"}) > 0 then
        return false
    else
        return true
    end
end

local function bombHoldVerticalSpaceCheck()
    px, py = player.getPosition()
    if #world:queryRectangleArea(px - size/2, py - size - bombHoldVerticalOffset, size, size, {"Ground"}) > 0 then
        return false
    else
        return true
    end
end

function gravelBomb:update(dt)
    cooldownTimer:update(dt)
    detonationTimer:update(dt)
    if isHoldingBomb then
        if Input:pressed("useAbility") then
            isHoldingBomb = false
            local vx, vy = player.hitbox:getLinearVelocity()
            if not Input:down("right") and not Input:down("left") and player.isOnMovingPlatform() then
               self:drop()
            elseif math.abs(vx) < minVxForBombThrow and isTouchingGround() then
                self:drop()
            elseif math.abs(vx) > minVxForBombThrow or math.abs(vy) > minVxForBombThrow then
                self:throw()
            end
        end
    elseif Input:pressed("useAbility") and canUse then
        self:use()
    end
end

function gravelBomb:draw()
    
end

function gravelBomb:use()
    if not bombHoldVerticalSpaceCheck() then
        print("not enough space to use ability")
        return
    end

    canUse = false
    isHoldingBomb = true
    self:createHitbox()
    detonationTimer:after(detonationTime, function()
        if not forcefullyDestroyed then
            self:detonate()
        end
    end)
end

function gravelBomb:createHitbox()
    px, py = player.getPosition()
    hitbox = world:newRectangleCollider(px - size/2, py - (size * bombHoldOffsetMultiplierY), size, size)
    hitbox:setCollisionClass("Bomb")
    hitbox:setType("dynamic")
    hitbox:setMass(0)
    hitbox:setFriction(1)
    hitbox:setFixedRotation(true)

    weld = world:addJoint("WeldJoint", player.hitbox, hitbox, px, py, false)
end

function gravelBomb:drop()
    if not bombDropSpaceCheck() then
        self:throw()
        return
    end

    hitbox:setMass(mass)
    
    weld:destroy()
    weld = nil

    px, py = player.getPosition()
    local offset = player.lastIx == 1 and size * dropBombOffsetMultiplierX or -size * dropBombOffsetMultiplierX

    hitbox:setX(px + offset)
    hitbox:setY(py)
end

function gravelBomb:throw()
    weld:destroy()
    weld = nil

    hitbox:applyLinearImpulse(player.lastIx * (throwForce * throwForceMultiplierX), -(throwForce * throwForceMultiplierY))
    hitbox:setMass(mass)
end

function gravelBomb:detonate()
    if weld then
        weld:destroy()
        weld = nil
        isHoldingBomb = false
    end

    local query = world:queryCircleArea(hitbox:getX(), hitbox:getY(), blastRadius, {"Player", "Enemy", "Breakable"})
    for i, object in ipairs(query) do
        if object.collision_class == "Player" then
            player.takeDamage(dmageToPlayer)
            player.knockback(nil, hitbox:getX())
        elseif object.collision_class == "Enemy" then
            local enemy = object:getObject()
            if enemy.knockback then
                local direction = hitbox:getX() - enemy.hitbox:getX() < 0 and -1 or 1
                enemy:knockback(direction)
            end
            Enemies.hitEnemy(enemy, damageToEnemies)
            enemy = nil
        elseif object.collision_class == "Breakable" then
            if object.damageSource == "GravelBomb" then
                Breakables.damageObject(object, damageToBreakables)
            end
        end
    end

    self:destroy()

    cooldownTimer:after(cooldownTime, function()
        if not forcefullyDestroyed then
            canUse = true
        end
    end)
end

function gravelBomb:destroy()
    hitbox:destroy()
    hitbox = nil
end

function gravelBomb:onPlayerStateChange()
    if hitbox or isHoldingBomb then
        forcefullyDestroyed = true
        canUse = false
        isHoldingBomb = false

        if weld then
            weld:destroy()
            weld = nil
        end

        gravelBomb:destroy()

        cooldownTimer:after(cooldownTime, function()
            canUse = true
            forcefullyDestroyed = false
        end)
    end
end

return gravelBomb