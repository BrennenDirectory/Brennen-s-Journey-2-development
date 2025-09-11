Snapper = class{}
local player = require"src.Player.player"

local width, height = 48, 128
local QUERY_DISTANCE = 196
local image = love.graphics.newImage("src/gfx/enemies/Snapper.PNG")

function Snapper:init(object)
    self.hitbox = world:newRectangleCollider(object.x, object.y, width, height)
    self.hitbox:setType("static")
    self.hitbox:setCollisionClass("Enemy")
    self.hitbox:setObject(self)

    self.maxHealth = 10
    self.health = self.maxHealth
    self.isDead = false
    self.damageToPlayer = 1

    self.attackTimer = Timer.new()
    self.canAttack = true
end

function Snapper:update(dt)
    self.attackTimer:update(dt)
    self:queryForPlayer()
end

function Snapper:render()
    love.graphics.draw(image, self.hitbox:getX(), self.hitbox:getY(), nil, width/image:getWidth(), height/image:getHeight(), image:getWidth()/2, image:getHeight()/2)
end

function Snapper:attack()
    self.canAttack = false
    self.attackTimer:after(3, function()
        self.canAttack = true
    end)

    -- the query for the attack is weird and should be performed on a animation keyframe for example
    local angle = lume.angle(self.hitbox:getX(), self.hitbox:getY(), player.hitbox:getX(), player.hitbox:getY())
    local cos = math.cos(angle)
    local sin = math.sin(angle)
    world:queryLine(self.hitbox:getX(), self.hitbox:getY(), self.hitbox:getX() + (cos * QUERY_DISTANCE/1.5), self.hitbox:getY() + (sin * QUERY_DISTANCE/1.5))
end

function Snapper:queryForPlayer()
    if self.canAttack then
        if #world:queryCircleArea(self.hitbox:getX(), self.hitbox:getY(), QUERY_DISTANCE, {"Player"}) > 0 then
            self:attack()
        end
    end
end

function Snapper:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
    self.attackTimer:clear()
    self.attackTimer = nil
end