_G.InteractWithObjects = class{}

-- Requires the Baton library for input
-- Only queries a rectangle for simplicity

function InteractWithObjects:init(entity)
    self.entity = entity
    self.tags = entity.tags

    self.tags.canInteract = true
    self.queryData = entity.components.interactQueryData
    self.hitbox = entity.components.hitbox
end

function InteractWithObjects:update(dt)
    if Input:pressed("interact") and self.tags.canInteract then
        self:queryForObjects()
    end
end

function InteractWithObjects:queryForObjects()
    -- TODO: add offsetX and offsetY
    local x, y = self.hitbox:getX(), self.hitbox:getY()
    local offsetX, offsetY = self.queryData.offsetX, self.queryData.offsetY
    local objects = world:queryRectangleArea(x + offsetX, y + offsetY, self.queryData.width, self.queryData.height, self.queryData.classes)

    if #objects > 0 then
        local object = objects[1]:getObject() -- interacts with only the first object found
        object.systems[object.tags.systemForInteracting]:interact(self.entity)
        self.tags.canInteract = false
    end
end