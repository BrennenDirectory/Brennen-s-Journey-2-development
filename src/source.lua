local source = {}
local player
local Enemies
local MapLoading
local DataSaving -- might choose to NOT save on application exit.

function source.load()
    local baton = require"src.lib.baton"
    local windfield = require("src.lib.windfield")
    _G.UpdateTable = {}
    _G.DrawTable = {}
    _G.world = windfield.newWorld(0, 0, true)
    _G.Input = baton.new{
        controls = {
            left = {"key:a"},
            right = {"key:d"},
            jump = {"key:space"},
            interact = {"key:e"},
            sprint = {"key:lshift"},
            useAbility = {"key:r"} -- here just so i can perform input:presses
        }
    }
    _G.Signal = require"src.lib.signal"
    _G.Timer = require"src.lib.timer"
    _G.lume = require"src.lib.lume"
    _G.class = require"src.lib.class"
    _G.sti = require"src.lib.sti"
    _G.WinWidth = 1280
    _G.WinHeight = 720
    _G.PlayerSaveData = require"src.DataSaving.SavedDataTemplate" -- {}
    _G.Debug = require"src.Debug.Debug"

    -- object classes
    require"src.Classes.PhysicsObjects.Crate"
    require"src.Classes.PhysicsObjects.MovingPlatform"
    require"src.Classes.PhysicsObjects.SwingingPlatform"
    require"src.Classes.Interact.Pickup"
    require"src.Classes.Interact.Trigger"
    require"src.Classes.Interact.Gate"
    require"src.Classes.Interact.Chest"
    require"src.Classes.Misc.HealthBottle"

    -- enemy classes
    require"src.EnemyClasses.Glorp"
    require"src.EnemyClasses.Bat"
    require"src.EnemyClasses.Shooter"
    require"src.EnemyClasses.Snapper"

    world:setGravity(0, 1024)
    world:setQueryDebugDrawing(true)
    world:setExplicitCollisionEvents(true)

    require"src.MapLoading.CollisionClasses"

    player = require"src.Player.player"
    player:load()


    require"src.UpdateAndDrawLoop.UpdateAndDrawLoops"

    Enemies = require"src.EnemyClasses.Enemies"

    DataSaving = require"src.DataSaving.DataSaving"
    --DataSaving.Load()

    MapLoading = require"src.MapLoading.MapLoading"
    MapLoading.CreateMap()
end

function source.update(dt)
    Input:update()
    Enemies.update(dt)
    player:update(dt)
    player.hud.update(dt)
    UpdateAll(dt)
    world:update(dt)
    Debug.update(dt)
end

function source.draw()
    love.graphics.clear(0.5, 0.5, 0)
    player.camera:attach()
        DrawAll()
        if Debug.isEnabled then
            world:draw()
        end
        
        player:draw()
        Enemies.render()
        Debug.drawInsideCamera()
    player.camera:detach()
    player.hud.draw()
    Debug.draw()
end

function source.resize(width, height)
    _G.WinWidth = width
    _G.WinHeight = height
end

function source.keypressed(key, scancode, isrepeat)
    -- change later to only fire in Playing state
    if key == "f" then
        Signal.emit("CastSpell")
    end

    if key == "g" then
        local mx, my = player.camera:mousePosition()
        local query = world:queryCircleArea(mx, my, 16, {"All"})
        if #query > 0 then
            for i, object in ipairs(query) do
                if object.collision_class then
                    print(object.collision_class)
                end
            end
        end

    end
    Debug.keypressed(key, scancode, isrepeat)
end

function source.mousepressed(x, y, button)
    player:mousepressed(x, y, button)
    Debug.mousepressed(x, y, button)
end

function source.textinput(t)
    Debug.textinput(t)
end

function source.quit()
    DataSaving.Save()
end

return source