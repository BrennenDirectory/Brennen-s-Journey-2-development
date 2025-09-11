local Chests = {}
local ChestsInMap = {}

function Chests.addToOpened(id)
    _G.PlayerSaveData.ChestIDs[id] = true
end

function Chests.new(object)
    local isChestOpened = false--_G.PlayerSaveData.ChestIDs[object.id]
    local chest = Chest(object, isChestOpened)

    table.insert(ChestsInMap, chest)

    chest = nil
    --isChestOpened = nil
end

function Chests.render()
    for i, chest in ipairs(ChestsInMap) do
        chest:render()
    end
end

function Chests.Destroy()
    if #ChestsInMap < 1 then
        return
    end

    for chest = 1, #ChestsInMap do
        ChestsInMap[chest]:destroy()
        ChestsInMap[chest] = nil
    end
end

return Chests