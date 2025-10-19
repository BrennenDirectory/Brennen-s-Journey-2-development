local TIME_UNTIL_EVENT = 0.1
return function(entity)
    local creation = {
        entity = entity,
        timer = Timer.new(),
        creationData = entity.components.creationData
    }

    creation.timer:after(TIME_UNTIL_EVENT, function()
        creation.creationData.onCreation(creation.entity)
        creation.timer:clear()
        creation.timer = nil
        creation.update = nil
        creation.entity:removeSystems({"entityCreation"})
    end)

    function creation:update(dt)
        if creation.timer then
            creation.timer:update(dt)
        end
    end

    function creation:remove()
        if creation.update then
            creation.update = nil
        end

        if creation.timer then
            creation.timer:clear()
            creation.timer = nil
        end
    end

    return creation
end