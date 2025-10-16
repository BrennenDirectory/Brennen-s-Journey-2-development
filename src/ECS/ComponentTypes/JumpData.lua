return function(data)
    return {
        jumpPower = data.jumpPower,
        jumpPowerMultiplier = data.jumpPowerMultiplier,
        jumps = data.maxJumps,
        maxJumps = data.maxJumps,
        groundClasses = data.groundClasses,
        isControlledByUser = data.isControlledByUser
    }
end