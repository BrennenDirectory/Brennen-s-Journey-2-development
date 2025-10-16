_G.HealthBehavior = class{}

function HealthBehavior:init(entity)
    self.entity = entity
    self.healthData = entity.components.healthData
end

function HealthBehavior:takeDamage(amount)
    self.healthData.health = self.healthData.health - amount
    if self.healthData.health <= 0 then
        if self.healthData.canRespawn then
            --self.entity.systems.respawnBehavior:respawnEntity()
            self.healthData.health = self.healthData.maxHealth
        end
    end
end

function HealthBehavior:increaseHealth(amount)
    self.healthData.health = self.healthData.health + amount
    if self.healthData.health > self.healthData.maxHealth then
        self.healthData.health = self.healthData.maxHealth
    end
end