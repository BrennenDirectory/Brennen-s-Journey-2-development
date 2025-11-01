return function(entity)
    local sprintModule = {}

    function sprintModule:init()
        self.tags = entity.tags
        self.tags.canSprint = true

        self.movementData = entity.components.movementData
    end

    function sprintModule:update(dt)
        if Input:down("sprint") and self.tags.canSprint then
            if self.movementData.currentSpeed ~= self.movementData.sprintSpeed then
                self.movementData.currentSpeed = self.movementData.sprintSpeed
            end
        else
            if self.tags.isHoldingObject then
                self.movementData.currentSpeed = self.movementData.heldObjectWalkSpeed
            else
                self.movementData.currentSpeed = self.movementData.walkSpeed
            end
        end
    end

    sprintModule:init()

    return sprintModule
end