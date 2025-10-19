return function(data)
    return {
        -- Does not currently support pre or post collision events.
        onEnterClasses = data.onEnterClasses,
        onExitClasses = data.onExitClasses,
        onStayClasses = data.onStayClasses,

        onEnterEvent = data.onEnterEvent,
        onExitEvent = data.onExitEvent,
        onStayEvent = data.onStayEvent
    }
end