return function(data) -- Used for objects that can act as passages like Gates, Doors, Hatches, etc.
    return {
        isOpen = data.isOpen,
        isLocked = data.isLocked,
        canOpen = data.canOpen
    }
end