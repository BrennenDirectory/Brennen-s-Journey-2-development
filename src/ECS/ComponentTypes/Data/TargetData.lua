return function(data)
    return {
        canQueryForTarget = data.canQueryForTarget,
        collisionClass = data.collisionClass,
        onTargetFound = data.onTargetFound,
        queryWidth = data.queryWidth,
        queryHeight = data.queryHeight,
        queryRadius = data.queryRadius,
        queryPosition = data.queryPosition,
        queryUpdate = data.queryUpdate,
        target = data.target
    }
end