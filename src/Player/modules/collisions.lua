local player

local knockback = {
    force = 0,
    forceMultiplier = 2,
    forceRange = {min = 350, max = 500},
    direction = 1,
    time = 0.25,
    timer = Timer.new()
}


local function knockbackPlayer(enemy, otherObjectX)
    knockback.force = math.random(knockback.forceRange.min, knockback.forceRange.max)
    player.isBeingKnocked = true

    if enemy then
        knockback.direction = player.hitbox:getX() - enemy.hitbox:getX() < 0 and -1 or 1
    else
        knockback.direction = player.hitbox:getX() - otherObjectX < 0 and -1 or 1
    end
    
    player.hitbox:applyLinearImpulse((knockback.force * knockback.forceMultiplier) * knockback.direction, -knockback.force)

    knockback.timer:after(knockback.time, function()
        player.isBeingKnocked = false
    end)
end

local function enemyCollisions()
    local collisionData = player.hitbox:getEnterCollisionData("Enemy")
    local enemy = collisionData.collider:getObject()
    if not enemy then
        collisionData = nil
        return
    end
    knockbackPlayer(enemy)
    player.takeDamage(enemy.damageToPlayer)
    collisionData = nil
    enemy = nil
end

local function pickups()
    local collisionData = player.hitbox:getEnterCollisionData("Pickup")
    local pickup = collisionData.collider:getObject()
    pickup:collect()

    collisionData = nil
    pickup = nil
end

local function collisions(dt)
    knockback.timer:update(dt)
    if player.hitbox:enter("Pickup") then
        pickups()
    elseif player.hitbox:enter("Enemy") then
        enemyCollisions()
    elseif player.hitbox:enter("LoadingZone") then
        local data = player.hitbox:getEnterCollisionData("LoadingZone")
        Signal.emit("EnteredLoadingZone", data.collider)
        data = nil
    elseif player.hitbox:enter("HealthBottle") then
        local bottle = player.hitbox:getEnterCollisionData("HealthBottle")
        bottle.collider:getObject().isCollected = true
        bottle = nil
    end
end

return function(playerTab)
    player = playerTab
    return collisions, knockbackPlayer
end