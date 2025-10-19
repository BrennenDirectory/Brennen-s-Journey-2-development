if true then
    return -- MODULE HAS BEEN REWRITTEN!
end

local Triggers = {}
local AvailableTriggers = {}
--local AlreadyTriggered = _G.PlayerSaveData.TriggerIDs Apprently you cant index a table thats being referenced, i love LUA!!!! :(

function Triggers.addToTriggered(TriggerID)
   _G.PlayerSaveData.TriggerIDs[TriggerID] = true
end

function Triggers.update(dt)
    for i, trigger in ipairs(AvailableTriggers) do
        if not trigger.hasTriggered then
            trigger:update(dt)
        else
            trigger.hitbox:destroy()
            AvailableTriggers[i] = nil
        end
    end
end

function Triggers.new(obj)
    if not obj.id or not _G.PlayerSaveData.TriggerIDs[obj.id] then
        local trigger = Trigger(obj)
        table.insert(AvailableTriggers, trigger)
        trigger = nil
    end
end

function Triggers.Remove()
    for i, trigger in ipairs(AvailableTriggers) do
        trigger.hitbox:destroy()
        AvailableTriggers[i] = nil
    end
end

return Triggers