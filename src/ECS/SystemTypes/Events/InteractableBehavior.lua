-- Used for entities with simple methods that can be called on interact.
return function(entity)
    local interactableBehavior = {
        entity = entity,
        interactableData = entity.components.interactableData
    }

    assert(not entity.tags.systemForInteracting, "Cannot have more than 1 system for interacting.")
 
    entity.tags.systemForInteracting = "interactableBehavior"
    entity.tags.canInteractWith = true
    entity.components.hitbox:setObject(entity)

    function interactableBehavior:interact(otherEntity)
        self.interactableData.onInteract(self.entity, otherEntity)
    end

    return interactableBehavior
end