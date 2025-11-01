_G.JumpBehavior = class{}

function JumpBehavior:init(entity)
    self.entity = entity

    self.jumpData = entity.components.jumpData
    self.qWidth = self.jumpData.queryWidth
    self.qHeight = self.jumpData.queryHeight

    self.body = entity.components.body
    self.width = self.body.width
    self.height = self.body.height

    self.hitbox = entity.components.hitbox
end

function JumpBehavior:update(dt)
    if self.entity.tags.isBeingKnocked then
        return
    end

    if self.jumpData.jumps < self.jumpData.maxJumps then
        local x, y = self.hitbox:getX(), self.hitbox:getY()

        local groundCheck = world:queryRectangleArea(x - self.width/2, y + self.height/2, 
        self.qWidth, self.qHeight, 
        self.jumpData.groundClasses)

        if #groundCheck > 0 then
            self.jumpData.jumps = self.jumpData.maxJumps
        end
    end

    if self.entity.tags.isControlledByUser then
        if Input:pressed("jump") and self.jumpData.jumps > 0 then
            self:jump()
        end
    end
end

function JumpBehavior:jump()
    if self.entity.tags.isBeingKnocked or self.jumpData.jumps == 0 then
        return
    end

    local vx, vy = self.hitbox:getLinearVelocity()
    local realJumpPower = 0
    if vy > self.jumpData.minDownwardVy then
        realJumpPower = self.jumpData.jumpPower * self.jumpData.jumpPowerMultiplier
    else
        realJumpPower = self.jumpData.jumpPower
    end

    self.hitbox:applyLinearImpulse(0, -realJumpPower)
    self.jumpData.jumps = self.jumpData.jumps - 1
end