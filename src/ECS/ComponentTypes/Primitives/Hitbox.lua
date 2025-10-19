local defaultPosition = 0
return function(data)
    local hitbox
    local startPosition = {
        x = data.x or 0,
        y = data.y or 0
    }
    if data.cornerCutSize then
        hitbox = world:newBSGRectangleCollider(startPosition.x, startPosition.y, data.width, data.height, data.cornerCutSize)
    elseif data.width then
        hitbox = world:newRectangleCollider(startPosition.x, startPosition.y, data.width, data.height)
    elseif data.radius then
        hitbox = world:newCircleCollider(startPosition.x, startPosition.y, data.radius)
    end

    if data.collisionClass then
        hitbox:setCollisionClass(data.collisionClass)
    end

    hitbox:setType(data.type)
    hitbox:setFriction(data.friction or hitbox:getFriction())
    hitbox:setFixedRotation(data.hasFixedRotation)
    hitbox:setRestitution(data.restitution or hitbox:getRestitution())
    hitbox:setMass(data.mass or hitbox:getMass())
    hitbox:setLinearDamping(data.linearDamping or hitbox:getLinearDamping())

    return hitbox
end