Glorp = class{}
local player = require"src.Player.player"

local size = 24
local queryWidth = 128
local queryHeight = 64

local speed = 2500
local jumpPower = 300
local knockbackForce = 200
local knockbackTime = 0.25
local choiceTime = 2

local choices = {
    wander = 1,
    jumpAndWander = 2,
    idle = 3
}

local image = love.graphics.newImage("src/gfx/enemies/1/glorp.png")

local HITBOX_CORNER_CUT_SIZE = 3
local XP_REWARD_AMOUNT = 8

function Glorp:init(object)
    self.hitbox = world:newBSGRectangleCollider(object.x, object.y, size, size, HITBOX_CORNER_CUT_SIZE)
    self.hitbox:setType("dynamic")
    self.hitbox:setFixedRotation(true)
    self.hitbox:setRestitution(0)
    self.hitbox:setFriction(0)
    self.hitbox:setCollisionClass("Enemy")
    self.hitbox:setObject(self)

    self.vx, self.vy = 0, 0
    self.maxHealth = 10
    self.health = self.maxHealth
    self.damageToPlayer = 1
    self.xpRewardAmount = XP_REWARD_AMOUNT

    self.isDead = false
    self.isWandering = false
    self.isFollowingPlayer = false
    self.isBeingKnocked = false

    self.direction = 1

    self.choiceTimer = Timer.new()
    self.choiceTimer:every(choiceTime, function() self:makeDecision() end)

    self.knockbackTimer = Timer.new()

    self:makeDecision()
end

function Glorp:update(dt)
    if self.choiceTimer then
        self.choiceTimer:update(dt)
    end

    self.knockbackTimer:update(dt)

    self.vx, self.vy = self.hitbox:getLinearVelocity()
    if self.isWandering then
        self:wander(dt)
    end

    if not self.isFollowingPlayer then
        self:queryForPlayer()
    else
        self:followPlayer(dt)
    end

    self:collisions()
end

function Glorp:render()
    love.graphics.draw(image, self.hitbox:getX(), self.hitbox:getY(), nil,  self.direction * (size/image:getWidth()), size/image:getHeight(), image:getWidth()/2, image:getHeight()/2)
end

function Glorp:jump()
    local x, y = self.hitbox:getX(), self.hitbox:getY()

    local groundBelow = world:queryRectangleArea(x - size/2, y + size/2, size, 2, {"Ground"})
    if #groundBelow > 0 then
        self.hitbox:applyLinearImpulse(0, -jumpPower)
    end

    x, y = nil, nil
    groundBelow = nil
end

function Glorp:wander(dt)
    if not self.isBeingKnocked then
        self.hitbox:setLinearVelocity(self.direction * (speed * dt), self.vy)
    end
end

function Glorp:idle()
    self.hitbox:setLinearVelocity(0, self.vy)
end

function Glorp:queryForPlayer()
    local query = world:queryRectangleArea(self.hitbox:getX() - queryWidth/2, self.hitbox:getY() - queryHeight + size/2, queryWidth, queryHeight, {"Player"})
    if #query > 0 then
        self.isFollowingPlayer = true
        self.isWandering = false
        query = nil
        self.choiceTimer:clear()
        self.choiceTimer = nil
    end
end

function Glorp:followPlayer(dt)
    if not self.isBeingKnocked then
        local x, y = player.hitbox:getX(), player.hitbox:getY()
        local angle = lume.angle(x, y, self.hitbox:getX(), self.hitbox:getY())
        local cos = math.cos(angle)
        self.direction = self.hitbox:getX() - x < 0 and 1 or -1
        -- All of sudden it doesnt like positive cos lol...
        self.hitbox:setLinearVelocity(-cos * speed * dt, self.vy)
    end
end

function Glorp:collisions()
    if self.isWandering then
        if self.hitbox:enter("Crate") or self.hitbox:enter("Wall") then
            self.direction = self.direction * -1
        end
    end
end

function Glorp:makeDecision()
    if not self.isFollowingPlayer then
        local choice = math.random(1, 3)
        if choice == choices.wander then
            -- 50% chance to go left or right
            self.direction = math.random(1, 4) % 2 == 0 and 1 or -1
            self.isWandering = true
        elseif choice == choices.idle then
            self.isWandering = false
            self:idle()
        elseif choice == choices.jumpAndWander then
            self:jump()
            self.isWandering = true
        end
    end
end

function Glorp:knockback(directionOfAttack)
    if self.hitbox then
        self.isBeingKnocked = true
        self.knockbackTimer:after(knockbackTime , function ()
            self.isBeingKnocked = false
        end)

        local realDirection
        if (directionOfAttack == self.direction and directionOfAttack == 1) or directionOfAttack > self.direction then
            realDirection = 1
        elseif (directionOfAttack == self.direction and directionOfAttack == -1) or directionOfAttack < self.direction then
            realDirection = -1
        end
        self.hitbox:applyLinearImpulse(realDirection * (knockbackForce * 2), -knockbackForce)
    end
end

function Glorp:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
    if self.choiceTimer then
        self.choiceTimer:clear()
        self.choiceTimer = nil
    end
    self.knockbackTimer:clear()
    self.knockbackTimer = nil
end