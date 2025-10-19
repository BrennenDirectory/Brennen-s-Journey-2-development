-- data that represents an object that can be picked up although some can be pushed only

return function(data)
    return {
        homeX = data.homeX or 0,
        homeY = data.homeY or 0,
        canHold = data.canHold or false,
        canThrow = data.canThrow or false,
        minVxForThrow = data.minVxForThrow,
        minVyForThrow = data.minVyForThrow,
        throwForce = data.throwForce,
        throwForceMultiplierX = data.throwForceMultiplierX,
        throwForceMultiplierY = data.throwForceMultiplierY
    }
end