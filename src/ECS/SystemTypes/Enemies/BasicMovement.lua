_G.BasicMovement = class{}

function BasicMovement:init(entity)
   self.entity = entity

   self.movementData = entity.components.movementData
   self.stateData = entity.components.stateData
   self.position = entity.components.position
   self.target = entity.components.targetData.target
   self.hitbox = entity.components.hitbox

   self.angle, self.cos = 0, 0
   self.vx, self.vy = 0, 0
end

function BasicMovement:update(dt)
    if self.stateData.state == "MOVE_TO_TARGET" then
        if not self.entity.tags.isBeingKnocked then
            if not self.target then
                self.target = self.entity.components.targetData.target
            end
            self.position.x = self.hitbox:getX()
            self.position.y = self.hitbox:getY()
            self.vx, self.vy = self.hitbox:getLinearVelocity()
            self:moveToTarget(dt)
        end
    end
end

function BasicMovement:moveToTarget(dt)
    self.angle = lume.angle(
        self.target.components.position.x,
        self.target.components.position.y,
        self.position.x,
        self.position.y
    )

    self.cos = math.cos(self.angle)

    self.position.directionX = self.position.x - self.target.components.position.x < 0 and 1 or -1
    self.hitbox:setLinearVelocity(
        -self.cos * self.movementData.currentSpeed * dt,
        self.vy
    )
end