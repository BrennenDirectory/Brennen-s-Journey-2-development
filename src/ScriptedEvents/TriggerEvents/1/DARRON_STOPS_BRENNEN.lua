-- local Pickups = require"src.MapLoading.Interact.Pickups"

-- local allenWrenchPickup = {
--     x = 1408,
--     y = 576,
--     width = 32,
--     height = 32,
--     properties = {
--         CollectibleID = "ALLEN_WRENCH",
--         IsFromTiled = false,
--         HasScriptedEvent = true,
--         Script = "1/PLAYER_GETS_ALLEN_WRENCH.lua"
--     }
-- }

-- Pickups.new(allenWrenchPickup)

-- allenWrenchPickup, Pickups = nil, nil

return function(caller, otherEntity)
    print("hello")
end