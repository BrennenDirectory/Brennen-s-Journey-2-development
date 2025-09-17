require"src.ECS.SystemTypes.HeldObjectBehavior"
require"src.ECS.SystemTypes.HeldObjectControls"
require"src.ECS.SystemTypes.HitboxSpatialChecks"
require"src.ECS.SystemTypes.InteractWithObjects"

return {
    heldObjectBehavior = HeldObjectBehavior,
    heldObjectWeld = require"src.ECS.SystemTypes.HeldObjectWeld",
    heldObjectControls = HeldObjectControls,
    hitboxSpatialChecks = HitboxSpatialChecks,
    interactWithObjects = InteractWithObjects,
    movementModule = require"src.ECS.SystemTypes.MovementModule"
}