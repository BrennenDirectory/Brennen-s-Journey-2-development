require"src.ECS.EntitiesTypes.Entity"

return {
    Player = require"src.ECS.EntitiesTypes.Player",
    Crate = require"src.ECS.EntitiesTypes.Interact.Crate",
    AllenWrench = require"src.ECS.EntitiesTypes.Weapons.AllenWrench",
    Trigger = require"src.ECS.EntitiesTypes.Interact.Trigger",
    Zone = require"src.ECS.EntitiesTypes.Interact.Zone",
    Passage = require"src.ECS.EntitiesTypes.Interact.Passage",
    Breakable = require"src.ECS.EntitiesTypes.Breakable",
    RespawnPoint = require"src.ECS.EntitiesTypes.Interact.RespawnPoint",
    Platform = require"src.ECS.EntitiesTypes.Physics.Platform"
}