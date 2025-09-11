local PlayerManip = {}

local player = require"src.Player.player"
local vx, vy

local FLY_FORCE = 5000
local maxVelocity = 1000

local function flyControls()
    vx, vy = player.hitbox:getLinearVelocity()
    if math.abs(vx) > maxVelocity or math.abs(vy) > maxVelocity then
        return
    end

    if love.keyboard.isDown("up") then
        player.hitbox:applyForce(vx, -FLY_FORCE)
    elseif love.keyboard.isDown("down") then
        player.hitbox:applyForce(vx, FLY_FORCE)
    end

    if love.keyboard.isDown("right") then
        player.hitbox:applyForce(FLY_FORCE, vy)
    elseif love.keyboard.isDown("left") then
        player.hitbox:applyForce(-FLY_FORCE, vy)
    end
end

function PlayerManip.update(dt)
    flyControls()
end

return PlayerManip