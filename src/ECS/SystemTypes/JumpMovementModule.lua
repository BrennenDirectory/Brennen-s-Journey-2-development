_G.JumpMovementModule = class{}

local HEIGHT_OF_QUERY = 2
local MIN_DOWNWARD_VY = 5

function JumpMovementModule:init(entity)
    self.entity = entity
    self.components = entity.components
    self.tags = entity.tags

    self.jumpData = entity.components.jumpData
    self.hitbox = entity.components.hitbox
    self.body = entity.components.body
end

function JumpMovementModule:update(dt)
    if self.tags.isBeingKnocked then
        return
    end

    if self.jumpData.jumps < self.jumpData.maxJumps then
        local x, y = self.hitbox:getX(), self.hitbox:getY()
        local width, height = self.body.width, self.body.height
        local groundCheck = world:queryRectangleArea(x - width/2, y + height/2, width, HEIGHT_OF_QUERY, self.jumpData.groundClasses)
        if #groundCheck > 0 then
            self.jumpData.jumps = self.jumpData.maxJumps
        end
    end

    if self.jumpData.isControlledByUser then
        if Input:pressed("jump") and self.jumpData.jumps > 0 then
            self:jump()
        end
    end
end

function JumpMovementModule:jump()
    if self.tags.isBeingKnocked or self.jumpData.jumps == 0 then
        return
    end

    local vx, vy = self.hitbox:getLinearVelocity()
    local realJumpPower = 0
    if vy > MIN_DOWNWARD_VY then
        realJumpPower = self.jumpData.jumpPower * self.jumpData.jumpPowerMultiplier
    else
        realJumpPower = self.jumpData.jumpPower
    end

    self.hitbox:applyLinearImpulse(0, -realJumpPower)
    self.jumpData.jumps = self.jumpData.jumps - 1
end