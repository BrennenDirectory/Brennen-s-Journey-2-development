_G.TargetQuerying = class{}

function TargetQuerying:init(entity)
    self.entity = entity
    self.targetData = entity.components.targetData

    self.qw = self.targetData.queryWidth
    self.qh = self.targetData.queryHeight
    self.cc = self.targetData.collisionClass

    self.result = {}
end

function TargetQuerying:update(dt)
    if self.targetData.canQueryForTarget then
        if self.targetData.queryUpdate then
            self.targetData.queryUpdate(self.entity, self.entity.components)
        end
        self:query()
    end
end

function TargetQuerying:query()
    if self.qh and self.qh == 1 then
        self.result = world:queryLine(
            self.targetData.queryPosition.x,
            self.targetData.queryPosition.y,
            self.targetData.queryPosition.x + self.qw,
            self.targetData.queryPosition.y,
            self.cc
        )
    elseif self.qw and self.qw == 1 then
        self.result = world:queryLine(
            self.targetData.queryPosition.x,
            self.targetData.queryPosition.y,
            self.targetData.queryPosition.x,
            self.targetData.queryPosition.y + self.qh,
            self.cc
        )
    elseif self.targetData.queryRadius then
        self.result = world:queryCircleArea(
            self.targetData.queryRadius,
            self.targetData.queryPosition.x,
            self.targetData.queryPosition.y,
            self.cc
        )
    else
        self.result = world:queryRectangleArea(
            self.targetData.queryPosition.x,
            self.targetData.queryPosition.y,
            self.qw,
            self.qh,
            self.cc
        )
    end

    if #self.result > 0 then
        local otherEntity = self.result[1]:getObject()
        self.targetData.target = otherEntity
        if self.targetData.onTargetFound then
            self.targetData.onTargetFound(self.entity, otherEntity)
        end
    end
end