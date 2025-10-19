local cameraConstructor = require"src.lib.camera"
return function(data)
    return {
        camera = cameraConstructor(),
        target = data.target,
        updateTarget = data.updateTarget or nil,
        zoomLevel = data.zoomLevel
    }
end