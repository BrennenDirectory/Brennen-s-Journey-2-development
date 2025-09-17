return function(data)
    if data.radius then
        return {
            radius = data.radius
        }
    elseif data.width then
        return {
            width = data.width,
            height = data.height
        }
    end
end