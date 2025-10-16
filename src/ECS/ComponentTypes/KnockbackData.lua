return function(data)
    return {
        minForce = data.minForce,
        maxForce = data.maxForce,
        forceMultiplierX = data.forceMultiplierX,
        forceMultiplierY = data.forceMultiplierY,
        timer = Timer.new(),
        delayAmount = data.delayAmount
    }
end