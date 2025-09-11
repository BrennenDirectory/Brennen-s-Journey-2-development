local DataSaving = require"src.DataSaving.DataSaving"
local player = require"src.Player.player"
local healthBottlePickups = require"src.Player.status.HealthBottles"
local DebugGameMapManip = require"src.Debug.DebugGameMapManip"

return {
    ['i'] = function() _G.Debug.isEnabled = not _G.Debug.isEnabled end,
    ['return'] = function() _G.Debug.textInputEnabled = not _G.Debug.textInputEnabled end,
    ['`'] = function() love.event.quit("restart") end,
    ['o'] = function() love.system.openURL("file://" .. love.filesystem.getSaveDirectory()) end,
    ['p'] = function()
        DataSaving.Save()
        Signal.emit("LoadedPlayerData")
    end,
    ['down'] = function() player.health = player.health - 1 end,
    ['m'] = function() DebugGameMapManip.isEnabled = not DebugGameMapManip.isEnabled end,
    ['h'] = function()  healthBottlePickups.spawn(player) end
}
