_G.PlatformBehavior = class{}

function PlatformBehavior:init(entity)
    self.entity = entity
    self.body = entity.components.body
    self.platformData = entity.components.platformData

    self.hitbox = entity.components.hitbox
    self.surface = self:createSurface()

    self.weld = {}

    if self.platformData.update then
        function PlatformBehavior:update(dt)
            self.platformData.update(dt, self.entity, self.surface)
        end
    end
end

function PlatformBehavior:remove()
    if not self.weld:isDestroyed() then
        self.weld:destroy()
        self.weld = nil
    end

    self.hitbox:destroy()
    self.surface:destroy()

    self.hitbox = nil
    self.surface = nil
end

function PlatformBehavior:createSurface()
    local px, py = self.hitbox:getX(), self.hitbox:getY()
    local pw = self.body.width
    local hitbox = world:newLineCollider(px + 1, py - 1, px + pw - 1, py - 1)
    hitbox:setFriction(1)
    hitbox:setType("kinematic")
    hitbox:setCollisionClass("Platform")
    return hitbox
end

return PlatformBehavior