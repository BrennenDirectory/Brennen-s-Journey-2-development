return function(entity)
    local idling = {
        entity = entity,
        hitbox = entity.components.hitbox,
        stateData = entity.components.stateData,
        vx = 0,
        vy = 0
    }

    function idling:update(dt)
        if self.stateData.state == "IDLE" then
            if not self.entity.tags.isBeingKnocked then
                self.vx, self.vy = self.hitbox:getLinearVelocity()
                self:idle()
            end
        end
    end

    function idling:idle()
        self.hitbox:setLinearVelocity(0, self.vy)
    end

    return idling
end