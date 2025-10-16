_G.HeldObjectBehavior = class{}

-- Handles how the entity is picked up, dropped, or thrown
local VERTICAL_SPACE_OFFSET = 4
local OBJECT_DROP_OFFSET_X = 4

function HeldObjectBehavior:init(entity)
    self.entity = entity
    self.entity.tags.isBeingHeld = false
    self.entity.tags.systemForInteracting = "heldObjectBehavior"

    self.components = entity.components
    self.body = entity.components.body

    self.hitbox = entity.components.hitbox
    self.hitbox:setX(entity.components.liftable.homeX)
    self.hitbox:setY(entity.components.liftable.homeY)

    self.startingMass = self.hitbox:getMass()
end

function HeldObjectBehavior:interact(otherEntity)
    if otherEntity.tags.isHoldingObject then
        self.hitbox:setMass(self.startingMass)
        if self.components.liftable.canThrow then
            if otherEntity.systems.hitboxSpatialChecks:isOnMovingPlatform() then
                self:drop(otherEntity)
            elseif self:otherEntityExceedsVelocity(otherEntity) then
                self:throw(otherEntity)
            elseif self:hasEnoughSpace(otherEntity, 'x') then
                self:drop(otherEntity)
            end
        elseif self:hasEnoughSpace(otherEntity, 'x') then
            self:drop(otherEntity)
        end
    else
        if self:hasEnoughSpace(otherEntity, 'y') then
            otherEntity.tags.isHoldingObject = true
            otherEntity.tags.canSprint = false
            otherEntity.components.movementData.currentSpeed = otherEntity.components.movementData.heldObjectWalkSpeed
            self:pickup(otherEntity)
        end
    end
end

function HeldObjectBehavior:hasEnoughSpace(otherEntity, axis)
    local otherComponents = otherEntity.components
    local otherX, otherY = otherComponents.hitbox:getX(), otherComponents.hitbox:getY()
    local offsetX, offsetY
    if axis == 'y' then
        offsetX = self.components.body.width / 2
        offsetY = otherComponents.body.height / 2 + self.components.body.height
        if #world:queryRectangleArea(otherX - offsetX, otherY - offsetY - VERTICAL_SPACE_OFFSET, self.body.width, self.body.height + VERTICAL_SPACE_OFFSET, {"Ground"}) > 0 then
            return false
        else
            return true
        end
    elseif axis == 'x' then
        local direction = otherComponents.position.directionX
        if direction == 1 then
            offsetX =  otherComponents.body.width / 2
        else
            offsetX = -otherComponents.body.width * 1.5
        end
        offsetY = self.body.height / 2

        if #world:queryRectangleArea(otherX + offsetX, otherComponents.hitbox:getY() - offsetY, self.body.width, self.body.height, {"Wall"}) > 0 then
            return false
        else
            return true
        end
    end
end

function HeldObjectBehavior:otherEntityExceedsVelocity(otherEntity)
    local vx, vy = otherEntity.components.hitbox:getLinearVelocity()
    if math.abs(vx) > self.components.liftable.minVxForThrow or math.abs(vy) > self.components.liftable.minVxForThrow then
        return true
    end
end

function HeldObjectBehavior:pickup(otherEntity)
    otherEntity.tags.heldObject = self.entity
    self.entity.systems.heldObjectWeld:weld(otherEntity)
    self.hitbox:setMass(0)
end

function HeldObjectBehavior:drop(otherEntity)
    self.entity.systems.heldObjectWeld:destroyWeld(otherEntity)

    local offsetX
    if otherEntity.components.position.directionX == 1 then
        offsetX = (otherEntity.components.body.width / 2 + self.components.body.width / 2) + OBJECT_DROP_OFFSET_X
    else
        offsetX = -otherEntity.components.body.width - OBJECT_DROP_OFFSET_X
    end

    self.hitbox:setX(otherEntity.components.hitbox:getX() + offsetX)
    self.hitbox:setY(otherEntity.components.hitbox:getY())
end

function HeldObjectBehavior:throw(otherEntity)
    self.entity.systems.heldObjectWeld:destroyWeld(otherEntity)

    local liftableComponent = self.components.liftable
    local throwForceX = otherEntity.components.position.directionX * (liftableComponent.throwForce * liftableComponent.throwForceMultiplierX)
    self.hitbox:applyLinearImpulse(throwForceX, liftableComponent.throwForce * liftableComponent.throwForceMultiplierY)
end
