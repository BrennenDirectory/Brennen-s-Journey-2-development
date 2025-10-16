Crate = class{}

local width, height = 32, 32
local throwForce = 300
local startingMass = 25

local CRATE_HEALTH = 5
local weaponDamageToCrates = 1

-- TODO: add throwForce multiplier for X and Y

function Crate:init(object)
    self.hitbox = world:newBSGRectangleCollider(object.x, object.y, width, height, 2)
    self.hitbox:setType("dynamic")
    self.hitbox:setFixedRotation(true)
    self.hitbox:setRestitution(0)
    self.hitbox:setFriction(0.7) -- change to slide a bit more
    self.hitbox:setMass(startingMass)
    self.hitbox:setCollisionClass("Crate")
    self.hitbox:setObject(self)

    self.canHold = object.properties.CanHold or false
    self.health = CRATE_HEALTH
    self.homeX = object.x
    self.homeY = object.y

    self.weld = nil

end

function Crate:pickup(player)
    local px, py = player.hitbox:getX(), player.hitbox:getY()
    self.hitbox:setMass(0)
    self.hitbox:setX(px)
    self.hitbox:setY(py - height - 4)

    self.weld = world:addJoint("WeldJoint", player.hitbox, self.hitbox, px, py, false)

    px, py = nil, nil
end

function Crate:drop(player)
    self.weld:destroy()
    self.weld = nil

    local offset = player.lastIx == -1 and -width - 4 or width + 4
    self.hitbox:setMass(startingMass)
    self.hitbox:setX(player.hitbox:getX() + offset)
    self.hitbox:setY(player.hitbox:getY())
end

function Crate:throw(player)
    self.weld:destroy()
    self.weld = nil

    self.hitbox:applyLinearImpulse(player.lastIx * throwForce, -throwForce)
    self.hitbox:setMass(startingMass)
end

function Crate:reset()
    self.health = CRATE_HEALTH

    if self.weld then
        self.weld:destroy()
        self.weld = nil
        self.hitbox:setMass(startingMass)
    end

    self.hitbox:setX(self.homeX)
    self.hitbox:setY(self.homeY)
end

function Crate:damage()
    self.health = self.health - weaponDamageToCrates
    if self.health <= 0 then
        self:reset()
    end
end

function Crate:destroy()
    if self.weld then
        self.weld:destroy()
        self.weld = nil
    end

    self.hitbox:destroy()
    self.hitbox = nil
end