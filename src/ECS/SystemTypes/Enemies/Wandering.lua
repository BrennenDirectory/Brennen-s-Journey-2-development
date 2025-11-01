_G.Wandering = class{}

function Wandering:init(entity)
    self.entity = entity

    self.hitbox = entity.components.hitbox
    self.stateData = entity.components.stateData
    self.movementData = entity.components.movementData
    self.position = entity.components.position

    self.vx = 0
    self.vy = 0
end

function Wandering:update(dt)
    if self.stateData.state == "WANDER" then
        if not self.entity.tags.isBeingKnocked then
            self:wander(dt)
        end
    end
end

function Wandering:wander(dt)
    self.vx, self.vy = self.hitbox:getLinearVelocity()

    self.hitbox:setLinearVelocity(
        self.position.directionX * (self.movementData.currentSpeed * dt),
        self.vy
    )
end