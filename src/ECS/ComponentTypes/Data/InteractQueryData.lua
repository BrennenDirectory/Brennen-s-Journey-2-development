return function(data)
    return {
        offsetX = data.offsetX or 0,
        offsetY = data.offsetY or 0,
        width = data.width,
        height = data.height,
        classes = data.classes
    }
end