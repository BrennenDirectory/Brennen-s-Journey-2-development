local defaultPosition = 0
return function(data)
    local hitbox

    if data.cornerCutSize then
        hitbox = world:newBSGRectangleCollider(defaultPosition, defaultPosition, data.width, data.height, data.cornerCutSize)
    elseif data.width then
        hitbox = world:newRectangleCollider(defaultPosition, defaultPosition, data.width, data.height)
    elseif data.radius then
        hitbox = world:newCircleCollider(defaultPosition, defaultPosition, data.radius)
    end

    if data.collisionClass then
        hitbox:setCollisionClass(data.collisionClass)
    end

    hitbox:setType(data.type)
    hitbox:setFriction(data.friction)
    hitbox:setFixedRotation(data.hasFixedRotation)
    hitbox:setRestitution(data.restitution or 0)

    if data.mass then
        hitbox:setMass(data.mass)
    end

    hitbox:setLinearDamping(data.linearDamping or 0)

    return hitbox
end