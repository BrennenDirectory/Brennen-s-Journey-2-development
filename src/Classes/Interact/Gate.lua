Gate = class{}

local PATH_TO_SCRIPTS = "src/ScriptedEvents/GateEvents/"
local START_OF_DIRECTORY = 36
local TEXTURE = love.graphics.newImage("src/gfx/interact/gate_bars.png")
TEXTURE:setFilter("nearest", "nearest")

local OFFSET_X = TEXTURE:getWidth() / 2
local OFFSET_Y = TEXTURE:getHeight() / 2

-- @param object: {...}, unlockedByPlayer: boolean | (The Player already unlocked and opened this gate)
function Gate:init(object, unlockedByPlayer)
    self.hitbox = world:newRectangleCollider(object.x, object.y, object.width, object.height)
    self.hitbox:setType("static")
    self.hitbox:setCollisionClass("Gate")
    self.hitbox:setFriction(0)
    self.hitbox:setObject(self)

    self.canOpen = object.properties.CanOpen
    
    if unlockedByPlayer then
        self.isLocked = false
        self.hitbox:setActive(false)
    else
        if object.properties.HasScriptedEvent then
            local scriptPath = string.sub(object.properties.Script, START_OF_DIRECTORY, #object.properties.Script)
            self.Script = PATH_TO_SCRIPTS .. scriptPath
        end
        self.isLocked = object.properties.IsLocked
    end
    
    self.isOpen = object.properties.IsOpen -- can be used by Triggers than manually close this door behind the player
    self.gateID = object.id -- the ID that Triggers can look for to force close/open

    self.x = self.hitbox:getX()
    self.y = self.hitbox:getY()
    self.scaleX = object.width / TEXTURE:getWidth()
    self.scaleY = object.height / TEXTURE:getHeight()
end

function Gate:render() -- TODO: change offset to draw from top middle for open and close animation
    if not self.isOpen then
        love.graphics.draw(TEXTURE, self.x, self.y, nil, self.scaleX, self.scaleY, OFFSET_X, OFFSET_Y)
    end
end

function Gate:interact()
    if self.Script and self.isLocked then
        local meetsRequirements = dofile(self.Script)
        if not meetsRequirements then
            return
        else
            self.isLocked = false
            self.isOpen = true
            self.hitbox:setActive(false)
            Signal.emit("GateUnlocked", self.gateID)
        end
    elseif not self.isOpen then
        self.isOpen = true
        self.hitbox:setActive(false)
    end
end

function Gate:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
end