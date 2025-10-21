return function(entity)
    local hitboxInit = {
        entity = entity,
        hitbox = entity.components.hitbox
    }

    entity.components.hitbox:setObject(entity)

    function hitboxInit:remove()
        self.hitbox:destroy()
        self.entity.components.hitbox = nil
    end

    return hitboxInit
end