local HealthBottles = {}

local player = require"src.Player.player"

local bottlesInMap = {}

function HealthBottles.spawn(object) -- object: Class that has a hitbox
    local shouldSpawnBottles = math.random(1, 6) == 3
    if shouldSpawnBottles then
        local bottlesToSpawn = math.random(1, 2)
        local objectX = object.hitbox:getX()
        local objectY = object.hitbox:getY()

        for i = 1, bottlesToSpawn do
            table.insert(bottlesInMap, HealthBottle(objectX, objectY))
        end
    end
end

function HealthBottles.update(dt)
    if #bottlesInMap > 0 then
        for i, v in ipairs(bottlesInMap) do
            if v.isCollected then
                player.health = player.health + 1
                v:destroy()
                bottlesInMap[i] = nil
            elseif v.hasDespawned then
                v:destroy()
                bottlesInMap[i] = nil
            else
                v:update(dt)
            end
        end
    end
end

function HealthBottles.draw()
    if #bottlesInMap > 0 then
        for i, v in ipairs(bottlesInMap) do
            if not v.isCollected then
                v:render()
            end
        end
    end
end

function HealthBottles.remove()
    if #bottlesInMap > 0 then
        for i, v in ipairs(bottlesInMap) do
            v.hasDespawned = true
        end
    end
end

return HealthBottles