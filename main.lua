_G.love = require("love")
local source
function love.load()
    source = require("src.source")
    source.load()
    math.randomseed(os.time())
end

function love.update(dt)
    if dt > 1 then
        return
    end
    source.update(dt)
end

function love.draw()
    source.draw()
end

function love.resize(width, height)
    source.resize(width, height)
end

function love.keypressed(key, scancode, isrepeat)
    source.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end
end

function love.mousepressed(x, y, button)
    source.mousepressed(x, y, button)
end

function love.textinput(t)
    source.textinput(t)
end

function love.quit()
    source.quit()
end