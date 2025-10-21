return function(data)
    local str = data.damageSources
    local damageSources = {}

    for damageSource in str:gmatch("%a+") do
        table.insert(damageSources, damageSource)
    end

    return {
        damageSources = #damageSources > 0 and damageSources or "Any"
    }
end