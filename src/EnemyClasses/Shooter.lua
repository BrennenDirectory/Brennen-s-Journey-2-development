-- name is TBD
Shooter = class{}
local player = require"src.Player.player"
local Enemies = require"src.EnemyClasses.Enemies"

local width, height = 48, 48
local ballSize = 32
local ballSpeed = 350

local QUERY_DISTANCE = 400
local knockbackForce = 500
local shootDelay = 2

local image = love.graphics.newImage("src/gfx/enemies/Shooter.PNG")

function Shooter:init(object)
    self.hitbox = world:newRectangleCollider(object.x, object.y, width, height)
    self.hitbox:setFixedRotation(true)
    self.hitbox:setType("dynamic")
    self.hitbox:setCollisionClass("Enemy")
    self.hitbox:setFriction(1)
    self.hitbox:setObject(self)

    self.maxHealth = 10
    self.health = self.maxHealth
    self.damageToPlayer = 4

    self.isDead = false
    self.canShoot = true

    self.direction = -1
    self.ball = nil

    self.shootTimer = Timer.new()
end

function Shooter:update(dt)
    self.shootTimer:update(dt)
    self:queryForPlayer()
    if self.ball then
        self:ballCollisions()
    end
end

function Shooter:render()
    love.graphics.draw(image, self.hitbox:getX(), self.hitbox:getY(), nil, self.direction * (width/image:getWidth()), height/image:getHeight(), image:getWidth()/2, image:getHeight()/2)
end

function Shooter:shoot()
    self.ball = world:newRectangleCollider(self.hitbox:getX() - ballSize/2, self.hitbox:getY() - ballSize/2, ballSize, ballSize)
    self.ball:setGravityScale(0)
    self.ball:setFixedRotation(true)
    self.ball:setType("dynamic")
    self.ball:setCollisionClass("EnemyProjectile")
    self.ball:setBullet(true)
    self.ball.canBeReflected = true
    self.ball.hasReflected = false
    self.ball.direction = self.direction
    self.ball:applyLinearImpulse(ballSpeed * self.direction, 0)
end

function Shooter:ballCollisions()
    if self.ball:enter("Enemy") and self.ball.hasReflected then -- if the Shooter's projectile gets reflected back at them and hits them
        local enemy = self.ball:getEnterCollisionData("Enemy")
        if enemy.collider:getObject() == self then
            Enemies.hitEnemy(self, self.damageToPlayer)
            self:knockback(self.ball.direction)
            self:destroyBall()
        end
    elseif self.ball:enter("Player") or self.ball:exit('Player') then
        player.takeDamage(self.damageToPlayer)
        player.knockback(self)
        self:destroyBall()
    elseif lume.distance(self.ball:getX(), self.ball:getY(), self.hitbox:getX(), self.hitbox:getY()) >= 400 or self:ballHitsWall() then
        self:destroyBall()
    end
end

function Shooter:queryForPlayer()
    self.direction = self.hitbox:getX() - player.hitbox:getX() < 0 and 1 or -1

    if self.ball or not self.canShoot then
        return
    end

    if #world:queryLine(self.hitbox:getX() - QUERY_DISTANCE, self.hitbox:getY(), self.hitbox:getX() + QUERY_DISTANCE, self.hitbox:getY(), {"Player"}) > 0 then
        self:shoot()
        self.canShoot = false
    end
end

function Shooter:knockback(directionOfAttack)
    if self.hitbox then
        local realDirection
        if (directionOfAttack == self.direction and directionOfAttack == 1) or directionOfAttack > self.direction then
            realDirection = 1
        elseif (directionOfAttack == self.direction and directionOfAttack == -1) or directionOfAttack < self.direction then
            realDirection = -1
        end
        self.hitbox:applyLinearImpulse(realDirection * knockbackForce, -knockbackForce)
    end
end

function Shooter:ballHitsWall()
    if self.ball:enter("Wall") or self.ball:enter("Ground") or self.ball:enter("Crate") then
        return true
    end
    return false
end

function Shooter:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
    self.shootTimer:clear()
    self.shootTimer = nil
    self:destroyBall(true)
end

function Shooter:destroyBall(isDead)
    if self.ball then
        self.ball:destroy()
        self.ball = nil
        if not isDead then
            self.shootTimer:after(shootDelay, function() self.canShoot = true end)
        end
    end
end