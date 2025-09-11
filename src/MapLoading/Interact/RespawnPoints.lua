local RespawnPoints = {}
local Points = {} -- although they are more like line colliders than points

local player = require"src.Player.player"
local playerSize = 64

function RespawnPoints.update(dt)
    for i, hitbox in ipairs(Points) do
        if hitbox:enter("Player") then
            player.respawnPoint = {
                x = hitbox.coordX,
                y = hitbox.coordY,
                tiledID = hitbox.tiledID
            }
            break
        end
    end
end

function RespawnPoints.new(obj)
    local hitbox = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
    hitbox:setType("static")
    hitbox:setCollisionClass("RespawnPoint")

    hitbox.coordX = obj.x + obj.width / 2
    hitbox.coordY = obj.y + obj.height - playerSize/2
    hitbox.tiledID = obj.id

    table.insert(Points, hitbox)
    hitbox = nil
end

function RespawnPoints.Destroy()
    for i, hitbox in ipairs(Points) do
        hitbox:destroy()
        Points[i] = nil
    end
end

return RespawnPoints