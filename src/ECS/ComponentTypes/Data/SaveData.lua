return function(data)
    return {
        fileName = data.fileName,
        content = data.content or {},
        template = data.template,
        returnChunk = data.returnChunk or false
    }
end