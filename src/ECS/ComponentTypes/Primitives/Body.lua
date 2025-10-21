return function(data)
    local w, h, r
    if data.width then
        w = data.width > 0 and data.width or 1
        h = data.height > 0 and data.height or 1
    else
        r = data.radius > 0 and data.radius or 1
    end

    return {
        width = w,
        height = h,
        radius = r
    }
end