Pickup = class{} -- Pickups can be either a weapon, a key?, currency

local Pickups = require"src.MapLoading.Interact.Pickups"
local PATH_TO_SCRIPTS = "src/ScriptedEvents/PickupEvents/"
local START_OF_DIRECTORY = 38
--[[
    Pickup Types:
    Weapon
    Spell
    

]]

function Pickup:init(object)
    self.hitbox = world:newRectangleCollider(object.x, object.y, object.width, object.height)
    self.hitbox:setType("dynamic")
    self.hitbox:setCollisionClass("Pickup")
    self.hitbox:setObject(self)

    self.isCollected = false

    if object.properties.HasScriptedEvent then
        local scriptPath = object.properties.Script
        
        if object.properties.IsFromTiled then
            scriptPath = string.sub(scriptPath, START_OF_DIRECTORY, #scriptPath)
        end

        self.script = PATH_TO_SCRIPTS .. scriptPath
        self.collectibleID = object.properties.CollectibleID
        
        scriptPath = nil
    end
end

function Pickup:update(dt)
    
end

function Pickup:render()
    
end

function Pickup:collect()
    self.isCollected = true
    self:destroy()
    dofile(self.script)
    Pickups.addToCollected(self.collectibleID)
end

function Pickup:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
end