local player = require"src.Player.player"
local Spells = require"src.Player.spells.Spells"
local Weapons = require"src.Player.weapons.Weapons"

local function setSpellsFromLoad()
   for id, _ in pairs(_G.PlayerSaveData.OwnedSpells) do
        player.spells[id] = Spells[id]
   end

    player.spell = Spells[_G.PlayerSaveData.EquippedSpell]
end

local function setWeaponsFromLoad()
    for id, _ in pairs(_G.PlayerSaveData.OwnedWeapons) do
        player.weapons[id] = Weapons[id]
    end

    player.weapon = Weapons[_G.PlayerSaveData.EquippedWeapon]
end

Signal.register("LoadedPlayerData", function()
    setSpellsFromLoad()
    setWeaponsFromLoad()
end)