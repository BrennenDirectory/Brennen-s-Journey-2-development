_G.HitboxSpatialChecks = class{}

local PLATFORM_QUERY_HEIGHT = 2

function HitboxSpatialChecks:init(entity)
    self.entity = entity
    self.components = entity.components

    self.body = entity.components.body
    self.hitbox = entity.components.hitbox

end

function HitboxSpatialChecks:isOnMovingPlatform()
    local width, height = self.body.width, self.body.height
    local x, y = self.hitbox:getX(), self.hitbox:getY()
    local objects = world:queryRectangleArea(x - width / 2, y + height / 2, width, PLATFORM_QUERY_HEIGHT, {"MovingPlatform"})

    if #objects > 0 then
        return true
    else
        return false
    end
end

-- TODO: add ground checks, etc