local player
local Breakables = require"src.MapLoading.Interact.BreakablePassages"
local Enemies = require"src.EnemyClasses.Enemies"

local collisionClasses = {
    "Breakable",
    "Crate",
    "Enemy",
    "EnemyProjectile"
}

local isSwinging = false
local querySize
local x, y

local reflectedProjectileSpeedMultiplier = 4.5

local function hitEnemy(object)
    local enemy = object:getObject()
    if enemy.knockback then
        enemy:knockback(player.lastIx)
    end
    Enemies.hitEnemy(enemy, player.weapon.damage)
    enemy = nil
end

local function reflectProjectile(object)
    if object.canBeReflected and not object.hasReflected then
        object.hasReflected = true
        object.direction = player.lastIx
        
        local vx, vy = object:getLinearVelocity()
        object:applyLinearImpulse(-vx * reflectedProjectileSpeedMultiplier, vy)
    end
end

local function weaponControls()
    if isSwinging or not player.weapon then
        return
    end

    querySize = player.weapon.querySize
    x, y = player.hitbox:getX(), player.hitbox:getY()

    local offset = player.lastIx == -1 and -querySize/2 or querySize/2
    local query = world:queryCircleArea(x + offset, y, querySize, collisionClasses)
    if #query < 1 then
        query = nil
        return
    end

    for i, object in ipairs(query) do
        if object.collision_class == "EnemyProjectile" then
            reflectProjectile(object)
        elseif object.collision_class == "Enemy" then
            hitEnemy(object)
        elseif object.collision_class == "Breakable" then
            if object.damageSource == "Any" or object.damageSource == "Weapon" then
                Breakables.damageObject(object, player.weapon.damageToBreakables)
            end
        elseif object.collision_class == "Crate" then
            local crate = object:getObject()
            crate:damage()
            crate = nil
        end
        break
    end
end

return function(playerTab)
    player = playerTab
    return weaponControls
end