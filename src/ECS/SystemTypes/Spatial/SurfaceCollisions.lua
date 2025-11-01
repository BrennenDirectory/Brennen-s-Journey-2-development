return function(entity)
    local this = {
        entity = entity,
        position = entity.components.position,
        hitbox = entity.components.hitbox,
        collisionData = entity.components.collisionData,
        stateData = entity.components.stateData
    }

    function this:update(dt)
        if not self.entity.isBeingKnocked and self.stateData.state ~= "MOVE_TO_TARGET" then
            for i, class in ipairs(self.collisionData.wallCollisionClasses) do
                if self.hitbox:enter(class) then
                    self.position.directionX = self.position.directionX * -1
                    break
                end
            end
        end
    end

    return this
end