local Pickups = {}
local CurrentPickups = {}

-- Prevents important items like weapons from being collected multiple times
function Pickups.addToCollected(CollectibleID)
    _G.PlayerSaveData.CollectibleIDs[CollectibleID] = true
end

-- Adds Pickups from Scripted Events into the table
function Pickups.addFromScript(pickup)
    table.insert(CurrentPickups, pickup)
end

function Pickups.update(dt)
    for i, v in ipairs(CurrentPickups) do
        if not v.isCollected and v then
            v:update(dt)
        else
            CurrentPickups[i] = nil
        end
    end
end

function Pickups.new(object)
    if not _G.PlayerSaveData.CollectibleIDs[object.properties.CollectibleID] then
        local pickup = Pickup(object)
        table.insert(CurrentPickups, pickup)
        pickup = nil
    end
end

function Pickups.Remove()
    for i, pickup in ipairs(CurrentPickups) do
        pickup:destroy()
        CurrentPickups[i] = nil
    end
end

return Pickups