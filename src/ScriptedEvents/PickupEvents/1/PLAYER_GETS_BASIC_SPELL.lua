-- This script gives the Player the Basic Spell and spawns a Trigger behind them.

local player = require"src.Player.player"
player.spells.basicSpell = require"src.Player.spells.basicSpell"
player.spell = player.spells.basicSpell
--_G.PlayerSaveData.CollectibleIDs["BASIC_SPELL"] = true
player = nil

local Triggers = require"src.MapLoading.Interact.Triggers"

local TriggerData = {
    x = 832,
    y = 768,
    height = 320,
    properties = {
        IsFromTiled = false,
        Script = "1/MINION_APPEARANCE.lua"
    }
}

Triggers.new(TriggerData)

TriggerData, Triggers = nil, nil