Trigger = class{}

local Triggers = require"src.MapLoading.Interact.Triggers"

local PATH_TO_SCRIPTS = "src/ScriptedEvents/TriggerEvents/"
local START_OF_DIRECTORY = 39

function Trigger:init(object)
    self.hitbox = world:newLineCollider(object.x, object.y, object.x, object.y + object.height)
    self.hitbox:setType("static")
    self.hitbox:setCollisionClass("Trigger")

    self.hasTriggered = false

    local scriptPath = object.properties.Script

    if object.properties.IsFromTiled then
        scriptPath = string.sub(scriptPath, START_OF_DIRECTORY, #scriptPath)

        -- Triggers made via hard-coding do not need an ID
        self.triggerID = object.id
    end

    self.script = PATH_TO_SCRIPTS .. scriptPath
end

function Trigger:update(dt)
    if self.hitbox:enter("Player") and not self.hasTriggered then
        self:activate()
    end
end

function Trigger:activate()
    self.hasTriggered = true
    dofile(self.script)

    if self.triggerID then
        Triggers.addToTriggered(self.triggerID)
    end
end