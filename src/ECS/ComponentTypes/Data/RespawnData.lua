return function(data) -- Can be used for a player or an object like a crate that respawns when destroyed
    return {
        x = data.x,
        y = data.y,
        width = data.width,
        height = data.height,
        id = data.id
    }
end