return function(entity)
    local inputModule = {}
    
    function inputModule:init()
        self.entity = entity
        self.inputData = entity.components.inputData
        self.position = entity.components.position
    end

    function inputModule:update(dt)
        if Input:down("right") then
            self.inputData.ix = 1 -- short for Input Vector X
            self.inputData.lastIx = 1
            self.position.directionX = 1
        elseif Input:down("left") then
            self.inputData.ix = -1
            self.inputData.lastIx = -1
            self.position.directionX = -1
        else
            self.inputData.ix = 0
        end
    end

    inputModule:init()

    return inputModule
end