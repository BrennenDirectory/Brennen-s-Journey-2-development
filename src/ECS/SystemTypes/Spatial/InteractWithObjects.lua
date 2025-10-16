_G.InteractWithObjects = class{}

-- Requires the Baton library for input
-- Only queries a rectangle for simplicity

local OFFSET_NEGATIVE_X_MULT = 3

function InteractWithObjects:init(entity)
    self.entity = entity
    self.tags = entity.tags

    self.tags.canInteract = true
    self.queryData = entity.components.interactQueryData
    self.inputData = entity.components.inputData

    self.hitbox = entity.components.hitbox
end

function InteractWithObjects:update(dt)
    if Input:pressed("interact") and self.tags.canInteract then
        self:queryForObjects()
    end
end

function InteractWithObjects:queryForObjects()
    local x, y = self.hitbox:getX(), self.hitbox:getY()
    local offsetX = self.inputData.lastIx == 1 and self.queryData.offsetX or -(self.queryData.offsetX * OFFSET_NEGATIVE_X_MULT)
    local offsetY = self.queryData.offsetY
    local objects = world:queryRectangleArea(x + offsetX, y + offsetY, self.queryData.width, self.queryData.height, self.queryData.classes)

    if #objects > 0 then
        local object = objects[1]:getObject() -- interacts with only the first object found

        if not object or not object.tags.canInteractWith then
            return
        end

        object.systems[object.tags.systemForInteracting]:interact(self.entity)
        self.tags.canInteract = false
    end
end