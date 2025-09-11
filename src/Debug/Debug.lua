local Debug = {
    isEnabled = true,
    textInputEnabled = false
}

local DebugKeypresses = require"src.Debug.DebugKeypresses"
local DebugGameMapManip = require"src.Debug.DebugGameMapManip"
local DebugPlayerManip = require"src.Debug.DebugPlayerManip"
local player = require"src.Player.player"

local mouseX, mouseY
local hints = [[
Press ~ to restart the application
Press ENTER to toggle text input
Press L to load a map from text input
Press K to clear text input
Press O to open save file location
Press P to manually save
]]

function Debug.update(dt)
    if Debug.isEnabled then
        DebugPlayerManip.update(dt)
    end
end

function Debug.draw()
    if Debug.isEnabled then
        love.graphics.setColor(1, 1, 0, 1)
        love.graphics.setNewFont(16)
        love.graphics.print(hints)
        love.graphics.printf("FPS: " .. love.timer.getFPS(), 0, 0, 1280, "center")
        love.graphics.setColor(1, 1, 1, 1)
        if DebugGameMapManip.isEnabled then
            DebugGameMapManip.drawUI()
        end
    end
end

function Debug.drawInsideCamera()
    if Debug.isEnabled then
        mouseX, mouseY = player.camera:mousePosition()
        love.graphics.print('(' .. math.floor(mouseX) .. ", " .. math.floor(mouseY) .. ')', mouseX - 32, mouseY - 20)
    end
end

function Debug.keypressed(key, scancode, isrepeat)
    if not Debug.isEnabled and key ~= "i" or not DebugKeypresses[key] then
        return
    end

    DebugKeypresses[key]()
end

function Debug.mousepressed(x, y, button)
    if Debug.isEnabled then
        if DebugGameMapManip.isEnabled and button == 1 then
            DebugGameMapManip.mousepressed(x, y, button)
        end
    end
end

function Debug.textinput(t)
    if not Debug.textInputEnabled or not Debug.textInputEnabled then
        return
    end
end

return Debug

