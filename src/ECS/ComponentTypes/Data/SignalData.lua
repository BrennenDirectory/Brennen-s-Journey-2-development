return function(data) -- Signal usage like this should be kept to a minimum
    return {
        name = data.name,
        signalBody = data.signalBody
    }
end