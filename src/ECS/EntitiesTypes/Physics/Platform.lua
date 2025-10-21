--[[
    <<Types of Platforms>>
    [] Falling Platform
    [] Swinging Platform
    [] Moving Platform
    [] Rotating Platform?

]]

local function Platform(TiledObject)
    local platform = Entity()

    local components = {
        ['hitbox'] = {
            width = TiledObject.width,
            height = TiledObject.height,
            x = TiledObject.x,
            y = TiledObject.y,
            collisionClass = "Ground", -- Only the top piece ontop of the hitbox is the collision class
            type = "dynamic",
            hasFixedRotation = true,
            friction = 0
        },
        body = {
            width = TiledObject.width,
            height = TiledObject.height
        }
    }

    local systems = {}

    platform:addComponents(components)
    platform:addSystems(systems)

    return platform
end

return Platform