-- A module that controls how an Entity responds to an responding/incoming attack or damage source, not the same as collision events.
_G.HitResponses = class{}

function HitResponses:init(entity)
    self.entity = entity
end

function HitResponses:takeHit(otherEntity)
    
end