local abilityHandler = {}

local player = require"src.Player.player"

function abilityHandler.update(dt)
    if player.ability then
        player.ability:update(dt)
    end
end

function abilityHandler.draw()
    
end

Signal.register("EnteredLoadingZone", function()
    if player.ability and player.ability.onPlayerStateChange then
        player.ability:onPlayerStateChange()
    end
end)

return abilityHandler