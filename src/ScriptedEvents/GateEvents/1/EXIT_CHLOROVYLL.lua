local player = require"src.Player.player"
if player.spells.basicSpell then
    player = nil
    return true
else
    player = nil
    return false
end