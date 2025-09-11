_G.HealthBottle = class{} -- An item the Player can pickup to increase health by 1 (half a heart/bottle)
HealthBottle.TEXTURE = love.graphics.newImage("src/gfx/player/hud/bottle.png")

local BOTTLE_WIDTH = 20
local BOTTLE_HEIGHT = 40
local SCALE_X = BOTTLE_WIDTH * 1.75 / HealthBottle.TEXTURE:getWidth()
local SCALE_Y = BOTTLE_HEIGHT / HealthBottle.TEXTURE:getHeight()
local OFFSET_X = HealthBottle.TEXTURE:getWidth() / 2
local OFFSET_Y = HealthBottle.TEXTURE:getHeight() / 2

local MIN_PUSH_X_FORCE = 100
local MAX_PUSH_X_FORCE = MIN_PUSH_X_FORCE * 2

local MIN_PUSH_Y_FORCE = 400
local MAX_PUSH_Y_FORCE = MIN_PUSH_Y_FORCE * 2

local SPAWN_Y_OFFSET = BOTTLE_HEIGHT / 3
local DRAW_Y_OFFSET = 4
local TIME_UNTIL_DESPAWN = 5
function HealthBottle:init(originX, originY)
    self.hitbox = world:newRectangleCollider(originX, originY - SPAWN_Y_OFFSET, BOTTLE_WIDTH, BOTTLE_HEIGHT)
    self.hitbox:setType("dynamic")
    self.hitbox:setFixedRotation(true)
    self.hitbox:setRestitution(0.5)
    self.hitbox:setCollisionClass("HealthBottle")
    self.hitbox:setObject(self)

    local directionOfPush = math.random(1, 10) % 2 == 0 and 1 or -1
    local pushForceX = math.random(MIN_PUSH_X_FORCE, MAX_PUSH_X_FORCE)
    local pushForceY = math.random(MIN_PUSH_Y_FORCE, MAX_PUSH_Y_FORCE)

    self.hitbox:applyLinearImpulse(pushForceX * directionOfPush, -pushForceY)

    self.isCollected = false
    self.hasDespawned = false

    self.despawnTimer = Timer.new()
    self.despawnTimer:after(TIME_UNTIL_DESPAWN, function() self.hasDespawned = true end)
end

function HealthBottle:update(dt)
    self.despawnTimer:update(dt)
end

function HealthBottle:render()
    love.graphics.draw(self.TEXTURE, self.hitbox:getX(), self.hitbox:getY() + DRAW_Y_OFFSET, nil, SCALE_X, SCALE_Y, OFFSET_X, OFFSET_Y)
end

function HealthBottle:destroy()
    self.hitbox:destroy()
    self.despawnTimer:clear()
    self.hitbox = nil
    self.despawnTimer = nil
end