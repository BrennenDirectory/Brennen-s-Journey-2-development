local WELD_PIXEL_OFFSET_Y = 4

return function(entity)
    local heldObjectWeld = {}

    function heldObjectWeld:init()
        self.entity = entity
        self.hitbox = self.entity.components.hitbox
        self.weldBetweenObjects = {}
    end
    
    function heldObjectWeld:weld(otherEntity)
        local otherHitbox = otherEntity.components.hitbox
        local otherEntityHeight = otherEntity.components.body.height
        local offsetY = otherEntityHeight / 2 + self.entity.components.body.height / 2
        self.hitbox:setY(otherHitbox:getY() - offsetY - WELD_PIXEL_OFFSET_Y)
        self.hitbox:setX(otherHitbox:getX())

        self.weldBetweenObjects = world:addJoint("WeldJoint", self.hitbox, otherHitbox, self.hitbox:getX(), self.hitbox:getY(), false)

        otherHitbox = nil
    end

    function heldObjectWeld:destroyWeld()
        self.weldBetweenObjects:destroy()
        self.weldBetweenObjects = {}
    end

    function heldObjectWeld:remove()
        if self.weldBetweenObjects then
            self:destroyWeld()
            self.entity = nil
            self.hitbox = nil
            self.weldBetweenObjects = nil
        end
    end

    heldObjectWeld:init()

    return heldObjectWeld
end