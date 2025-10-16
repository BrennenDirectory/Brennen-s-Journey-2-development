-- Intended for the Player entity to use
_G.WeaponControls = class{}

function WeaponControls:init(entity)
    assert(entity.components.inventory, "Entity requires Inventory component.")

    self.entity = entity

    if entity.components.inventory.equippedWeapon then
        self.weaponData = entity.components.inventory.equippedWeapon.weaponData
        self.querySize = self.weaponData.querySize
    end


    self.hitbox = entity.components.hitbox
    self.direction = 0
end

function WeaponControls:update(dt)
    --add timer later and update self.direction
    if Input:pressed("useWeapon") then
        self:mousepressed()
    end
end

function WeaponControls:assignWeaponData()
    self.weaponData = self.entity.components.inventory.equippedWeapon.weaponData
    self.querySize = self.weaponData.querySize
end

function WeaponControls:mousepressed()
    if not self.entity.components.inventory.equippedWeapon then
        return
    end

    self.direction = self.entity.components.position.directionX

    local x, y = self.hitbox:getX(), self.hitbox:getY()
    local offsetX = self.direction == -1 and -self.querySize / 2 or self.querySize / 2

    local entities = world:queryCircleArea(x + offsetX, y, self.querySize, self.weaponData.classes)
    if #entities > 0 then
        for i, entity in ipairs(entities) do
            entity.systems.hitResponses:takeHit(entity)
        end
    end
end