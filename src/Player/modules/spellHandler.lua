local player
local spellHandler = {}

function spellHandler.update()
    if player.spell then
        player.spell.update(player)
    end
end

local function hasEnoughMana()
    if player.mana - player.spell.manaCost > 0 then
        player.drainMana(player.spell.manaCost)
        return true
    else
        return false
    end
end

local function canUseSpell()
    if not player.isHoldingCrate and player.spell ~= nil then
        --if hasEnoughMana() then
            return true
        --end
    end
    return false
end

return function(playerTab)
    player = playerTab
    Signal.register("CastSpell", function()
            if canUseSpell() then
                player.spell.cast(player)
            end
        end)
    --[[
    before casting the spell,
        change later to check for conditions such as:
        if the player is holding a crate, in a cutscene, other animation, etc.
    ]]
    return spellHandler
end
