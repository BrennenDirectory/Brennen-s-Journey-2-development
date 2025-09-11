Bat = class{}

local size = 22
local speedX = 12000
local speedY = 8000
local image = love.graphics.newImage("src/gfx/enemies/Bat.PNG")

local HITBOX_CORNER_CUT_SIZE = 3

local directionXTimerDelay = 5
local directionYTimerDelay = 0.5

function Bat:init(object)
    self.hitbox = world:newBSGRectangleCollider(object.x, object.y, size, size, HITBOX_CORNER_CUT_SIZE)
    self.hitbox:setFixedRotation(true)
    self.hitbox:setType("dynamic")
    self.hitbox:setCollisionClass("Enemy")
    self.hitbox:setFriction(0)
    self.hitbox:setObject(self)

    self.maxHealth = 5
    self.health = self.maxHealth
    self.damageToPlayer = 3

    self.isDead = false

    self.directionX = math.random(1, 4) % 2 == 0 and 1 or -1
    self.directionY = math.random(1, 4) % 2 == 0 and 1 or -1

    self.timerX = Timer.new()
    self.timerX:every(directionXTimerDelay, function ()
        self.directionX = math.random(1, 4) % 2 == 0 and 1 or -1
    end)

    self.timerY = Timer.new()
    self.timerY:every(directionYTimerDelay, function ()
        self.directionY = math.random(1, 4) % 2 == 0 and 1 or -1
    end)
end

function Bat:update(dt)
    self.timerX:update(dt)
    self.timerY:update(dt)
    self:move(dt)
    self:collisions()
end

function Bat:render()
    love.graphics.draw(image, self.hitbox:getX(), self.hitbox:getY(), nil, self.directionX * (size/image:getWidth()), size/image:getHeight(), image:getWidth()/2, image:getHeight()/2)
end

function Bat:move(dt)
    self.hitbox:setLinearVelocity(speedX * dt * self.directionX, speedY * dt * -self.directionY)
end

function Bat:collisions()
    if self.hitbox:enter("Wall") or self.hitbox:enter("Crate") or self.hitbox:enter("LoadingZone") then
        self.directionX = -self.directionX
    elseif self.hitbox:enter("Ground") then
        self.directionY = -self.directionY
    end
end

function Bat:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
    self.timerX:clear()
    self.timerX = nil
    self.timerY:clear()
    self.timerY = nil
end