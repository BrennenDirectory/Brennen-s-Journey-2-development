require"src.ECS.SystemTypes.HeldObjects.HeldObjectBehavior"
require"src.ECS.SystemTypes.HeldObjects.HeldObjectControls"
require"src.ECS.SystemTypes.Spatial.HitboxSpatialChecks"
require"src.ECS.SystemTypes.Spatial.InteractWithObjects"
require"src.ECS.SystemTypes.JumpMovementModule"
require"src.ECS.SystemTypes.KnockbackBehavior"
require"src.ECS.SystemTypes.HealthBehavior"
require"src.ECS.SystemTypes.EntitySerialization"
require"src.ECS.SystemTypes.Input.WeaponControls"
require"src.ECS.SystemTypes.HitResponses"
require"src.ECS.SystemTypes.CameraBehavior"
require"src.ECS.SystemTypes.Spatial.HitboxCollisions"
require"src.ECS.SystemTypes.Events.ScriptedEvents"
require"src.ECS.SystemTypes.Physics.PlatformBehavior"

return {
    heldObjectBehavior = HeldObjectBehavior,
    heldObjectWeld = require"src.ECS.SystemTypes.HeldObjects.HeldObjectWeld",
    heldObjectControls = HeldObjectControls,
    hitboxSpatialChecks = HitboxSpatialChecks,
    interactWithObjects = InteractWithObjects,
    movementModule = require"src.ECS.SystemTypes.MovementModule",
    inputModule = require"src.ECS.SystemTypes.Input.InputModule",
    jumpMovementModule = JumpMovementModule,
    sprintModule = require"src.ECS.SystemTypes.SprintModule",
    knockbackBehavior = KnockbackBehavior,
    healthBehavior = HealthBehavior,
    entitySerialization = EntitySerialization,
    weaponControls = WeaponControls,
    hitResponses = HitResponses,
    cameraBehavior = CameraBehavior,
    hitboxCollisions = HitboxCollisions,
    scriptedEvents = ScriptedEvents,
    interactableBehavior = require"src.ECS.SystemTypes.Events.InteractableBehavior",
    entityCreation = require"src.ECS.SystemTypes.Events.EntityCreation",
    entitySignal = require"src.ECS.SystemTypes.Events.EntitySignals",
    hitboxInit = require"src.ECS.SystemTypes.Events.HitboxInit",
    platformBehavior = PlatformBehavior
}