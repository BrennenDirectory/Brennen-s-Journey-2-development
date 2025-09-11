local hud = {}

local drawHealth = require"src.Player.hud.playerHealth"
local levelingHud = require"src.Player.hud.playerLeveling"

function hud.update(dt)
    levelingHud.update(dt)
end

function hud.draw()
    drawHealth()
    levelingHud.draw()
end

return hud