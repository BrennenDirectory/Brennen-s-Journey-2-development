return function(data)
    return {
        currentSpeed = data.currentSeed,
        walkSpeed = data.walkSpeed,
        sprintSpeed = data.sprintSpeed,
        heldObjectWalkSpeed = data.heldObjectWalkSpeed,
        isControlledByUser = data.isControlledByUser
    }
end