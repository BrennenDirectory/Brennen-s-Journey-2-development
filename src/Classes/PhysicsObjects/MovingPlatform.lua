MovingPlatform = class{}
MovingPlatform.TEXTURE = love.graphics.newImage("src/gfx/physicsObjects/wooden_platform.jpg")
MovingPlatform.DRAW_OFFSET_X = MovingPlatform.TEXTURE:getWidth() / 2
MovingPlatform.DRAW_OFFSET_Y = MovingPlatform.TEXTURE:getHeight() / 2

local DEFAULT_WIDTH = 256
local DEFAULT_HEIGHT = 48
local DEFAULT_SPEED = 5000

-- duration = use float for data type in object properties (Tiled), not integer
function MovingPlatform:init(object)
    self.width = object.width or DEFAULT_WIDTH
    self.height = object.height or DEFAULT_HEIGHT
    self.speed = object.properties.Speed or DEFAULT_SPEED
    self.startAxis = object.properties.StartAxis
    self.duration = object.properties.Duration

    self.hitbox = world:newRectangleCollider(object.x, object.y, self.width, self.height)
    self.hitbox:setType("kinematic")
    self.hitbox:setFriction(0)
    self.hitbox:setCollisionClass("Ground")

    -- silly method of making the player not able to stick to sides of the platform :'(
    self.top = world:newLineCollider(object.x + 1, object.y - 1, object.x + self.width - 1, object.y - 1)
    self.top:setFriction(1)
    self.top:setType("kinematic")
    self.top:setCollisionClass("MovingPlatform")

    self.drawScaleX = self.width / MovingPlatform.TEXTURE:getWidth()
    self.drawScaleY = self.height / MovingPlatform.TEXTURE:getHeight()

    self.dx = self.startAxis == "x" and -1 or self.startAxis == "-x" and 1 or 0
    self.dy = self.startAxis == "y" and -1 or self.startAxis == "-y" and 1 or 0
    self.timer = Timer.new()
    self.timer:every(self.duration, function()
        if self.dx ~= 0 then
            self.dx = self.dx * -1
        else
            self.dy = self.dy * -1
        end
    end)

    self.startAxis = nil
end

function MovingPlatform:update(dt)
    self.timer:update(dt)
    -- maybe change to add speed to velocity over time to make less snappy.
    self.hitbox:setLinearVelocity((self.dx * self.speed) * dt, (self.dy * self.speed) * dt)
    self.top:setLinearVelocity((self.dx * self.speed) * dt, (self.dy * self.speed) * dt)
end

function MovingPlatform:render()
    love.graphics.draw(MovingPlatform.TEXTURE, self.hitbox:getX(), self.hitbox:getY(), nil, self.drawScaleX, self.drawScaleY, self.DRAW_OFFSET_X, self.DRAW_OFFSET_Y)
end

function MovingPlatform:destroy()
    self.top:destroy()
    self.top = nil
    self.hitbox:destroy()
    self.hitbox = nil
    self.timer:clear()
    self.update = nil
end