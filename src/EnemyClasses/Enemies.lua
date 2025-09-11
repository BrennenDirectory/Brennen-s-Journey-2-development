local Enemies = {}
local EnemiesAlive = {}
local EnemyClasses = {
    ['Glorp'] = function(...) return Glorp(...) end,
    ['Bat'] = function(...) return Bat(...) end,
    ['Shooter'] = function(...) return Shooter(...) end,
    ['Snapper'] = function(...) return Snapper(...) end
}

local player = require"src.Player.player"
local healthBottlePickups = require"src.Player.status.HealthBottles"

function Enemies.update(dt)
    for i, enemy in pairs(EnemiesAlive) do
        if not enemy.isDead then
            enemy:update(dt)
        end
    end
end

function Enemies.render()
    for i, enemy in pairs(EnemiesAlive) do
        if not enemy.isDead then
            enemy:render()
        end
    end
end

function Enemies.hitEnemy(enemy, damage)
    enemy.health = enemy.health - damage
    if enemy.health <= 0 then
        enemy.isDead = true

        player.leveling.awardXP(enemy.xpRewardAmount)
        healthBottlePickups.spawn(enemy)

        enemy:destroy()
        for id, v in pairs(EnemiesAlive) do
            if v == enemy then
                EnemiesAlive[id] = nil
                break
            end
        end
    end
end

function Enemies.forceKill(enemy)
    for id, enemyData in pairs(EnemiesAlive) do
        if enemy == enemyData then
            enemyData.isDead = true
            enemyData:destroy()
            EnemiesAlive[id] = nil
            break
        end
    end
end

function Enemies.Create(ObjectLayers) -- Creates enemies from the Enemies group layer in ObjectLayers
    if ObjectLayers.Enemies then
        for i, object in ipairs(ObjectLayers.Enemies) do
            local enemy = EnemyClasses[object.name](object)
            EnemiesAlive['e' .. i] = enemy
            enemy = nil
        end
    end
end

function Enemies.Remove()
    for id, v in pairs(EnemiesAlive) do
        if not v.isDead then
            v.isDead = true
            v:destroy()
            EnemiesAlive[id] = nil
        end
    end
end

return Enemies