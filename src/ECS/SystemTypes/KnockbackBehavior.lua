_G.KnockbackBehavior = class{}

function KnockbackBehavior:init(entity)
    self.tags = entity.tags
    self.knockbackData = entity.components.knockbackData
    self.position = entity.components.position
    self.hitbox = entity.components.hitbox

    self.knockbackChain = 0
    self.timer = self.knockbackData.timer
    self.delayAmount = self.knockbackData.delayAmount
end

function KnockbackBehavior:update(dt)
    self.timer:update(dt)
end

function KnockbackBehavior:takeKnockback(otherEntity)
    if self.knockbackChain == 0 then
        self.tags.isBeingKnocked = true
    end

    self.knockbackChain = self.knockbackChain + 1

    local directionOfKnockback = self:getDirectionOfKnockback(otherEntity)

    local forceX = math.random(self.knockbackData.minForce, self.knockbackData.maxForce)
    local forceY = math.random(self.knockbackData.minForce, self.knockbackData.maxForce)
    local multX = self.knockbackData.forceMultiplierX
    local multY = self.knockbackData.forceMultiplierY

    self.hitbox:applyLinearImpulse(directionOfKnockback * (forceX * multX), -(forceY * multY))

    self.timer:after(self.delayAmount, function()
        self.knockbackChain = self.knockbackChain - 1
        if self.knockbackChain == 0 then
            self.tags.isBeingKnocked = false
        end
    end)
end

function KnockbackBehavior:getDirectionOfKnockback(otherEntity)
    local otherHitbox = otherEntity.components.hitbox

    local thisDirection = self.position.direction
    local otherDirection = otherEntity.components.position.direction
    local sideOfOtherEntity = otherHitbox:getX() > self.hitbox:getX() and 1 or -1

    local directionOfKnockback

    if thisDirection == otherDirection then
        if sideOfOtherEntity == 1 then
            directionOfKnockback = -1
        else
            directionOfKnockback = 1
        end
    elseif otherDirection > thisDirection then
        if sideOfOtherEntity == 1 then
            directionOfKnockback = -1
        else
            directionOfKnockback = 1
        end
    else
        if sideOfOtherEntity == 1 then
            directionOfKnockback = -1
        else
            directionOfKnockback = 1
        end
    end

    return directionOfKnockback
end

function KnockbackBehavior:remove()
    self.timer:clear()
    self.timer = nil
end