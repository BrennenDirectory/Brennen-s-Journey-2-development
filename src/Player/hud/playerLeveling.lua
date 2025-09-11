local levelingHud = {}

local isXPBarVisible = false
local gainedXPBarTimer = Timer.new()
local gainedXPBarFadeTime = 3

local XPBarWidth = 256
local XPBarHeight = 64

local InnerXPBarWidth = XPBarWidth - 8
local InnerXPBarHeight = XPBarHeight - 8

local function drawXPBar()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle("fill", 500, 500, XPBarWidth, XPBarHeight)
    love.graphics.setColor(0.3, 1, 0, 1)
    love.graphics.rectangle("fill", 500, 500, InnerXPBarWidth, InnerXPBarHeight)
    love.graphics.setColor(1, 1, 1, 1)
end

-- TODO: add draw skill upgrade gui
-- Skills: +1 heart (+2 to value), more mana, more weapon damage, more spell damage

function levelingHud.update(dt)
    gainedXPBarTimer:update(dt)
end

function levelingHud.draw()
    if isXPBarVisible then
        drawXPBar()
    end
end

Signal.register("PlayerGainedXP", function(amount) -- surplusAmount?
    isXPBarVisible = true
    gainedXPBarTimer:after(gainedXPBarFadeTime, function()
        isXPBarVisible = false
    end)
end)

return levelingHud