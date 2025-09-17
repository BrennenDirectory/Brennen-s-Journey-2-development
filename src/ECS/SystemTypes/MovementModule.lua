return function(entity)
    local movementModule = {}

    function movementModule:init()
        self.entity = entity

        self.position = entity.components.position
        self.inputData = entity.components.inputData
        self.movementData = entity.components.movementData
        self.hitbox = entity.components.hitbox
    end

    function movementModule:update(dt)
        local vx, vy = self.hitbox:getLinearVelocity()

        if self.movementData.isControlledByUser then
            if (not Input:down("left") and not Input:down("right")) or self.entity.tags.isBeingKnocked then
                self.hitbox:setLinearVelocity(vx, vy)
                return
            else
                self.hitbox:setLinearVelocity(self.movementData.currentSpeed * self.inputData.ix * dt, vy)
            end
        else
            if self.entity.tags.isBeingKnocked then
                self.hitbox:setLinearVelocity(vx, vy)
                return
            else
                self.hitbox:setLinearVelocity(self.movementData.currentSpeed * self.position.directionX * dt, vy)
            end
        end
    end

    movementModule:init()

    return movementModule
end