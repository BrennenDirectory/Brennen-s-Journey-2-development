_G.Chest = class{}

local conf = {
    width = 48,
    height = 38,
    closed = {
        img = love.graphics.newImage("src/gfx/interact/chest.png"),
        drawYOffset = 12
    },
    open = {
        img = love.graphics.newImage("src/gfx/interact/chest_opened.png"),
        drawXOffset = 4,
        drawYOffset = 1,
        scaleMultiplier = 1.4
    }
}

local closed, open = conf.closed, conf.open

closed.scaleX = conf.width / closed.img:getWidth()
closed.scaleY = conf.height / closed.img:getHeight()
closed.offsetX = closed.img:getWidth() / 2
closed.offsetY = closed.img:getHeight() / 2

open.scaleX = conf.width * open.scaleMultiplier / open.img:getWidth()
open.scaleY = conf.height * open.scaleMultiplier / open.img:getHeight()
open.offsetX = open.img:getWidth() / 2
open.offsetY = open.img:getHeight() / 2

local Chests = require"src.MapLoading.Interact.Chests"
local player = require"src.Player.player"

--[[
    Loot available from Chests:
    Tacey Bucks (Currency)
    Weapon
    XP
    Armor? (maybe)
    Key?
]]

local LootTypeFunctions = {
    ['Weapon'] = function(chest)
        
    end,
    ['TaceyBucks'] = function(chest)
        print("$$$$$")
    end
}

function Chest:init(object, openedByPlayer)
    self.direction = object.properties.Direction -- Direction in which it faces when opened (-1 or 1)

    self.hitbox = world:newRectangleCollider(object.x, object.y, conf.width, conf.height)
    self.hitbox:setType("static")
    self.hitbox:setCollisionClass("Chest")
    self.hitbox:setFriction(0)
    self.hitbox:setObject(self)

    self.drawX = self.hitbox:getX()
    self.drawY = self.hitbox:getY()

    self.id = object.id
    self.isOpen = openedByPlayer

    if not self.isOpen then
        self.onInteract = LootTypeFunctions[object.properties.LootType]
        self.drawY = self.drawY + closed.drawYOffset
    else
        self.drawX = self.drawX + open.drawXOffset
        self.drawY = self.drawY + open.drawYOffset
    end
end

function Chest:render()
    if not self.isOpen then
        love.graphics.draw(closed.img, self.drawX, self.drawY, nil, self.direction * closed.scaleX, closed.scaleY, closed.offsetX, closed.offsetY)
    else
        love.graphics.draw(open.img, self.drawX, self.drawY, nil, self.direction * open.scaleX, open.scaleY, open.offsetX, open.offsetY)
    end
end

function Chest:interact()
    self.isOpen = true
    self:onInteract()
    self:reAssignDrawPosition()
    Chests.addToOpened(self.id)
end

function Chest:destroy()
    self.hitbox:destroy()
    self.hitbox = nil
    self.onInteract = nil
end

function Chest:reAssignDrawPosition()
    self.drawX = self.hitbox:getX() + open.drawXOffset
    self.drawY = self.hitbox:getY() + open.drawYOffset
end