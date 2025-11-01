local function AllenWrench()
    local allenWrench = Entity()

    allenWrench:addComponents({
        ['weaponData'] = {
            id = "ALLEN_WRENCH",
            name = "Allen Wrench",
            querySize = 32,
            classes = {
                "Breakable", "Enemy" -- TODO: reconfigure a lot of collision classes
            }
        },
        ['damageData'] = {
            damageToEnemies = 1,
            damageToBreakables = 9
        }
    })

    allenWrench.tags.canPersist = true

    return allenWrench
end

return AllenWrench