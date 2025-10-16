return function(data)
    return {
        health = data.maxHealth,
        maxHealth = data.maxHealth,
        canRespawn = data.canRespawn,
        flagForRemovalOnDeath = data.flagForRemovalOnDeath or false,
        onDeathEvent = data.onDeathEvent
    }
end