local basicSpell = {
    manaCost = 1,
    id = "BASIC_SPELL"
}
local Breakables = require"src.MapLoading.Interact.BreakablePassages"
local Enemies = require"src.EnemyClasses.Enemies"

local collisionClasses = {
    "Breakable",
    "Crate",
    "Enemy",
    "Gate",
    "Ground",
    'Wall',
}

local hitbox
local force = 300
local damageToBreakables = 1
local damage = 2
local direction

local SIZE = 16
local MAX_SPELL_RANGE = 1000

local function createHitbox(player)
    local x, y = player.hitbox:getX(), player.hitbox:getY()
    hitbox = world:newRectangleCollider(x - SIZE/2, y - SIZE/2, SIZE, SIZE)
    hitbox:setType("dynamic")
    hitbox:setFixedRotation(true)
    hitbox:setCollisionClass("BasicSpell")
    hitbox:setGravityScale(0)
    hitbox:setBullet(true)
    hitbox:applyLinearImpulse(player.lastIx * force, 0)
    direction = player.lastIx
end

function basicSpell.cast(player)
    if hitbox then --(insert not enough mana check)
        return
    end

    createHitbox(player)
end

local function hitEnemy(object)
    local enemy = object.collider:getObject()
    Enemies.hitEnemy(enemy, damage)
    if enemy.knockback then
        enemy:knockback(direction)
    end
    enemy = nil
end

local function collisions()
    for i, v in ipairs(collisionClasses) do
        if hitbox:enter(v) then
            local otherObject = hitbox:getEnterCollisionData(v)
            if otherObject then
                local collider = otherObject.collider
                if collider.collision_class == "Enemy" then
                    hitEnemy(otherObject)
                elseif collider.collision_class == "Breakable" then
                    if collider.damageSource == "Any" or collider.damageSource == "Spell" then
                        --otherObject.collider IS EQUAL TO AN ELEMENT IN THE BREAKABLES TABLE
                        Breakables.damageObject(collider, damageToBreakables)
                    end
                end
                collider = nil
            end
            
            hitbox:destroy()
            hitbox = nil
            break
        end
    end
end

function basicSpell.update(player)
    if hitbox then
        if lume.distance(hitbox:getX(), hitbox:getY(), player.hitbox:getX(), player.hitbox:getY()) >= MAX_SPELL_RANGE then
            hitbox:destroy()
            hitbox = nil
            return
        end
        collisions()
    end
end

return basicSpell