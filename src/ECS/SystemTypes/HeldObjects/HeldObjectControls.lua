_G.HeldObjectControls = class{}

local INTERACT_DELAY = 0.05

function HeldObjectControls:init(entity)
    self.entity = entity
    self.tags = entity.tags

    self.frameDelay = false -- delays the update function from throwing an object on the frame its picked up
    self.objectInteractDelay = Timer.new()
    self.movementData = entity.components.movementData
end

function HeldObjectControls:update(dt)
    self.objectInteractDelay:update(dt)
    if self.tags.isHoldingObject then
        if not self.frameDelay then
            self.frameDelay = true
            return
        elseif Input:pressed("interact") then
            local heldObject = self.tags.heldObject
            heldObject.systems[heldObject.tags.systemForInteracting]:interact(self.entity)
            heldObject = nil

            self.tags.heldObject = nil
            self.tags.isHoldingObject = false
            self.tags.canSprint = true
            self.movementData.currentSpeed = self.movementData.walkSpeed

            self.objectInteractDelay:after(INTERACT_DELAY, function()
                self.tags.canInteract = true
                self.frameDelay = false
            end)
        end
    end
end