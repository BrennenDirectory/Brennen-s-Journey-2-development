local player = {}
local hitbox
local controls, movement, spellHandler, collisions
local weaponControls
local abilityHandler

local image = love.graphics.newImage("src/gfx/player/brennen.jpg")

local size = 32
local HITBOX_CORNER_CUT_SIZE = 5

function player:load()
    -- local camera = require"src.lib.camera"
    -- self.camera = camera()
    hitbox = world:newBSGRectangleCollider(128, -128, size, size, HITBOX_CORNER_CUT_SIZE)
    hitbox:setType("dynamic")
    hitbox:setFixedRotation(true)
    hitbox:setRestitution(0)
    hitbox:setFriction(0.5)
    hitbox:setLinearDamping(1)
    hitbox:setCollisionClass("Player")

    self.maxHealth = 6
    self.maxMana = 6
    self.health = self.maxHealth
    self.mana = self.maxMana

    self.level = 1
    self.xp = 0
    self.xpToLevel = 100
    self.taceyBucks = 0

    self.heldCrateSpeed = 8000
    self.walkSpeed = 10000
    self.sprintSpeed = 18000
    self.speed = self.walkSpeed
    self.jumpPower = 800
    self.lastIx = 1

    self.isHoldingCrate = false
    self.isBeingKnocked = false
    self.isDead = false
    
    -- the hitbox x and y are at the center of the object
    self.hitbox = hitbox

    self.ability = require"src.Player.abilities.gravelBomb" --nil -- the currently equipped ability
    self.abilities = {}
    self.spell = nil -- the currently equipped spell
    self.spells = {}
    self.weapon = nil -- the currently equipped weapon
    self.weapons = {}
    self.respawnPoint = {x = 0, y = 0, tiledID = 0}

    self.hud = require"src.Player.hud.playerHud"

    controls = require"src.Player.modules.controls"(self, 0)
    movement = require"src.Player.modules.controls"(1)
    weaponControls = require"src.Player.modules.weaponControls"(self)
    collisions, self.knockback = require"src.Player.modules.collisions"(self)

    spellHandler = require"src.Player.modules.spellHandler"(self)
    abilityHandler = require"src.Player.modules.abilityHandler"

    self.respawn = function(fromKillZone)
        Signal.emit("PlayerRespawned", true)
        if not fromKillZone then
            self.isDead = false
            self.health = self.maxHealth
            self.mana = self.maxMana
        end

        if player.ability and player.ability.onPlayerStateChange then
            player.ability:onPlayerStateChange()
        end

        self.setPosition(self.respawnPoint.x, self.respawnPoint.y)
    end

    self.takeDamage, self.drainMana = require"src.Player.modules.status"(self)
    self.leveling = require"src.Player.status.leveling"(self)

    self.setPosition = function(x, y)
        self.hitbox:setX(x)
        self.hitbox:setY(y)
    end

    self.getPosition = function()
        return self.hitbox:getX(), self.hitbox:getY()
    end

    require"src.Player.modules.loadingFromSaveData"

    --self.camera:zoomTo(2)
end

function player:update(dt)
    --self.camera:lookAt(self.hitbox:getX(), self.hitbox:getY())
    controls()
    spellHandler.update()
    abilityHandler.update(dt)
    movement(dt)
    collisions(dt)
end

function player:draw()
    love.graphics.draw(image, self.hitbox:getX(), self.hitbox:getY(), nil, size/image:getWidth(), size/image:getWidth(), image:getWidth()/2, image:getHeight()/2)
end

function player:mousepressed(x, y, button)
    if button == 1 then
        weaponControls()
    end

    if button == 2 then
        local nx, ny = self.camera:mousePosition()
        self.hitbox:setX(nx)
        self.hitbox:setY(ny)
    end
end

return player