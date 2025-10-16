local DataSaving = require"src.Modules.DataSaving"

_G.EntitySerialization = class{}

function EntitySerialization:init(entity)
    self.entity = entity

    self.saveData = entity.components.saveData
end

function EntitySerialization:saveEntityData() -- call when, for example: when the entity hits a checkpoint or respawn area etc.
    DataSaving.saveDataToFile(self.saveData.content, self.saveData.template, self.saveData.fileName)
end

function EntitySerialization:loadEntityData() -- can be called when the entity has all of its systems and components loaded
    self.saveData.content = DataSaving.loadDataFromFile(self.saveData.fileName, self.saveData.returnChunk)
    -- then manually assign the data in the entity
end