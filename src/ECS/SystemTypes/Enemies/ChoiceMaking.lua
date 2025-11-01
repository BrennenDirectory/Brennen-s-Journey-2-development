_G.ChoiceMaking = class{}
-- For now, each choice has an equal chance to be picked.
function ChoiceMaking:init(entity)
    self.entity = entity
    self.choiceData = entity.components.choiceData
    self.timer = self.choiceData.timer
    self.delay = self.choiceData.delay

    self.timer:every(self.delay, function()
        self:random()
    end)
end

function ChoiceMaking:update(dt)
    if self.choiceData.canMakeChoices then
        self.timer:update(dt)
    end
end

function ChoiceMaking:remove()
    self.timer:clear()
    self.timer = nil
end

function ChoiceMaking:random()
    local randomChoice = math.random(1, #self.choiceData.choices)
    self.choiceData.choice = self.choiceData.choices[randomChoice]
    self.choiceData.onChoiceMade(self.entity, self.choiceData.choice)
end