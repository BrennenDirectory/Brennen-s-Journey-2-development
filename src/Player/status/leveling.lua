local leveling = {}
local player

local BASE_XP = 100
local LEVEL_UP_XP_MULTIPLIER = 2

function leveling.awardXP(amount)
    Signal.emit("PlayerGainedXP", amount)
    player.xp = player.xp + amount
    if player.xp >= player.xpToLevel then
        local xpLeftOver = player.xp - player.xpToLevel
        player.xpToLevel = (BASE_XP * player.level) * LEVEL_UP_XP_MULTIPLIER
        player.xp = xpLeftOver
        player.level = player.level + 1
    end
end

return function(playerTable)
    player = playerTable
    return leveling
end