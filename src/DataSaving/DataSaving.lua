local DataSaving = {}
local SavedDataTemplate = require"src.DataSaving.SavedDataTemplate"
local SAVE_FILE_NAME = "TestSaveFile1.lua"

-- DO NOT USE THIS MODULE ANYMORE
-- hahaha i dont know what im doing
local function serialize(value)
    local fileData = "return {"
    for key, v in pairs(value) do
        if key ~= "MessageFromDev" then
            fileData = fileData .. "\n\t" .. key .. " = "
            if type(v) == "string" then
                fileData = fileData .. string.format("%q", v)
            elseif type(v) == "table" then
                fileData = fileData .. "{\n"
                for id, _ in pairs(v) do
                    if not tonumber(id) then
                        fileData = fileData .. "\t\t".. id .. " = true"
                    else
                        fileData = fileData .. "\t\t[" .. id .. "] = true"
                    end

                    if next(v, id) then
                        fileData = fileData .. ",\n"
                    end
                end
                fileData = fileData .. "\n\t}"
            elseif type(v) == "boolean" then
                fileData = fileData .. tostring(v)
            else
                fileData = fileData .. v
            end
            fileData = fileData .. ",\n"
        end
    end
    fileData = fileData .. "\n\tMessageFromDev = \"Modify with Caution. The saving/loading code is bad :(.\"\n}"
    return fileData
end

local function reconcile(data)
    for key, value in pairs(SavedDataTemplate) do
        if not data[key] then
            data[key] = value
        end
    end
end

function DataSaving.Save()
    if true then
        return
    end

    local fileInfo = love.filesystem.getInfo(SAVE_FILE_NAME)
    if fileInfo then
        reconcile(_G.PlayerSaveData)
       love.filesystem.write(SAVE_FILE_NAME, serialize(_G.PlayerSaveData))
       fileInfo = nil
    else
        _G.PlayerSaveData = SavedDataTemplate

        local file = love.filesystem.newFile(SAVE_FILE_NAME)
        file:open("w")
        file:write(serialize(_G.PlayerSaveData))
        file:close()

        file = nil
    end
end

function DataSaving.Load()
    local file, errorMsg = love.filesystem.load(SAVE_FILE_NAME)
    if file then
        _G.PlayerSaveData = file()
        file = nil
    else
        print("unable to load saved data.", errorMsg)
        _G.PlayerSaveData = SavedDataTemplate
    end
end

return DataSaving