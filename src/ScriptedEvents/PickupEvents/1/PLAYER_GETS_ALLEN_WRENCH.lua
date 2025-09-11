local player = require"src.Player.player"
local allenWrench = require"src.Player.weapons.allenWrench"

player.weapons[allenWrench.id] = allenWrench
player.weapon = player.weapons[allenWrench.id]

player, allenWrench = nil, nil