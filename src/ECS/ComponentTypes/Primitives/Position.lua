return function(data)
    return {
        x = data.x or 0,
        y = data.y or 0,
        directionX = data.directionX,
        directionY = data.directionY
    }
end