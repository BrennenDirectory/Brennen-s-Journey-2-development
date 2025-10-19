if true then
    return -- MODULE HAS BEEN REWRITTEN!
end

local Interact = {}

local LoadingZones = require"src.MapLoading.Interact.LoadingZones"
local Triggers = require"src.MapLoading.Interact.Triggers"
local RespawnPoints = require"src.MapLoading.Interact.RespawnPoints"
local Pickups = require "src.MapLoading.Interact.Pickups"
local Breakables = require"src.MapLoading.Interact.BreakablePassages"
local Chests = require"src.MapLoading.Interact.Chests"

local Objects = {}
local GatesUnlockedByPlayer = _G.PlayerSaveData.GateIDs

local Classes = {
    ['Trigger'] = function(...) Triggers.new(...) end,
    ['LoadingZone'] = function(...) LoadingZones.new(...) end,
    ['RespawnPoint'] = function(...) RespawnPoints.new(...) end,
    ['Gate'] = function(object)
        if object.properties.IsLocked then
            local unlockedByPlayer = _G.PlayerSaveData.GateIDs[object.id]
            if unlockedByPlayer then
                GatesUnlockedByPlayer[object.id] = true
            end
            table.insert(Objects, Gate(object, unlockedByPlayer))
        else
            table.insert(Objects, Gate(object))
        end
    end,
    ['Pickup'] = function(...) Pickups.new(...) end,
    ['Breakable'] = function(...) Breakables.new(...) end,
    ['Chest'] = function(...) Chests.new(...) end
}

function Interact.Create(ObjectLayers)
    if ObjectLayers.Interact then
        for i, object in ipairs(ObjectLayers.Interact) do
            Classes[object.name](object)
        end
    end
end

function Interact.update(dt)
    Triggers.update(dt)
    RespawnPoints.update(dt)
    Pickups.update(dt)
end

function Interact.Remove()
    Triggers.Remove()
    LoadingZones.Destroy()
    RespawnPoints.Destroy()
    Pickups.Remove()
    Breakables.Destroy()
    Chests.Destroy()
    for i, v in ipairs(Objects) do
        v:destroy()
        Objects[i] = nil
    end
end

function Interact.draw()
    Chests.render()
    for i, v in ipairs(Objects) do
        if v.render then
            v:render()
        end
    end
end

Signal.register("GateUnlocked", function(gateID)
    GatesUnlockedByPlayer[gateID] = true
end)

return Interact