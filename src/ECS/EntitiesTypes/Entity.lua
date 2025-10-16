local Components = require"src.ECS.Components"
local Systems = require"src.ECS.Systems"

_G.Entity = class{}

function Entity:init()
    self.components = {}
    self.systems = {}
    self.tags = {}

    self.flagForRemoval = false
end

function Entity:addComponents(components)
    for component, data in pairs(components) do
        self.components[component] = Components[component](data)
    end
end

function Entity:addSystems(systems)
    for i, system in ipairs(systems) do
        self.systems[system] = Systems[system](self)
    end
end

function Entity:destroy()
    self.flagForRemoval = true

    if self.components.hitbox then
        self.components.hitbox:destroy()
    end

    for component, data in pairs(self.components) do
        self.components[component] = nil
    end

    for system, data in pairs(self.systems) do
        if self.systems[system].remove then
            self.systems[system]:remove()
        end

        self.systems[system] = nil
    end

    for tag, data in pairs(self.tags) do
        self.tags[tag] = nil
    end
end
