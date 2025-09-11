function UpdateAll(dt)
    for i, update in pairs(_G.UpdateTable) do
        update(dt)
    end
end

function DrawAll()
    for i, draw in pairs(_G.DrawTable) do
        draw()
    end
end