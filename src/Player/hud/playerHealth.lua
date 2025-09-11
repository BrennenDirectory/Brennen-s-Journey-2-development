local player = require"src.Player.player"
local bottle = _G.HealthBottle.TEXTURE

local bottleBaseSizeX = 80
local bottleBaseSizeY = 128

-- TODO: scale image based on screen size.

local function drawHealth()
    if player.health > 0 then
        for i = 0, player.maxHealth / 2 - 1 do

        local healthValue = player.health - (i * 2)

        if healthValue >= 2 then
            love.graphics.setColor(0, 1, 0, 1)
        elseif healthValue == 1 then
            love.graphics.setColor(1, 0, 0, 1)
        else
            love.graphics.setColor(1, 1, 1, 0)
        end

            love.graphics.draw(bottle, 32 * i, 32, nil, bottleBaseSizeX/bottle:getWidth(), bottleBaseSizeY/bottle:getHeight())
            love.graphics.setColor(1, 1, 1, 1)
        end
    end
end

return drawHealth