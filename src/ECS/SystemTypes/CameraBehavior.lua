_G.CameraBehavior = class{}

function CameraBehavior:init(entity)
    self.entity = entity
    self.camera = entity.components.camera.camera
    self.target = entity.components.camera.target
    self.updateTarget = entity.components.camera.updateTarget or nil
    self.zoomLevel = entity.components.camera.zoomLevel

    self.camera:zoomTo(self.zoomLevel)

    Signal.emit("NewCameraControlledEntity", entity)
end

function CameraBehavior:update(dt)
    if self.updateTarget then
        self.updateTarget(dt, self.entity)
    end
    self:lookAtTarget()
end

function CameraBehavior:lookAtTarget()
    self.camera:lookAt(self.target.x, self.target.y)
end

function CameraBehavior:attach()
    self.camera:attach()
end

function CameraBehavior:detach()
    self.camera:detach()
end