-- handles the player's health, mana.
local player

local function takeDamage(damage, needsStatus)
    player.health = player.health - damage
    if player.health <= 0 then
        player.health = 0
        player.isDead = true
        player.respawn()
    else
        if needsStatus then
            return true -- return true if the player is still alive after taking damage, useful for the KillZone to prevent respawning twice
        end
    end
end

local function drainMana(amount)
    player.mana = player.mana - amount
    if player.mana <= 0 then
        player.mana = 0
    end
end

local function regenerateMana(dt)
    if player.mana < player.maxMana then
        player.mana = player.mana + 1 * dt
    end

    if player.mana > player.maxMana then
        player.mana = player.maxMana
    end
end

return function(playerTab)
    player = playerTab
    return takeDamage, drainMana
end