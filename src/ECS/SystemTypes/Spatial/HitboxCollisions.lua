_G.HitboxCollisions = class{}

function HitboxCollisions:init(entity)
    self.entity = entity
    self.hitbox = entity.components.hitbox
    self.collisionData = entity.components.collisionData
    self.events = {}

    if self.collisionData.onEnterEvent then
        self.events['enterEvents'] = function(dt)
            self:enterEvents(dt)
        end
    end

    if self.collisionData.onExitEvent then
        self.events['exitEvents'] = function(dt)
            self:enterEvents(dt)
        end
    end

    if self.collisionData.onStayEvent then
        self.events['stayEvents'] = function(dt)
            self:enterEvents(dt)
        end
    end
end

function HitboxCollisions:update(dt)
    for i, event in pairs(self.events) do
        event(dt)
    end
end

function HitboxCollisions:enterEvents(dt)
    for i, class in ipairs(self.collisionData.onEnterClasses) do
        if self.hitbox:enter(class) then
            local otherObject = self.hitbox:getEnterCollisionData(class)
            local otherEntity = otherObject.collider:getObject()
            self.collisionData.onEnterEvent(self.entity, otherEntity)
        end
    end
end

function HitboxCollisions:exitEvents(dt)
    for i, class in ipairs(self.collisionData.onExitClasses) do
        if self.hitbox:enter(class) then
            local otherHitbox = self.hitbox:getExitCollisionData(class)
            local otherEntity = otherHitbox:getObject()
            self.collisionData.onExitEvent(self.entity, otherEntity)
        end
    end
end

function HitboxCollisions:stayEvents(dt)
    for i, class in ipairs(self.collisionData.onStayClasses) do
        if self.hitbox:enter(class) then
            local otherHitbox = self.hitbox:getStayCollisionData(class)
            local otherEntity = otherHitbox:getObject()
            self.collisionData.onStayEvent(dt, self.entity, otherEntity)
        end
    end
end