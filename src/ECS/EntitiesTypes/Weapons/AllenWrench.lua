local function AllenWrench()
    local allenWrench = Entity()

    allenWrench:addComponents({
        ['weaponData'] = {
            id = "ALLEN_WRENCH",
            name = "Allen Wrench",
            damageToEnemies = 1,
            damageToBreakables = 9,
            querySize = 32,
            classes = {
                "Breakable", "Enemy" -- TODO: reconfigure a lot of collision classes
            }
        }
    })

    return allenWrench
end

return AllenWrench