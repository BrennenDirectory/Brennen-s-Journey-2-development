return function(entity)
    local module = {
        entity = entity,
        signalData = entity.components.signalData
    }

    Signal.register(module.signalData.name, module.signalData.signalBody)

    function module:remove()
        Signal.remove(module.signalData.name, module.signalData.signalBody)
    end

    return module
end