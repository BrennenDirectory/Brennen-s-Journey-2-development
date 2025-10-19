_G.ScriptedEvents = class{}

local ROOT = "src/"
local EVENTS = "ScriptedEvents/"

function ScriptedEvents:init(entity)
    self.entity = entity
    self.scriptData = entity.components.scriptData

    local path = self.scriptData.path
    local start, stop = path:find(EVENTS)
    local subDir = path:sub(stop + 1, path:len())

    self.script = ROOT .. EVENTS.. subDir

    self.returnedData = {}
end

function ScriptedEvents:execute(otherEntity)
    local funcOrError = dofile(self.script)
    if not funcOrError then
        print(funcOrError)
    else
        if type(funcOrError) ~= "function" then
            print(tostring(funcOrError) .. " is not a function")
        else
            local data = {funcOrError(self.entity, otherEntity)}
            if #data == 0 then
                return
            elseif #data == 1 then
                self.returnedData = data[1]
            else
                self.returnedData = data
            end
        end
    end
end