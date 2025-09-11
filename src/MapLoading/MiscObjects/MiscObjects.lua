-- Handles logic on objects that dont pertain to categories such as a player health bottle or a pot in the world.
local MiscObjects = {}

local playerHealthBottles = require"src.Player.status.HealthBottles"

function MiscObjects.update(dt)
    playerHealthBottles.update(dt)
end

function MiscObjects.draw()
    playerHealthBottles.draw()
end

function MiscObjects.remove()
    playerHealthBottles.remove()
end

return MiscObjects