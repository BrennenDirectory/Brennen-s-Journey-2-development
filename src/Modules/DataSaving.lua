local DataSaving = {}

local parser = {
    ['string'] = function(value)
        return string.format("%q", value)
    end,
    ['table'] = function(value)
        return DataSaving.tableToString(value)
    end,
    ['boolean'] = function(value)
        return tostring(value)
    end,
    ['number'] = function(value)
        return value
    end
}

local function serialize(dataTable)
    local content = "return {\n\t"

    for key, value in pairs(dataTable) do
        assert(tonumber(key) or type(key) == "string", "Table key must be a string or numeric value.")
        content = content .. key .. " = " .. parser[type(value)](value)
        if next(dataTable, key) then
            content = content .. ",\n\t"
        end
    end

    return content .. "\n}"
end

local function reconcile(dataTable, template)
    for key, value in pairs(template) do
        if not dataTable[key] then
            dataTable[key] = value
        end
    end
end

function DataSaving.saveDataToFile(dataTable, template, fileName)
    local fileInfo = love.filesystem.getInfo(fileName)
    if fileInfo then
        reconcile(dataTable, template)

        local dataToSave = serialize(dataTable)

        love.filesystem.write(fileName, dataToSave)
    else
        local file = love.filesystem.newFile(fileName)
        local content = serialize(dataTable)
        file:open("w")
        file:write(content) -- serialize the content before writing incase errors arise mid write
        file:close()
    end
end

-- (fileName: string, returnChunk: boolean)
-- returns the unexecuted chunk is returnChunk is true
function DataSaving.loadDataFromFile(fileName, returnChunk)
    local file, errorMsg = love.filesystem.load(fileName)
    if file then
        if returnChunk then
            return file
        else
            return file()
        end
    else
        print("Unable to load data", errorMsg)
    end
end

function DataSaving.tableToString(tab)
    local str = "{\n"

    for key, value in pairs(tab) do
        str = str .. "\t\t"
        if tonumber(key) then
            str = str .. '[' .. key .. "] = "
        elseif type(key) == "string" then
            str = str .. "[\"" .. key .. "\"] = "
        else
            error("Table key must be a string or numeric value.")
        end

        if type(value) == "userdata" or type(value) == "function" or type(value) == "thread" then
            error("Table value must be string, bool, table, or number.")
        end

        if type(value) == "table" then
            local tabContent = DataSaving.tableToString(value)
            str = str .. tabContent
        else
            str = str .. parser[type(value)](value)
        end

        if next(tab, key) then
            str = str .. ",\n"
        end
    end

    str = str .. "\n\t}"
    return str
end

return DataSaving