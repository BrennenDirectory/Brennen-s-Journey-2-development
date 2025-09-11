SwingingPlatform = class{}

local ANCHOR_DISTANCE = 300
local ANCHOR_SIZE = 8
local ROPE_TEXTURE = love.graphics.newImage("src/gfx/physicsObjects/swinging_platform_rope.png")
local ROPE_OFFSET_Y = ROPE_TEXTURE:getHeight()/2

function SwingingPlatform:init(object)
    self.hitbox = world:newRectangleCollider(object.x, object.y, object.width, object.height)
    self.hitbox:setType("dynamic")
    self.hitbox:setFixedRotation(true)
    self.hitbox:setFriction(0)
    self.hitbox:setCollisionClass("Ground")
    

    self.anchorPoint = world:newRectangleCollider(object.x + object.width / 2, object.y - ANCHOR_DISTANCE, ANCHOR_SIZE, ANCHOR_SIZE)
    self.anchorPoint:setType("static")
    self.anchorPoint:setCollisionClass("Ghost")

    local mid1 = {x = self.hitbox:getX(), y = self.hitbox:getY()}
    local mid2 = {x = self.anchorPoint:getX(), y = self.anchorPoint:getY()}

    self.weld = world:addJoint("RopeJoint", self.hitbox, self.anchorPoint, mid1.x, mid1.y, mid2.x, mid2.y, ANCHOR_DISTANCE, false)
    mid1, mid2 = nil, nil

    self.top = world:newLineCollider(object.x + 1, object.y - 1, object.x + object.width - 1, object.y - 1)
    self.top:setType("dynamic")
    self.top:setFixedRotation(true)
    self.top:setFriction(1)
    self.top:setCollisionClass("MovingPlatform")
    
    self.weld2 = world:addJoint("WeldJoint", self.top, self.hitbox, self.hitbox:getX(), self.hitbox:getY(), false)

    self.drawScaleX = object.width / MovingPlatform.TEXTURE:getWidth()
    self.drawScaleY = object.height / MovingPlatform.TEXTURE:getHeight()
    self.ropeDrawAngle = 0
    self.ropeDrawScaleX = 0
    self.ropeDrawScaleY = 1.5
end

function SwingingPlatform:update(dt)
    self.ropeDrawScaleX = lume.distance(self.anchorPoint:getX(), self.anchorPoint:getY(), self.hitbox:getX(), self.hitbox:getY()) / ROPE_TEXTURE:getWidth()
    self.ropeDrawAngle = lume.angle(self.anchorPoint:getX(), self.anchorPoint:getY(), self.hitbox:getX(), self.hitbox:getY())
end

function SwingingPlatform:render()
    love.graphics.draw(ROPE_TEXTURE, self.anchorPoint:getX(), self.anchorPoint:getY(), self.ropeDrawAngle, self.ropeDrawScaleX, self.ropeDrawScaleY, nil, ROPE_OFFSET_Y)
    love.graphics.draw(MovingPlatform.TEXTURE, self.hitbox:getX(), self.hitbox:getY(), nil, self.drawScaleX, self.drawScaleY, MovingPlatform.DRAW_OFFSET_X, MovingPlatform.DRAW_OFFSET_Y)
end


function SwingingPlatform:destroy()
    self.weld:destroy()
    self.weld2:destroy()
    self.hitbox:destroy()
    self.anchorPoint:destroy()
    self.top:destroy()

    self.hitbox = nil
    self.top = nil
    self.anchorPoint = nil
    self.weld = nil
    self.weld2 = nil
end