local MapLoading = require"src.MapLoading.MapLoading"
local PATH_TO_MAPS = "src.TiledProject.Tilemaps."
local PATH_TO_DRAW_MAPS = "src/TiledProject/Tilemaps/"
local player = require"src.Player.player"

local GameMapManip = {
    isEnabled = true,
    Text = ""
}

local mapOptions = {
    "1/1-1",
    "1/1-2",
    "1/1-3",
    "1/1-4",
    "1/1-5",
    "1/1-6",
    "1/1-7",
    "1/1-8",
    "2/2-1",
    "2/2-2",
    "2/2-3"
}

--local MAP_OPTION_WIDTH = 128
local MAP_OPTION_HEIGHT = 32
local MAP_OPTIONS_WIDTH = 160
local MAP_OPTIONS_HEIGHT = #mapOptions * MAP_OPTION_HEIGHT

local function loadMap(map)
    print("Set the current map to: " .. map)
    MapLoading.DestroyMap()
    MapLoading.CurrentMap = require(PATH_TO_MAPS .. map)
    MapLoading.DrawableMap = sti(PATH_TO_DRAW_MAPS .. map .. ".lua")
    MapLoading.CreateMap()
    player.setPosition(0, 0)
end

function GameMapManip.drawUI()
    love.graphics.setNewFont(22)
    love.graphics.setColor(0, 0, 0, 0)
    love.graphics.rectangle("fill", _G.WinWidth - MAP_OPTIONS_WIDTH, 0, MAP_OPTIONS_WIDTH, MAP_OPTIONS_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1)
    for i, map in ipairs(mapOptions) do
        love.graphics.print(map, _G.WinWidth - MAP_OPTIONS_WIDTH, i * MAP_OPTION_HEIGHT)
    end
end

function GameMapManip.mousepressed(x, y, button)
    for i, map in ipairs(mapOptions) do
        if x > _G.WinWidth - MAP_OPTIONS_WIDTH and x < _G.WinWidth then
            if y > i * MAP_OPTION_HEIGHT and y < i * MAP_OPTION_HEIGHT + MAP_OPTION_HEIGHT then
                loadMap(map)
                break
            end
        end
    end
end

return GameMapManip