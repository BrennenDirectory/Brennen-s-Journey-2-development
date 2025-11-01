_G.StateMachine = class{}

function StateMachine:init(entity)
    self.entity = entity
    self.stateData = entity.components.stateData
end

function StateMachine:set(state)
    if not self.stateData.states[state] then
        print(state, "does not exist in states for", self.entity)
    else
        self.stateData.state = state
    end
end

function StateMachine:get()
    return self.stateData.state
end